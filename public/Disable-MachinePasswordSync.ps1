
function Disable-MachinePasswordSync {
	<#
	.SYNOPSIS
		Disable AD machine account password sync
	.DESCRIPTION
		Disable AD machine account password sync. Most often used with
		virtual machines which are repeatedly reverted to snapshots/checkpoints
		for development and testing purposes.
	.EXAMPLE
		Disable-MachinePasswordSync
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Disable-MachinePasswordSync.md
	#>
	[CmdletBinding()]
	[OutputType()]
	param()
	try {
		$KeyPath = 'HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters'
		Write-Verbose "Writing registry entry under $KeyPath"
		$null = New-Item -Path $KeyPath -Name DisablePasswordChange -Value 1 -ItemType DWORD -Force
		Write-Verbose "Registry update completed successfully. Reboot may be required."
		Write-Host "Registry updated. Reboot may be required." -ForegroundColor Yellow
	}
	catch {
		Write-Error $_.Exception.Message
	}
}
