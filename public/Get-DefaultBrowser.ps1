function Get-DefaultBrowser {
	<#
	.SYNOPSIS
		Get-DsDefaultBrowser
	.DESCRIPTION
		Returns default browser for current user
	.EXAMPLE
		Get-DefaultBrowser
		Example return: "Edge"
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DefaultBrowser.md
	#>
	[CmdletBinding()]
	param()
	try {
		$progid = Get-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice\' -ErrorAction Stop | Select-Object -ExpandProperty 'ProgId'
		if ($progid -eq 'MSEdgeHTM') {
			'Edge'
		} elseif ($progid -like 'BraveHTML*') {
			'Brave'
		} elseif ($progid -like 'ChromeHTML*') {
			'Chrome'
		} elseif ($progid -like 'FirefoxURL*') {
			'Firefox'
		}
	}
	catch {
		Write-Error "$($_.Exception.Message)"
	}
}