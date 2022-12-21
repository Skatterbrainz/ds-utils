function Get-DsDefaultAppAssociations {
	[CmdletBinding()]
	param (
		[parameter()][string]$FilePath = "$($env:USERPROFILE)\documents\defaultapps.xml",
		[parameter()][int32]$RefreshDays = 7,
		[parameter()][switch]$Force
	)
	if (!(Test-Path $FilePath)) {
		Write-Verbose "creating new snapshot: $FilePath"
		$null = $(dism /Online /Export-DefaultAppAssociations:$FilePath)
	} else {
		Write-Verbose "checking the age of the last snapshot"
		if ($Force -or ($RefreshDays -eq 0) -or ((New-Timespan (Get-Item -Path $FilePath | Select-Object -ExpandProperty LastWriteTime) (Get-Date)).Days -gt $RefreshDays)) {
			Write-Verbose "file is older than $RefreshDays days - deleting file"
			$null = Remove-Item -Path $FilePath -Force
			Write-Verbose "creating new snapshot: $FilePath"
			$null = $(dism /Online /Export-DefaultAppAssociations:$FilePath)
		}
	}
	if (Test-Path $FilePath) {
		Write-Verbose "reading snapshot file to get app associations"
		$appdefs = [xml](Get-Content -Path $FilePath)
		Write-Verbose "returned $($appdefs.Count) app associations"
		Write-Output @($appdefs.DefaultAssociations.Association)
	} else {
		Write-Warning "unable to generate app associations snapshot file: $FilePath"
	}
}