
function Set-Win10StartMenu {
	<#
	.SYNOPSIS
		Set-DsWin10StartMenu
	.DESCRIPTION
		Customize Start Menu and TaskBar
	.PARAMETER FeatureName
		Name of feature to configure or disable
	.NOTES
		https://www.howto-connect.com/registry-hacks-for-start-menu-and-taskbar-in-windows-10/
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Set-DsWin10StartMenu.md
	#>
	[CmdletBinding()]
	[OutputType()]
	param (
		[parameter(Mandatory)]
		[ValidateSet('RecentApps','ContextMenu','PeopleIcon')]
		[string] $FeatureName
	)
	Write-Warning "This function has been deprecated and will be removed in a future release."
	Write-Verbose "setting feature: $FeatureName"
	try {
		Write-Verbose "Updating registry key based on feature: $FeatureName"
		switch ($FeatureName) {
			'RecentApps' {
				$KeyPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer'
				Write-Verbose "Updating registry key: $KeyPath"
				New-Item -Path $KeyPath -Name HideRecentlyAddedApps -Value 1 -ItemType DWORD
			}
			'ContextMenu' {
				$KeyPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer'
				Write-Verbose "Updating registry key: $KeyPath"
				New-Item -Path $KeyPath -Name DisableContextMenusInStart -Value 0 -ItemType DWORD
			}
			'PeopleIcon' {
				$KeyPath = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People'
				Write-Verbose "Updating registry key: $KeyPath"
				New-Item -Path $KeyPath -Name PeopleBand -Value 0 -ItemType DWORD
			}
		}
	}
	catch {
		Write-Error $_.Exception.Message
	}
}
