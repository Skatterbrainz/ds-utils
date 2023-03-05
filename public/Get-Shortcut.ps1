function Get-Shortcut {
	<#
	.SYNOPSIS
		Get-DsShortcut
	.DESCRIPTION
		Return shortcut properties
	.PARAMETER Path
		Path and name of .lnk file
	.EXAMPLE
		Get-Shortcut -Path "$($env:USERPROFILE)\Desktop\GitHub Desktop.lnk"
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-Shortcut.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory=$True)][string]$Path
	)
	try {
		if (-not(Test-Path $Path)) { throw "File not found: $Path" }
		$wshell = New-Object -ComObject WScript.Shell
		$Shortcut = $wshell.CreateShortcut($Path)
		$Shortcut
	}
	catch {
		Write-Error $_.Exception.Message
	}
	finally {
		Write-Output $result
	}
}
