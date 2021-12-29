function Invoke-DsMaintenance {
	<#
	.SYNOPSIS
		Run Maintenance Tasks
	.DESCRIPTION
		Run Ds-Utils Maintenance Tasks
	.PARAMETER Update
		All, Modules, Windows, Packages...
		* Modules = PowerShell modules
		* Windows = Windows Updates
		* Packages = Chocolatey Packages
		Default = ALL
	.PARAMETER ForceReboot
		Initiates a restart upon completion
	.PARAMETER ForceUpdate
		Applies the -Force parameter Update-Module
	.EXAMPLE
		Invoke-DsMaintenance -Update Modules
		Updates PowerShell modules only
	.EXAMPLE
		Invoke-DsMaintenance -ForceReboot
		Runs all update tasks and forces a restart at the end
	.EXAMPLE
		Invoke-DsMaintenance -ForceUpdate
		Runs all update tasks with -Force applied to module updates
	.NOTES
		Module AZ may display errors if the current shell has active references to Az.Accounts cmdlets
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-DsMaintenance.md
	#>
	[CmdletBinding()]
	[OutputType()]
	param (
		[parameter(Position=0)] [ValidateSet('All','Modules','Windows','Packages')] [string] $Update = 'All',
		[parameter()] [switch] $ForceReboot,
		[parameter()] [switch] $ForceUpdate
	)
	try {
		if ($Update -in ('All','Modules')) {
			Write-DsLog -Message "updating powershell modules"
			$modules = (Get-Module -ListAvailable).Name | Select-Object -Unique | Sort-Object
			Write-DsLog -Message "$($modules.Count) modules are installed"
			$mn = 1
			$modules | Foreach-Object {
				Write-DsLog -Message "updating module $mn of $($modules.Count): $_"
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
					Write-DsLog -Message "failed to update: $($Error[0].Exception.Message)" -Category Error
				}
				$mn++
			}
			Write-DsLog -Message "powershell modules have been updated"
		}
		if ($Update -in ('All','Packages')) {
			if (Test-Path (Join-Path $env:ProgramData "chocolatey\choco.exe")) {
				Write-DsLog -Message "updating chocolatey packages"
				cup all -y
				Write-DsLog -Message "chocolatey packages have been updated"
			}
			else {
				Write-DsLog -Message "chocolatey is not installed (skipping updates)" -Category 'Warning'
			}
		}
		if ($Update -in ('All','Windows')) {
			Write-DsLog -Message "updating windows and office products"
			$res = Get-WindowsUpdate -AcceptAll -Install -WindowsUpdate -IgnoreReboot
			Write-DsLog -Message "$($res.Count) windows updates were applied"
		}
		if (Test-DsRebootPending) {
			Write-DsLog "tasks completed (reboot required)"
			if ($ForceReboot) {
				Write-Output 1641
				Write-DsLog -Message "rebooting computer in 15 seconds"
				Restart-Computer -Timeout 15
			}
		}
		else {
			Write-DsLog -Message "tasks completed"
			Write-Output 0
		}
	}
	catch {
		Write-DsLog -Message "$($Error[0].Exception.Message)" -Category 'Error'
		Write-Output -1
	}
}