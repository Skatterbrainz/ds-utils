function Invoke-CleanModules {
	<#
	.SYNOPSIS
		Remove older PowerShell module versions
	.DESCRIPTION
		Remove older PowerShell module versions
	.PARAMETER Name
		Optional. Name of specific module. Default is all modules
	.PARAMETER CleanUp
		Optional. If included: attempt removal of older module versions
	.EXAMPLE
		Invoke-CleanModules
		Analyze all installed modules
	.EXAMPLE
		Invoke-CleanModules -Name Mailozaurr
		Analyze module Mailozaurr only
	.EXAMPLE
		Invoke-CleanModules -Name Mailozaurr -CleanUp
		Analyze and clean-up module Mailozaurr only
	.EXAMPLE
		Invoke-CleanModules -CleanUp
		Analyze and clean-up all installed modules
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-CleanModules.md
	#>
	[CmdletBinding()]
	[OutputType()]
	param(
		[parameter(Mandatory=$False)][string]$Name = "",
		[parameter(Mandatory=$False)][switch]$CleanUp
	)
	if ([string]::IsNullOrEmpty($Name)) {
		Write-Host "Getting installed modules" -ForegroundColor Green
		[array]$modules = Get-Module -ListAvailable | Select-Object -ExpandProperty Name | Sort-Object -Unique
		Write-Host "$($modules.Count) modules are installed" -ForegroundColor Green
	} else {
		Write-Host "Getting $Name installations" -ForegroundColor Green
		[array]$modules = Get-Module -Name $Name -ListAvailable | Select-Object -ExpandProperty Name | Sort-Object -Unique
	}
	foreach ($module in $modules) {
		[array]$mdata = Get-Module $module -ListAvailable
		$mname = $mdata[0].Name 
		[array]$mv = $($mdata.Version | Sort-Object -Descending)
		if ($mdata.Path.StartsWith("c:\users")) {
			$mscope = 'User'
		} else {
			$mscope = 'Machine'
		}
		if (!$CleanUp) {
			[pscustomobject]@{
				Name = $mname
				Versions = $mv
				Latest = $($mv[0] -join '.')
				Scope = $mscope
			}
		} else {
			$vc = $mv.Count
			if ($vc -eq 1) {
				Write-Host "No older versions to clean up"
			} else {
				if ($vc -gt 2) {
					[array]$vx = $mv[1..$($vc--)]
				} else {
					[array]$vx = $mv[1]
				}
				Write-Host "Name: $mname"
				Write-Host "Latest: $($mv[0] -join '.')"
				foreach ($v in $vx) {
					try {
						Write-Host "Removing version: $($v -join '.')"
						Uninstall-Module -Name $mname -RequiredVersion $($v -join '.') -Force
					}
					catch {
						Write-Error $_.Exception.Message
					}
				}
			}
		}
	}
}