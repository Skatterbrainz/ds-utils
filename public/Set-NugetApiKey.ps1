<#
.SYNOPSIS
	Set-DsNugetApiKey
.DESCRIPTION
	Stores NuGet API key in registry
.PARAMETER ApiKey
	NuGet API key (GUID) from repository (e.g. PowerShell Gallery)
.EXAMPLE
	Set-NugetApiKey -ApiKey '01234567-abcd-4567-defg-987654321aaa'
.LINK
	https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Set-NugetApiKey.md
#>
function Set-NugetApiKey {
	[CmdletBinding()]
	param (
		[parameter(Mandatory)][string]$ApiKey
	)
	$keypath = 'HKCU:\Software\NuGetApiKey'
	if (!(Test-Path $keyPath)) {
		Write-Verbose "creating registry key: $keypath"
		$null = New-Item -Path $keypath -Force
	}
	try {
		Set-ItemProperty -Path $keypath -Name "ApiKey" -Value $ApiKey -Force
	}
	catch {
		Write-Error $_.Exception.Message
	}
}
