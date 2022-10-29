function Show-DsFileExtensions {
	<#
	.SYNOPSIS
		Enable display of file extensions in Windows Explorer
	.DESCRIPTION
		Enable display of file extensions in Windows Explorer
	.PARAMETER Enable
		Toggle display on (Enable $True) or off (Enable $False)
	.PARAMETER RestartShell
		Restart the Explorer shell to apply changes
	.EXAMPLE
		Show-DsFileExtensions -Enable $True -RestartShell
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Show-DsFileExtensions.md
	#>
	[CmdletBinding()]
	[OutputType()]
	param (
		[parameter(Mandatory)][bool] $Enable,
		[parameter()][switch] $RestartShell
	)
	if ($Enable -eq $True) {$v = 1} else {$v = 0}
	try {
		Write-DsLog -Message "setting windows explorer file extensions display to $Enable"
		$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
		Set-ItemProperty -Path $key -Name "HideFileExt" -Value $v -Force
		if ($RestartShell) {
			Write-DsLog -Message "restarting explorer shell process"
			Get-Process -Name "explorer" | Stop-Process -Force
		}
		else {
			Write-DsLog -Message "change will take effect after Explorer shell is restarted or user logs off" -Category Warning
		}
	}
	catch {
		Write-DsLog -Message $Error[0].Exception.Message -Category Error
	}
}