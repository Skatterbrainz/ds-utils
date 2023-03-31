function Invoke-DialogFileOpen {
	<#
	.SYNOPSIS
		Display a file open dialog form
	.DESCRIPTION
		Display a file open dialog form to select one or more files to return the full names.
	.PARAMETER InitialDirectory
		Default folder location
	.PARAMETER Filter
		Optional. File type filter, using paired format as follows:
		* Default is "All Files (*.*)|*.*"
		* Format is "Text Files (*.txt)|*.txt"
	.PARAMETER Title
		Optional. Dialog form caption. Default is "Select File"
	.PARAMETER MultiSelect
		Optional. Allows selecting multiple files. Default is single selection only.
	.EXAMPLE
		$files = Invoke-DialogFileOpen -InitialDirectory "c:\projects" -Filter "Python Files (*.py)|*.py" -Title "Select Files" -MultiSelect
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-DialogFileOpen.md
	#>
	[CmdletBinding()]
	param (
		[parameter()][string]$InitialDirectory = "",
		[parameter()][string]$Filter = "All Files (*.*)|*.*",
		[parameter()][string]$Title = 'Select File',
		[parameter()][switch]$MultiSelect
	)
	#$Filter = 'Documents (*.docx)|*.docx|SpreadSheet (*.xlsx)|*.xlsx'
	[void] [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
	$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
	if ($initialDirectory) { $OpenFileDialog.initialDirectory = $initialDirectory }
	$OpenFileDialog.Filter = $Filter
	$OpenFileDialog.Title = $Title
	$OpenFileDialog.CheckFileExists = $True
	if ($MultiSelect) {
		$OpenFileDialog.MultiSelect = $True
		if ($Title = "Select File") { $Title = "Select Files" }
	}
	Write-Host -ForegroundColor Yellow "* * * W A R N I N G : Dialog form may be hidden behind another window * * *"
	Write-Host
	[void] $OpenFileDialog.ShowDialog()
	if ($MultiSelect) {
		$selected = @($OpenFileDialog.FileNames)
	} else {
		$selected = $OpenFileDialog.FileName
	}
	$OpenFileDialog.Dispose()
	return $selected
}

