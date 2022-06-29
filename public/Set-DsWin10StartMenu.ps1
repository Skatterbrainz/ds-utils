
function Set-DsWin10StartMenu {
	<#
	.SYNOPSIS
		Customize Start Menu and TaskBar
	.DESCRIPTION
		(same)
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
	Write-DsLog -Message "setting feature: $FeatureName"
	try {
		Write-DsLog -Message "Updating registry key based on feature: $FeatureName"
		switch ($FeatureName) {
			'RecentApps' {
				$KeyPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer'
				Write-DsLog -Message "Updating registry key: $KeyPath"
				New-Item -Path $KeyPath -Name HideRecentlyAddedApps -Value 1 -ItemType DWORD
			}
			'ContextMenu' {
				$KeyPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer'
				Write-DsLog -Message "Updating registry key: $KeyPath"
				New-Item -Path $KeyPath -Name DisableContextMenusInStart -Value 0 -ItemType DWORD
			}
			'PeopleIcon' {
				$KeyPath = 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People'
				Write-DsLog -Message "Updating registry key: $KeyPath"
				New-Item -Path $KeyPath -Name PeopleBand -Value 0 -ItemType DWORD
			}
		}
	}
	catch {
		Write-DsLog -Message $($_.Exception.Message -join ';') -Category Error
	}
}