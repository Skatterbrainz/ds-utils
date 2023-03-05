function Get-RegistryValue {
	<#
	.SYNOPSIS
		Get-RegistryValue
	.DESCRIPTION
		Export remote registry values
	.PARAMETER KeyPath
		Required. Registry path in PSProvider format (e.g. HKLM:SOFTWARE, not HKEY_LOCAL_MACHINE\SOFTWARE)
	.PARAMETER ValueName
		Required. Name of Registry value
	.PARAMETER ComputerName
		Optional. Names of one or more computers (comma-delimited)
	.PARAMETER InputFile
		Optional. Path\Name of file containing computer names to query
	.PARAMETER ADGridSelect
		Optional. Prompt user to select computers read in from AD using a gridview listmenu
	.EXAMPLE
		$key = "HKLM:SYSTEM\CurrentControlSet\Control\SystemInformation"
		$val = "BIOSVersion"
		Get-RegistryValue -KeyPath $key -ValueName $val -ADGridSelect
	.EXAMPLE
		$key = "HKLM:SYSTEM\CurrentControlSet\Control\SystemInformation"
		$val = "BIOSVersion"
		Get-RegistryValue -KeyPath $key -ValueName $val -InputFile "c:\temp\computers.txt"
	.EXAMPLE
		$key = "HKLM:SYSTEM\CurrentControlSet\Control\SystemInformation"
		$val = "BIOSVersion"
		Get-RegistryValue -KeyPath $key -ValueName $val -ComputerName "DC01,DC02,DC03"
	.EXAMPLE
		$key = "HKLM:SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint"
		$val = "NoWarningNoElevationOnInstall"
		Get-RegistryValue -KeyPath $key -ValueName -InputFile "c:\temp\computers.txt"
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-RegistryValue.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory)][alias('Key','KeyPath')][string][ValidateNotNullOrEmpty()]$Path,
		[parameter(Mandatory)][alias('ValueName','Value')][string][ValidateNotNullOrEmpty()]$Name,
		[parameter()][alias('Computer')][string]$ComputerName = "",
		[parameter()][string]$InputFile = "",
		[parameter()][switch]$ADGridSelect
	)

	if (![string]::IsNullOrWhiteSpace($ComputerName)) {
		$computers = @($ComputerName.Split(','))
	} elseif (![string]::IsNullOrWhiteSpace($InputFile)) {
		if (Test-Path $InputFile) {
			$computers = Get-Content -Path $InputFile
		} else {
			Write-Warning "File not found: $InputFile"
			break
		}
	} elseif ($ADGridSelect) {
		if (Get-Module ActiveDirectory -ListAvailable) {
			$computers = Get-ADComputer -Filter '*' | Sort-Object Name | Select-Object -ExpandProperty Name |
				Out-GridView -Title "Select Computers to Query" -OutputMode Multiple
		}
	}

	if ($computers.Count -gt 0) {
		$total = $computers.Count
		Write-Verbose "searching $total computers"
		$counter = 1
		#$output = @()
		[System.Collections.Generic.List[PSObject]]$output = @()
		foreach ($computer in $computers) {
			$response = $null
			$response = Invoke-Command -ComputerName $computer -ScriptBlock {
				$val = $null
				try {
					$val = Get-ItemProperty -Path $using:Path -Name $using:Name -ErrorAction Stop
				}
				catch {
					$val = '(NotFound)'
				}
				[pscustomobject]@{
					Path  = $using:Path
					Value = $using:Name
					Data  = $val
				}
			} | Select-Object PSComputerName, Path, Value, Data
			$response
			$output.Add($response)
		}
		$output
	}
}
