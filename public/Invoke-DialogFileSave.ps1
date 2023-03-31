function Invoke-DialogFileSave {
	<#
	.SYNOPSIS
		Display a file Save or SaveAs dialog
	.DESCRIPTION
		Same as the synopsis
	.PARAMETER InitialDirectory
		Default directory location
	.PARAMETER Filter
		File type filter. Default is "All Files (*.*)|*.*"
	.PARAMETER Title
		Dialog caption
	.EXAMPLE
		$filepath = Invoke-DialogFileSave
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-DialogFileSave.md
	#>
	[CmdletBinding()]
	param (
		[parameter()][string]$InitialDirectory = "",
		[parameter()][string]$Filter = "All Files (*.*)|*.*",
		[parameter()][string]$Title = 'Save File'
	)
	#$Filter = 'Documents (*.docx)|*.docx|SpreadSheet (*.xlsx)|*.xlsx'
	[void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
	$FileSaveDialog = New-Object System.Windows.Forms.SaveFileDialog
	if (![string]::IsNullOrWhiteSpace($InitialDirectory)) { $FileSaveDialog.InitialDirectory = $InitialDirectory }
	$FileSaveDialog.Filter = $Filter
	$FileSaveDialog.Title = $Title
	$FileSaveDialog.CheckPathExists = $true
	if ($FileSaveDialog.ShowDialog() -eq 'Ok') {
		$selected = $FileSaveDialog.FileName
	}
	$FileSaveDialog.Dispose()
	return $selected
}
