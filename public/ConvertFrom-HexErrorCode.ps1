function ConvertFrom-HexErrorCode {
	<#
	.SYNOPSIS
		Convert from Hex Error code
	.DESCRIPTION
		Convert Hex error code
	.PARAMETER HexErrorCode
		Error code to convert
	.EXAMPLE
		0xC00D2717L | ConvertFrom-HexErrorCode
		returns: 3222087447
	.NOTES
		By Trevor Jones - https://smsagent.blog/2015/06/25/translating-error-codes-for-windows-and-configuration-manager/
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/ConvertFrom-HexErrorCode.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory=$True,ValueFromPipeline=$True)] $HexErrorCode
	)
	begin {}
	process {
		$DecErrorCode = $HexErrorCode.ToString()
		$DecErrorCode
	}
	end {}
}
