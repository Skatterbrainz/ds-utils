function Write-LogFile {
	<#
	.SYNOPSIS
		Write to a custom log file
	.DESCRIPTION
		Write to a custom log file
	.PARAMETER LogFile
		Path and name of log file
		Default is c:\windows\temp\ds-utils-YYYYMMDDhhmm.log
	.PARAMETER Category
		Info, Warning, or Error (Default: Info)
	.PARAMETER Message
		Text for log detail entry
	.EXAMPLE
		Write-LogFile "this is a log entry"
	.EXAMPLE
		Write-LogFile -Category Warning -Message "this is a warning message"
	.NOTES
		Internal function
	#>
	[CmdletBinding()]
	[OutputType()]
	param (
		[parameter(Mandatory)] [ValidateNotNullOrEmpty()] [string] $Message,
		[parameter()][ValidateNotNullOrEmpty()] [string] $LogFile = $(Join-Path $env:TEMP "ds-utils-$(Get-Date -f 'yyyyMMdd').log"),
		[parameter()][ValidateSet('Info','Error','Warning')] [string] $Category = 'Info'
	)
	try {
		$strdata = "$(Get-Date -f 'yyyy-MM-dd hh:mm:ss') - $Category - $Message"
		$strdata | Out-File -FilePath $LogFile -Append
		switch ($Category) {
			'Warning' { Write-Warning $strdata }
			'Error' { Write-Warning "Error: $strdata" }
			default { Write-Host $strdata -ForegroundColor Cyan }
		}
	}
	catch {
		Write-Error "[module=ds-utils: Write-LogFile] $($Error[0].Exception.Message -join ';')"
	}
}