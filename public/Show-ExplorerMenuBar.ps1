function Show-ExplorerMenuBar {
	<#
	.SYNOPSIS
		Enable Display of Menu Bar in Windows Explorer
	.DESCRIPTION
		DO I really need to explain it again? Just read the SYNOPSIS info
	.PARAMETER Enable
		Toggle display on (Enable $True) or off (Enable $False)
	.PARAMETER AllUsers
		Apply change to all local user profiles (default is current user only)
	.EXAMPLE
		Show-ExplorerMenuBar -Enable $True -AllUsers
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Show-ExplorerMenu.md
	#>
	[CmdletBinding()]
	[OutputType()]
	param (
		[parameter(Mandatory)][bool] $Enable,
		[parameter()][switch] $AllUsers
	)
	<#
	0 or delete = Not configured (default)
	1 = Always open new File Explorer windows with the ribbon minimized
	2 = Never open new File Explorer windows with the ribbon minimized
	3 = Minimize the ribbon when File Explorer is opened the first time
	4 = Display the full ribbon when File Explorer is opened the first time
	#>
	try {
		if ($AllUsers) {
			Write-Host -Message "setting explorer ribbon menu display to $Enable (all users)"
			if ($Enable -eq $True) {$v = 4} else {$v = 0}
			$key = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer'
			$val = 'ExplorerRibbonStartsMinimized'
			$null = New-Item -Path $key -Force
			$null = New-ItemProperty -Path $key -Name $val -Value $v -PropertyType DWORD -Force
		}
		else {
			Write-Host "setting explorer ribbon menu display to $Enable (current user)"
			if ($Enable -eq $True) {$v = 0} else {$v = 1}
			$key = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Ribbon'
			$null = Set-ItemProperty -Path $key -Name 'MinimizedStateTabletModeOff' -Value $v -Force
		}
	}
	catch {
		Write-Error $_.Exception.Message -Category Error
	}
}
