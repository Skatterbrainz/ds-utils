function Show-FileExtensions {
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
		Show-FileExtensions -Enable $True -RestartShell
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Show-FileExtensions.md
	#>
	[CmdletBinding()]
	[OutputType()]
	param (
		[parameter(Mandatory)][bool] $Enable,
		[parameter()][switch] $RestartShell
	)
	if ($Enable -eq $True) {$v = 1} else {$v = 0}
	try {
		Write-Host "setting windows explorer file extensions display to $Enable"
		$key = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
		$null = Set-ItemProperty -Path $key -Name "HideFileExt" -Value $v -Force
		if ($RestartShell) {
			Write-Host "restarting explorer shell process"
			Get-Process -Name "explorer" | Stop-Process -Force
		}
		else {
			Write-Host "change will take effect after Explorer shell is restarted or user logs off"
		}
	}
	catch {
		Write-Error $_.Exception.Message
	}
}
