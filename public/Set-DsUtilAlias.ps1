function Set-DsUtilAlias {
	<#
	.SYNOPSIS
		Read the Description
	.DESCRIPTION
		Read the Synopsis. Just kidding. This function simply creates
		four (4) aliases:
			grep, sed, msgbox, myip
		So you don't need type the full function names:
			Invoke-Grep, Invoke-Sed, Invoke-DialogMsgBox, Get-PublicIPv4Address
		Because I'm really that lazy.
	.PARAMETER (none)
	.EXAMPLE
		Set-DsUtilAlias
	#>
	if (-not (Get-Alias -Name "grep" -ErrorAction SilentlyContinue)) {
		New-Alias -Name "grep" -Value Invoke-Grep
		Write-Host "Define alias: grep"
	}
	if (-not (Get-Alias -Name "sed" -ErrorAction SilentlyContinue)) {
		New-Alias -Name "sed" -Value Invoke-Sed
		Write-Host "Define alias: sed"
	}
	if (-not (Get-Alias -Name "msgbox" -ErrorAction SilentlyContinue)) {
		New-Alias -Name "msgbox" -Value Invoke-DialogMsgBox
		Write-Host "Define alias: msgbox"
	}
	if (-not (Get-Alias -Name "myip" -ErrorAction SilentlyContinue)) {
		New-Alias -Name "myip" -Value Get-PublicIPv4Address
		Write-Host "Define alias: myip"
	}
}