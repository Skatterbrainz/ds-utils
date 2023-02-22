function Get-DsPublicIPv4Address {
	<#
	.SYNOPSIS
	Get current public IPv4 address
	.DESCRIPTION
	Geez. Do I really need to elaborate on this one?
	.PARAMETER (none)
	.EXAMPLE
		Get-DsPublicIPv4Address
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DsPublicIPv4Address.md
	#>
	$response = Invoke-WebRequest "http://ipconfig.me/ip"
	$pattern = 'id="ip_address">'
	$beginstring = $response.Content.Substring($response.Content.IndexOf($pattern)+16)
	$result = $beginstring.Substring(0, $beginstring.IndexOf("</"))
	$result
}
New-Alias -Name myIP -value Get-DsPublicIPv4Address -Description "Query my public IP v4 address"