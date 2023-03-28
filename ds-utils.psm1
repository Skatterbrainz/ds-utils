('public') | Foreach-Object {
	Get-ChildItem -Path $(Join-Path -Path $PSScriptRoot -ChildPath $_) -Filter "*.ps1" | Foreach-Object { . $_.FullName }
}
if (-not (Get-Alias -Name "grep")) {
	New-Alias -Name "grep" -Value Invoke-Grep
	Write-Host "Define alias: grep"
}
if (-not (Get-Alias -Name "sed")) {
	New-Alias -Name "sed" -Value Invoke-Sed
	Write-Host "Define alias: sed"
}
if (-not (Get-Alias -Name "msgbox")) {
	New-Alias -Name "msgbox" -Value Invoke-DialogMsgBox
	Write-Host "Define alias: msgbox"
}
if (-not (Get-Alias -Name "myip")) {
	New-Alias -Name "myip" -Value Get-PublicIPv4Address
	Write-Host "Define alias: myip"
}