function Invoke-WindowsMaintenance {
	<#
	.SYNOPSIS
		Run Maintenance Tasks
	.DESCRIPTION
		Run Ds-Utils Maintenance Tasks
	.PARAMETER WindowsUpdate
		Invoke Windows updates
		If no switches are provided, this option is derived as $True
	.PARAMETER MicrosoftUpdate
		Invoke Microsoft updates
	.PARAMETER ChocolateyPackages
		Invoke Chocolatey package updates (if Chocolatey is installed)
	.PARAMETER WingetPackages
		Invoke WinGet package updates (if Winget is installed)
	.PARAMETER Modules
		Invoke PowerShell module updates
	.PARAMETER ForceReboot
		Initiates a restart upon completion
	.PARAMETER ForceUpdate
		Applies the -Force parameter Update-Module
	.EXAMPLE
		Invoke-WindowsMaintenance -Modules
		Updates PowerShell modules only
	.EXAMPLE
		Invoke-WindowsMaintenance -WindowsUpdate -Modules -WingetPackages -ForceReboot
		Invokes Windows updates, PowerShell module updates and WinGet package updates, and forces a restart at the end
	.EXAMPLE
		Invoke-WindowsMaintenance -ForceUpdate
		Runs all update tasks with -Force applied to module updates
	.NOTES
		Module AZ may display errors if the current shell has active references to Az.Accounts cmdlets
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-WindowsMaintenance.md
	#>
	[CmdletBinding()]
	[OutputType()]
	param (
		[parameter()][switch]$WindowsUpdate,
		[parameter()][switch]$MicrosoftUpdate,
		[parameter()][switch]$ChocolateyPackages,
		[parameter()][switch]$WingetPackages,
		[parameter()][switch]$Modules,
		[parameter()][alias('Reboot')][switch] $ForceReboot,
		[parameter()][switch] $ForceUpdate
	)
	try {
		if (!($WindowsUpdate -or $Modules -or $ChocolateyPackages -or $WingetPackages)) {
			$WindowsUpdate = $True
		}
		if ($Modules) {
			Write-Host "updating powershell modules"
			$modules = (Get-Module -ListAvailable).Name | Select-Object -Unique | Sort-Object
			Write-Host "$($modules.Count) modules are installed"
			$mn = 1
			$modules | Foreach-Object {
				Write-Host "updating module $mn of $($modules.Count): $_"
				$error.Clear()
				try {
					if ($ForceUpdate) {
						Update-Module -Name $_ -Force -ErrorAction SilentlyContinue
					}
					else {
						Update-Module -Name $_ -ErrorAction SilentlyContinue
					}
				}
				catch {
					Write-Host "failed to update: $($Error[0].Exception.Message)"
				}
				$mn++
			}
			Write-Host "powershell modules have been updated"
		}
		if ($ChocolateyPackages) {
			if (Test-Path (Join-Path $env:ProgramData "chocolatey\choco.exe")) {
				Write-Host "updating chocolatey packages"
				cup all -y
				Write-Host "chocolatey packages have been updated"
			}
			else {
				Write-Host "chocolatey is not installed (skipping updates)"
			}
		}
		if ($WingetPackages) {
			if (Test-Path 'C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_1.19.10173.0_x64__8wekyb3d8bbwe\winget.exe') {
				Write-Host "updating winget packages"
				winget upgrade --all
			} else {
				Write-Host "winget is not installed (skipping updates)"
			}
		}
		if ($WindowsUpdate) {
			Write-Host "updating windows and office products"
			$res = Get-WindowsUpdate -AcceptAll -Install -WindowsUpdate -IgnoreReboot
			Write-Host "$($res.Count) windows updates were applied"
		}
		if ($MicrosoftUpdate) {
			Write-Host "updating microsoft products"
			$res = Get-WindowsUpdate -AcceptAll -Install -MicrosoftUpdate -IgnoreReboot
			Write-Host "$($res.Count) microsoft updates were applied"
		}
		if (Test-RebootPending) {
			Write-Host "tasks completed (reboot required)"
			if ($ForceReboot) {
				Write-Output 1641
				Write-Host "rebooting computer in 15 seconds"
				Restart-Computer -Timeout 15
			}
		} else {
			Write-Host "tasks completed"
			Write-Output 0
		}
	}
	catch {
		Write-Host "$($Error[0].Exception.Message)"
		Write-Output -1
	}
}
