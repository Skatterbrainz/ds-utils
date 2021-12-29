
function Set-DsComputerName {
	<#
	.SYNOPSIS
		Rename computer using common standard format
	.DESCRIPTION
		I hate repeating myself
	.PARAMETER MaxNameLength
		Maximum length of new name (default is 15, which is the limit for Windows)
	.PARAMETER FormCode
		Form-factor code placement: Prefix (default), Suffix, or None
	.PARAMETER NoHyphen
		Do not insert a hyphen separator between FormCode and SerialNumber
	.PARAMETER Reboot
		Force a reboot at the end (default = no reboot)
	.EXAMPLE
		Set-DsComputerName
		(Defaults) results in name like "L-123456789"
	.EXAMPLE
		Set-DsComputerName -FormCode Suffix -NoHyphen
		Results in name like "123456789L"
	.EXAMPLE
		Set-DsComputerName -FormCode None -MaxNameLength 8
		Results in name like "12345678"
	.NOTES
		Actual Serial Number is used from WMI class Win32_SystemEnclosure
		Chassis Type number is taken from Win32_SystemEnclosure and uses first
			element of result only, since docking stations, port replicators
			may return an array like (10,12) where 10 is the laptop, and 12 is the dock
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Set-DsComputerName.md
	#>
	[CmdletBinding(SupportsShouldProcess)]
	[OutputType()]
	param (
		[parameter(Position=0)][ValidateRange(3,63)][int] $MaxNameLength = 15,
		[parameter()][ValidateSet('Prefix','Suffix','None')][string] $FormCode = 'Prefix',
		[parameter()][switch] $NoHyphen,
		[parameter()][switch] $Reboot
	)
	# rename computer to "X-12345678"
	[string]$sn = (Get-WmiObject -Class Win32_SystemEnclosure).SerialNumber
	[int]$ct = ((Get-WmiObject -Class Win32_SystemEnclosure).ChassisTypes)[0]
	Write-Verbose "serialnumber = $sn"
	Write-Verbose "chassistype = $ct"
	# desktops
	if ($ct -in (3..7)+(13,34,35)) { $ff = 'D' }
	# laptops
	elseif ($ct -in (10,11,12,14)+(15..30)+(31,32,33,36)) { $ff = 'L' }
	# servers
	elseif ($ct -in (17..24)) { $ff = 'S' }
	# unknown
	else { $ff = 'X' }
	if ($NoHyphen) { $sep = "" } else { $sep = "-" }
	if ($FormCode -eq 'None') { $fc = ""; $sep = "" } else { $fc = $ff }
	$nx = "$fc$sep$sn"
	if ($nx.Length -gt $MaxNameLength) {
		$over = $nx.Length - $MaxNameLength
		$sn = $sn.substring($over, $sn.Length - $over)
		$nx = "$fc$sep$sn"
	}
	Write-Host "renaming computer to $nx" -ForegroundColor cyan
	if ($Reboot) {
		Rename-Computer -NewName $nx -Force -Restart
	}
	else {
		Rename-Computer -NewName $nx -Force
	}
}
