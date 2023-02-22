function Get-DsFileOpenDialog {
	<#
	.SYNOPSIS
	Display a file open dialog form
	.DESCRIPTION
	Display a file open dialog form to select one or more files to return the full names.
	.PARAMETER InitialDirectory
	Default folder location
	.PARAMETER Filter
	Optional. File type filter, using paired format as follows:
	Default is "All Files (*.*)|*.*". Format is "Text Files (*.txt)|*.txt"
	.PARAMETER Title
	Optional. Dialog form caption. Default is "Select File"
	.PARAMETER MultiSelect
	Optional. Allows selecting multiple files. Default is single selection only.
	.EXAMPLE
	$files = Get-DsFileOpenDialog -InitialDirectory "c:\projects" -Filter "Python Files (*.py)|*.py" -Title "Select Files" -MultiSelect
	.LINK
	https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DsFileOpenDialog.md
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

function Get-DsFolderDialog {
	<#
	.SYNOPSIS
	Display a Folder selection dialog
	.DESCRIPTION
	Display a folder selection dialog to choose a target folder
	.PARAMETER InitialDirectory
	Optional. If empty, will default to the current default working directory
	.EXAMPLE
	$folder = Get-DsFolderDialog -InitialDirectory "c:\projects"
	.LINK
	https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DsFolderDialog.md
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

function Invoke-DsMsgBox {
	<#
	.SYNOPSIS
	Display Windows message box
	.DESCRIPTION
	Display a Windows message box
	.PARAMETER Message
	Text to display in the message box
	.PARAMETER Title
	Message box caption / title
	.PARAMETER ButtonType
	Ok, OkCancel, YesNo, YesNoCancel. Default is Ok
	.PARAMETER Icon
	Error, Exclamation, Information, Question, Warning, None. Default is Information
	.LINK
	https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-DsMsgBox.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory)][string]$Message,
		[parameter(Mandatory)][string]$Title,
		[parameter()][string][ValidateSet('Ok','OkCancel','YesNo','YesNoCancel')]$ButtonType = 'Ok',
		[parameter()][string]
			[ValidateSet('Asterisk','Error','Exclamation','Hand','Information','Question','Stop','Warning','None')]$Icon = 'Information'
	)
	Add-Type -AssemblyName PresentationCore, PresentationFramework
	$result = [System.Windows.MessageBox]::Show($Message, $Title, $ButtonType, $Icon)
	$result
}

function Invoke-DsFileSaveDialog {
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
	$filepath = Invoke-DsFileSaveDialog
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-DsFileSaveDialog.md
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

New-Alias -Name "Show-MessageBox" -Value Invoke-DsMsgBox
New-Alias -Name "MsgBox" -Value Invoke-DsMsgBox
New-Alias -Name "Invoke-OpenFileDialog" -Value Get-DsFileOpenDialog
New-Alias -Name "Invoke-FolderDialog" -Value Invoke-FolderDialog
New-Alias -Name "Invoke-SaveFileDialog" -Value Invoke-DsFileSaveDialog
