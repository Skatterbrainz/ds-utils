function Get-ADLockedUsers {
	<#
	.SYNOPSIS
	.DESCRIPTION
	.PARAMETER EventID
		Required. Event ID of user account lock event. Default = 4740
	.PARAMETER LogName
		Required. Name of Windows Event Log to search. Default = "Security"
	.PARAMETER DaysBack
		Required. Number of days to search back from current date. Range = 1 to 30. Default = 3
	.EXAMPLE
		Get-ADLockedUsers -DaysBack 7
	.NOTES
		Requires ActiveDirectory PowerShell module (RSAT installed, or on a DC)
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-ADLockedUsers.md
	#>
	[CmdletBinding()]
	param (
		[parameter()][int]$EventID = 4740,
		[parameter()][string]$LogName = "Security",
		[parameter()][int][ValidateRange(1,30)]$DaysBack = 3
	)
	if ([string]::IsNullOrWhiteSpace($LogName)) {
		Write-Warning "Parameter cannot be blank: LogName"
		break
	}
	if ($null -eq $EventID) {
		Write-Warning "Parameter cannot be blank: EventID"
		break
	}

	if (!(Get-Module ActiveDirectory -ListAvailable)) {
		Write-Warning "Module not installed: ActiveDirectory"
		break
	}
	$dcs = @(Get-ADDomainController -Filter * | Sort-Object Name | Select-Object -ExpandProperty Name)
	[int]$total = $dcs.Count
	[int]$counter = 1

	[datetime]$StartTime = (Get-Date).AddDays(-$DaysBack)
	[System.Collections.Generic.List[PSObject]] $results = @()
	foreach ($dc in $dcs) {
		Write-Host "$counter of $total - $dc"
		try {
			$events = Get-WinEvent -ComputerName $dc -FilterHashtable @{Logname = $LogName; ID = $EventID; StartTime = $StartTime} -ErrorAction Stop
			foreach ($event in $events) {
				$res = [pscustomobject]@{
					DC             = $dc
					Time           = $event.TimeCreated
					Username       = $event.Properties.Value[0]
					ClientComputer = $event.Properties.Value[1]
				}
				$results.Add($res)
				$res | FT -Wrap
			}
		}
		catch {
			$msg = $_.Exception.Message
			if ($msg -like '*No events were found*') {
				Write-Host "$dc - No matching events found" -ForegroundColor Cyan
			} else {
				Write-Warning "ERROR: $dc - $msg"
			}
		}
		$counter++
	}
	$results
}
