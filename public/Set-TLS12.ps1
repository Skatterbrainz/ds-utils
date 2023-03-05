function Set-TLS12 {
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
	[Net.ServicePointManager]::SecurityProtocol
}