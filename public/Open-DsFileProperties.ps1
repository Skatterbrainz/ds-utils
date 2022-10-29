function Open-DsFileProperties {
	<#
	.SYNOPSIS
		Open-DsFileProperties
	.DESCRIPTION
		Display Windows file properties
	.PARAMETER Path
		File path
	.EXAMPLE
		Open-DsFileProperties -Path "c:\temp\myfile.ps1"
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Open-DsFileProperties.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory=$True)][alias('FilePath')][string]$Path
	)

	try {
		if (!(Test-Path $Path)) { throw "File not found: $Path" }
		$fileobject = Get-Item $Path
		$fpath = $fileobject.Directory
		$fname = $fileobject.Name
		$shell = New-Object -ComObject Shell.Application
		$folder = $shell.NameSpace($fpath)
		$file = $folder.ParseName($fname)
		$file.InvokeVerb("Properties")
	}
	catch {
		Write-Error $_.Exception.Message
	}
}