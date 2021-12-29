
function Install-DsPackages {
	<#
	.SYNOPSIS
		Install Chocolatey and List of Packages
	.DESCRIPTION
		Install Chocolatey and List of Packages
	.PARAMETER Packages
		Name(s) of Chocolatey packages
		Default = ('dotnet3.5','7zip','notepadplusplus','adobereader','googlechrome')
	.EXAMPLE
		Install-DsPackages
		Installs the default list of packages
	.EXAMPLE
		Install-DsPackages -Packages ('visualstudiocode','git','github-desktop')
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Install-DsPackages.md
	#>
	[CmdletBinding()]
	[OutputType()]
	param (
		[parameter(Position=0)]
		[ValidateNotNullOrEmpty()]
		[string[]] $Packages = ('dotnet3.5','7zip','notepadplusplus','adobereader','googlechrome')
	)
	try {
		if (!(Test-Path (Join-Path $env:ProgramData "Chocolatey\choco.exe"))) {
			Write-Host "installing chocolatey" -ForegroundColor cyan
			Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
			Write-DsLog -Message "chocolatey has landed!"
		}
		cup $Packages -y
		Write-Output 0
	}
	catch {
		Write-DsLog -Message $Error[0].Exception.Message -Category Error
		Write-Output -1
	}
}