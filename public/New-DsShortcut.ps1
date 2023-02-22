function New-DsShortcut {
	<#
	.SYNOPSIS
		New-DsShortcut
	.DESCRIPTION
		Create a new shortcut (.lnk file)
	.PARAMETER Name
		Name of the shortcut file (base name)
	.PARAMETER TargetFile
		Path to target of the shortcut
	.PARAMETER WorkingDirectory
		Working directory path when launching the TargetFile
	.PARAMETER Arguments
		Arguments to pass to the TargetFile when launched
	.PARAMETER Path
		Path to save shortcut .lnk file
		Known folders allowed: 'Desktop','Documents','StartMenu','Favorites','AllUserDesktop','AllUsersStartMenu'
		Default = 'Desktop'
	.PARAMETER WindowStyle
		Window style for opening target (Normal, Minimized or Maximized) Default = Normal
	.PARAMETER IconLocation
		Path to icon file, or path and index of embedded icon
	.PARAMETER Description
		Description for shortcut
	.PARAMETER Replace
		If shortcut file exists, replace it
	.EXAMPLE
		New-DsShortcut -Name "Notepad" -TargetFile "c:\windows\system32\notepad.exe"
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/New-DsShortcut.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory=$True)][alias('ShortcutName')][string]$Name,
		[parameter(Mandatory=$True)][alias('Target')][string]$TargetFile,
		[parameter()][alias('WorkingPath')][string]$WorkingDirectory = "",
		[parameter()][alias('Args')][string]$Arguments = "",
		[parameter()][string][ValidateSet('Desktop','Documents','StartMenu','Favorites','AllUserDesktop','AllUsersStartMenu')]$Path = 'Desktop',
		[parameter()][string][ValidateSet('Normal','Minimized','Maximized')]$WindowStyle = 'Normal',
		[parameter()][alias('Icon')][string]$IconLocation = "",
		[parameter()][string]$Description = "",
		[parameter()][switch]$Replace
	)
	try {
		if (-not(Test-Path $TargetFile)) { throw "File not found: $TargetFile" }
		$pth = [System.Environment]::GetFolderPath($Path)
		[string]$scfile = Join-Path -Path $pth -ChildPath "$($Name).lnk"
		if (Test-Path $scfile) {
			if ($Replace) {
				$null = Get-Item -Path $scfile | Remove-Item -Force
			} else {
				throw "Shortcut exists. Use -Replace to overwrite."
			}
		}
		$wshell = New-Object -ComObject WScript.Shell
		$Shortcut = $wshell.CreateShortcut($scfile)
		$Shortcut.TargetPath = $TargetFile
		switch ($WindowStyle) {
			'Normal' { $Shortcut.WindowStyle = 4 }
			'Maximized' { $Shortcut.WindowStyle = 3 }
			'Minimized' { $Shortcut.WindowStyle = 7 }
		}
		if (![string]::IsNullOrWhiteSpace($Description)) {
			$Shortcut.Description = $Description
		}
		if (![string]::IsNullOrWhiteSpace($Arguments)) {
			$Shortcut.Arguments = $Arguments
		}
		if (![string]::IsNullOrWhiteSpace($WorkingDirectory)) {
			if (-not (Test-Path $WorkingDirectory)) {
				throw "WorkingDirectory not found: $WorkdingDirectory"
			}
			$Shortcut.WorkingDirectory = $WorkingDirectory
		}
		if (![string]::IsNullOrWhiteSpace($IconLocation)) {
			if ($IconLocation.IndexOf(',') -gt 0) {
				$filepath = $IconLocation.Split(',')[0]
				if (-not (Test-Path $filepath)) {
					throw "IconLocation base file not found: $filepath"
				}
			} elseif ($IconLocation.IndexOf('.') -gt 0) {
				if (-not (Test-Path $IconLocation)) {
					throw "IconLocation file not found: $IconLocation"
				}
			}
			$Shortcut.IconLocation = $IconLocation
		}
		$Shortcut.Save()
		$result = $Shortcut
	}
	catch {
		Write-Error $_.Exception.Message
	}
	finally {
		Write-Output $result
	}
}
New-Alias -Name New-Shortcut -value New-DsShortcut -Description "Create a new shortcut"