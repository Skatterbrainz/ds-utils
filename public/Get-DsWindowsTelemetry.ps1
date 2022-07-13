function Get-DsWindowsTelemetry {
	<#
	.SYNOPSIS
		Get-DsWindowsTelemetry
	.DESCRIPTION
		Returns current Windows telemetry state information
	.EXAMPLE
		Get-DsWindowsTelemetry
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DsWindowsTelemetry.md
	#>
	[CmdletBinding()]
	param()
	try {
		$vx  = 'Default'
		$s1x = 'NotDefined'
		$s2x = 'NotDefined'
		$keypath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection'
		$s1 = Get-Service -Name "diagtrack" -ErrorAction SilentlyContinue
		$s2 = Get-Service -Name "dmwappushsvc" -ErrorAction SilentlyContinue
		if ($s1) { $s1x = $s1.Status }
		if ($s2) { $s2x = $s2.Status }
		if (Get-Item -Path $keypath -ErrorAction SilentlyContinue) {
			if ($v = Get-ItemProperty -Path $keypath -Name 'AllowTelemetry' -ErrorAction SilentlyContinue) {
				if ($v.AllowTelemetry -eq 1) {
					$vx = 'Enabled'
				} else {
					$vx = 'Disabled'
				}
			}
		}
		[pscustomobject]@{
			DiagTrackingService = $s1x
			DiagAppPushService = $s2x
			TelemetryState = $vx
		}
	}
	catch {
		Write-DsLog -Message $_.Exception.Message -Category Error
	}
}