<#
.SYNOPSIS
	Get-NugetApiKey
.DESCRIPTION
	Returns API key stored in registry, following use of Set-DsNugetApiKey
	or having set the registry value by some other means
.PARAMETER (none)
.NOTES
	Use Set-DsNugetApiKey to define the registry value first
.EXAMPLE
	$apikey = Get-NugetApiKey
	Publish-Module -Name "MyModule" -NuGetApiKey $apikey
.LINK
	https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-NugetApiKey.md
#>
function Get-NugetApiKey {
	[CmdletBinding()]
	param ()
	$keypath = 'HKCU:\Software\NuGetApiKey'
	if (Test-Path $keyPath) {
		Get-ItemProperty -Path $keypath -Name "ApiKey" | Select-Object -ExpandProperty ApiKey
	} else {
		Write-Warning "Key is not defined: $regpath . Use Set-NugetApiKey first."
	}
}
