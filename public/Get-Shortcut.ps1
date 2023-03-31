function Get-Shortcut {
	<#
	.SYNOPSIS
		Get-DsShortcut
	.DESCRIPTION
		Return shortcut properties
	.PARAMETER Path
		Path and name of .lnk file
	.PARAMETER Source
		Optional. Shell or CIM
		* Shell uses Win32 Wscript.Shell COM interface to query the shortcut properties
		* CIM uses the Win32_ShortcutFile class to query the shortcut properties
	.EXAMPLE
		Get-Shortcut -Path "$($env:USERPROFILE)\Desktop\GitHub Desktop.lnk"
		Returns the shortcut properties as defined in the Wscript.Shell COM object properties
	.EXAMPLE
		Get-Shortcut -Path "$($env:USERPROFILE)\Desktop\GitHub Desktop.lnk" -Source CIM
		Returns the shortcut properties as defined in Win32_ShortcutFile
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-Shortcut.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory=$True)][string]$Path,
		[parameter()][string][ValidateSet('Shell','CIM')]$Source = 'Shell'
	)
	try {
		if (-not(Test-Path $Path)) { throw "File not found: $Path" }
		if ($Source -eq 'Shell') {
			$wshell = New-Object -ComObject WScript.Shell
			$Shortcut = $wshell.CreateShortcut($Path)
		} else {
			if ($Path.contains('\\')) {
				$scpath = $Path
			} elseif($Path.contains('\')) {
				$scpath = $Path.Replace('\','\\')
			} else {
				$scpath = $Path
			}
			$Shortcut = Get-CimInstance -ClassName Win32_ShortcutFile -Filter "Name='$scpath'"
		}
		$Shortcut
	}
	catch {
		Write-Error $_.Exception.Message
	}
	finally {
		Write-Output $result
	}
}
