
function Set-DsWindowsTelemetry {
	<#
	.SYNOPSIS
		Disable Windows 10 Telemetry Collection and Upload
	.DESCRIPTION
		Disable Windows 10 Telemetry Collection and Upload
		Disable Connected User Experiences service, and WAP Push service
	.PARAMETER State
		Enable or Disable
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Disable-DsWindowsTelemetry.md
	#>
	[CmdletBinding()]
	[OutputType()]
	param (
		[parameter(Mandatory)]
		[ValidateSet('Enable','Disable')][string] $State
	)
	try {
		Write-DsLog -Message "setting windows telemetry to $State"
		if ($State -eq 'Disable') {
			New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' -Name 'AllowTelemetry' -ItemType DWORD -Value 0 -Force
			Get-Service -Name "diagtrack" | Stop-Service -Force -ErrorAction SilentlyContinue
			Set-Service -Name "diagtrack" -StartupType "Disabled" -ErrorAction SilentlyContinue
			Set-Service -Name "dmwappushsvc" -StartupType "Disabled" -ErrorAction SilentlyContinue
		}
		else {
			New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' -Name 'AllowTelemetry' -ItemType DWORD -Value 1 -Force
			Set-Service -Name "diagtrack" -StartupType "Manual" -ErrorAction SilentlyContinue
			Set-Service -Name "dmwappushsvc" -StartupType "Manual" -ErrorAction SilentlyContinue
		}
	}
	catch {
		Write-DsLog -Message $Error[0].Exception.Message -Category Error
	}
}
