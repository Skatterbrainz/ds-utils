function Get-DialogFolderSelect {
	<#
	.SYNOPSIS
	Display a Folder selection dialog
	.DESCRIPTION
	Display a folder selection dialog to choose a target folder
	.PARAMETER InitialDirectory
	Optional. If empty, will default to the current default working directory
	.EXAMPLE
	$folder = Get-DialogFolderSelect -InitialDirectory "c:\projects"
	.LINK
	https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DialogFolderSelect.md
	#>
	param (
		[parameter()][string]$InitialDirectory = ""
	)
	[void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
	$FolderBrowserDialog = New-Object System.Windows.Forms.FolderBrowserDialog
	$FolderBrowserDialog.RootFolder = 'MyComputer'
	if (![string]::IsNullOrWhiteSpace($initialDirectory)) {
		$FolderBrowserDialog.SelectedPath = $initialDirectory
	}
	Write-Host -ForegroundColor Yellow "* * * W A R N I N G : Dialog form may be hidden behind another window * * *"
	Write-Host
	[void] $FolderBrowserDialog.ShowDialog()
	$selected = $FolderBrowserDialog.SelectedPath
	$FolderBrowserDialog.Dispose()
	return $selected
}
