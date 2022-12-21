function Get-DsPublicIPv4Address {
	$response = Invoke-WebRequest "http://ipconfig.me/ip"
	$pattern = 'id="ip_address">'
	$beginstring = $response.Content.Substring($response.Content.IndexOf($pattern)+16)
	$result = $beginstring.Substring(0, $beginstring.IndexOf("</"))
	$result
}