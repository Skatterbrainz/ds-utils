function Write-DsLog {
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
		Write-DsLog "this is a log entry"
	.EXAMPLE
		Write-DsLog -Category Warning -Message "this is a warning message"
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
		Write-Error "[module=ds-utils: Write-DsLog] $($Error[0].Exception.Message -join ';')"
	}
}

# By Trevor Jones - https://smsagent.blog/2015/06/25/translating-error-codes-for-windows-and-configuration-manager/
function Convert-ErrorCode {
	[CmdletBinding()]
	param (
		[parameter(Mandatory=$True,ParameterSetName='Decimal')] [int64]$DecimalErrorCode,
		[parameter(Mandatory=$True,ParameterSetName='Hex')] $HexErrorCode
	)
	if ($DecimalErrorCode) {
		$hex = '{0:x}' -f $DecimalErrorCode
		$hex = "0x" + $hex
		$hex
	}
	if ($HexErrorCode) {
		$DecErrorCode = $HexErrorCode.ToString()
		$DecErrorCode
	}
}

function Join-Url {
	<#
	.SYNOPSIS
		Join-Path for WEB URL strings
	.DESCRIPTION
		Same as the SYNOPSIS
	.PARAMETER Path
		Base path string
	.PARAMETER ChildPath
		Child path string to append to Path
	.EXAMPLE
		Join-Url -Path "https://www.contoso.com" -ChildPath "sales"
		returns "https://www.contoso.com/sales"
	.EXAMPLE
		Join-Url -Path "https://www.contoso.com/sales/" -ChildPath "accounts"
		returns "https://www.contoso.com/sales/accounts"
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Join-Url.md
	#>
	param (
		[parameter(Mandatory,Position=0)][ValidateNotNullOrEmpty()][string] $Path, 
		[parameter(Mandatory,Position=1)][ValidateNotNullOrEmpty()][string] $ChildPath
	)
	if ($Path.EndsWith('/')) {
		Write-Output "$Path$ChildPath"
	}
	else {
		Write-Output "$Path/$ChildPath"
	}
}
