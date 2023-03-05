function Get-DocRef {
	<#
	.SYNOPSIS
		Opens link to Microsoft Doc for Variable Data Type
	.DESCRIPTION
		Opens a link in a web browser to the Microsoft Doc page for the
		data type associated with a PowerShell variable. The Search parameter
		searches Google for the variable type, for situations when there is no
		direct MS Doc page available.
	.PARAMETER VariableRef
		PowerShell variable (object)
	.PARAMETER Search
		Switch to perform search instead of direct link
	.EXAMPLE
		$myVar | Get-DocRef
		If $myVar is of type System.Array, opens
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DocRef.md
	#>
	[CmdletBinding()]
	[OutputType()]
	param (
		[parameter(Mandatory,ValueFromPipeline=$true,Position=0)] $VariableRef,
		[parameter()][switch] $Search
	)
	if ($null -ne $VariableRef) {
		$vtype = $VariableRef.GetType().BaseType.FullName
		if ($Search) {
			$url = "https://www.google.com/search?source=hp&q=site%3Adocs.microsoft.com`+$vtype"
		}
		else {
			$url = "https://docs.microsoft.com/en-us/dotnet/api/$vtype"
		}
		Write-Host "Requesting: $url"
		Start-Process $url
	}
}
