function Invoke-DsSed {
	param (
		[parameter(Mandatory)][string]$FilePath,
		[parameter(Mandatory)][string]$Find,
		[parameter()][string]$ReplaceWith = ""
	)
	if (Test-Path $FilePath) {
		(Get-Content -Path $FilePath).Replace($Find, $ReplaceWith) | Set-Content -Path $FilePath
	} else {
		Write-Warning "File not found: $FilePath"
	}
}
