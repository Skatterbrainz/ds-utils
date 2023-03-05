function Install-Chocolatey {
	#requires -RunAsAdministrator
	<#
	.SYNOPSIS
		Install Chocolatey and List of Packages
	.DESCRIPTION
		Install Chocolatey and List of Packages
	.PARAMETER RemotePath
		URL to install script
	.EXAMPLE
		Install-Chocolatey
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Install-Chocolatey.md
	#>
	[CmdletBinding()]
	[OutputType()]
	param (
		[parameter()][string]$RemotePath = 'https://chocolatey.org/install.ps1'
	)
	try {
		if ([string]::IsNullOrWhiteSpace($env:ChocolateyInstall)) {
			Write-Host "installing chocolatey" -ForegroundColor cyan
			Invoke-Expression ((New-Object System.Net.WebClient).DownloadString($RemotePath))
			Write-Host "Chocolatey has landed!"
		} else {
			Write-Host "Chocolatey is already installed"
		}
		Write-Output 0
	}
	catch {
		Write-Error $_.Exception.Message
		Write-Output -1
	}
}