
function Set-WindowsTelemetry {
	<#
	.SYNOPSIS
		Set-DsWindowsTelemetry
	.DESCRIPTION
		Disable Windows 10 Telemetry Collection and Upload
		Disable Connected User Experiences service, and WAP Push service
	.PARAMETER Enable
		True = Enable, False = Disable
	.EXAMPLE
		Set-WindowsTelemetry -Enable $True
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Disable-WindowsTelemetry.md
	#>
	[CmdletBinding()]
	[OutputType()]
	param (
		[parameter(Mandatory)][boolean] $Enable
	)
	try {
		if (-not $Enable) {
			Write-Verbose "Disabling telemetry"
			New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' -Name 'AllowTelemetry' -ItemType DWORD -Value 0 -Force
			Get-Service -Name "diagtrack" | Stop-Service -Force -ErrorAction SilentlyContinue
			Set-Service -Name "diagtrack" -StartupType "Disabled" -ErrorAction SilentlyContinue
			Set-Service -Name "dmwappushsvc" -StartupType "Disabled" -ErrorAction SilentlyContinue
		} else {
			Write-Verbose "Enabling telemetry"
			New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' -Name 'AllowTelemetry' -ItemType DWORD -Value 1 -Force
			Set-Service -Name "diagtrack" -StartupType "Manual" -ErrorAction SilentlyContinue
			Set-Service -Name "dmwappushsvc" -StartupType "Manual" -ErrorAction SilentlyContinue
		}
	}
	catch {
		Write-Error $_.Exception.Message
	}
}
