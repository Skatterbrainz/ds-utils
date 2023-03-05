function Add-TaskbarShortcut {
	<#
	.SYNOPSIS
		Pin Shortcut to Taskbar
	.DESCRIPTION
		Pin Shortcut to Taskbar
	.PARAMETER Path
		Path and name of item to target shortcut. Alias: Target, FilePath
	.EXAMPLE
		Add-TaskbarShortcut -Target "c:\windows\notepad.exe"
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Add-TaskbarShortcut.md
	#>
	[CmdletBinding()]
	[OutputType()]
	param (
		[parameter(Mandatory=$True, HelpMessage="Target item to pin")]
		[ValidateNotNullOrEmpty()]
		[Alias('Target','FilePath')]
		[string] $Path
	)
	if (!(Test-Path $Path)) {
		Write-Warning "ooof!!! $Path does not exist"
		break
	}
	try {
		$KeyPath1  = "HKCU:\SOFTWARE\Classes"
		$KeyPath2  = "*"
		$KeyPath3  = "shell"
		$KeyPath4  = "{:}"
		$ValueName = "ExplorerCommandHandler"
		$ValueData =
			(Get-ItemProperty `
				("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\" + `
					"CommandStore\shell\Windows.taskbarpin")
			).ExplorerCommandHandler

		$Key2 = (Get-Item $KeyPath1).OpenSubKey($KeyPath2, $true)
		$Key3 = $Key2.CreateSubKey($KeyPath3, $true)
		$Key4 = $Key3.CreateSubKey($KeyPath4, $true)
		$Key4.SetValue($ValueName, $ValueData)

		$Shell = New-Object -ComObject "Shell.Application"
		$Folder = $Shell.Namespace((Get-Item $Path).DirectoryName)
		$Item = $Folder.ParseName((Get-Item $Path).Name)
		$Item.InvokeVerb("{:}")

		$Key3.DeleteSubKey($KeyPath4)
		if ($Key3.SubKeyCount -eq 0 -and $Key3.ValueCount -eq 0) {
			$Key2.DeleteSubKey($KeyPath3)
		}
	}
	catch {
		Write-Error $Error[0].Exception.Message
	}
}
