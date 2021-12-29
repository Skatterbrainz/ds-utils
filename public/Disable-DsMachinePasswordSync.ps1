
function Disable-DsMachinePasswordSync {
	<#
	.SYNOPSIS
		Disable AD machine account password sync
	.DESCRIPTION
		Disable AD machine account password sync. Most often used with
		virtual machines which are repeatedly reverted to snapshots/checkpoints
		for development and testing purposes.
	.EXAMPLE
		Disable-DsMachinePasswordSync
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Disable-DsMachinePasswordSync.md
	#>
	[CmdletBinding()]
	[OutputType()]
	param()
	try {
		$KeyPath = 'HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters'
		Write-DsLog -Message "Writing registry entry under $KeyPath"
		New-Item -Path $KeyPath -Name DisablePasswordChange -Value 1 -ItemType DWORD -Force
		Write-DsLog -Message "Registry update completed successfully. Reboot may be required."
		Write-Host "Registry updated. Reboot may be required." -ForegroundColor Yellow
	}
	catch {
		Write-DsLog -Message $Error[0].Exception.Message -Category Error
	}
}
