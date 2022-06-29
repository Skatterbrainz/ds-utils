function Open-DsFileProperties {
	[CmdletBinding()]
	param (
		[parameter(Mandatory=$True)][string]$FilePath
	)

	try {
		if (!(Test-Path $FilePath)) { throw "File not found: $FilePath" }
		$fileobject = Get-Item $FilePath
		$fpath = $fileobject.Directory
		$fname = $fileobject.Name
		$shell = New-Object -ComObject Shell.Application
		$folder = $shell.NameSpace($fpath)
		$file = $folder.ParseName($fname)
		$file.InvokeVerb("Properties")
	}
	catch {
		Write-Error $_.Exception.Message 
	}
}