function Install-Chocolatey {
	#requires -RunAsAdministrator
	<#
	.SYNOPSIS
		Install Chocolatey and List of Packages
	.DESCRIPTION
		Install Chocolatey and List of Packages
	.EXAMPLE
		Install-Chocolatey
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Install-Chocolatey.md
	#>
	[CmdletBinding()]
	[OutputType()]
	param ()
	try {
		if ([string]::IsNullOrWhiteSpace($env:ChocolateyInstall)) {
			Write-Host "installing chocolatey" -ForegroundColor cyan
			Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
			Write-DsLog -Message "chocolatey has landed!"
		} else {
			Write-Host "Chocolatey is already installed"
		}
		Write-Output 0
	}
	catch {
		Write-DsLog -Message $Error[0].Exception.Message -Category Error
		Write-Output -1
	}
}