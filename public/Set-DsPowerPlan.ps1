function Set-DsPowerPlan {
	<#
	.SYNOPSIS
		Set Active Power Plan
	.DESCRIPTION
		Set Active Power Plan from a list of standard names
	.PARAMETER Plan
		Name of power plan to set active.
		Balanced, Performance, HighPerformance, PowerSaver, EnergyStar, Custom
	.PARAMETER FileName
		PowerPlan file to import and set Active, when PlanName is set to Custom
	.EXAMPLE
		Set-DsPowerPlan -Name "Performance"
	.EXAMPLE
		Set-DsPowerPlan -Name "Custom" -FileName "c:\customplan.pow"
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Set-DsPowerPlan.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory=$True, HelpMessage="Power scheme name")]
			[ValidateSet('Balanced','HighPerformance','Performance','PowerSaver','EnergyStar','Custom')]
			[alias('PlanName','Plan')][string] $Name,
		[parameter(Mandatory=$False, HelpMessage="Custom power plan filename")]
			[ValidateNotNullOrEmpty()]
			[string] $FileName = ""
	)
	#Power Scheme GUID: 1ca6081e-7f76-46f8-b8e5-92a6bd9800cd (Maximum Battery
	#Power Scheme GUID: 2ae0e187-676e-4db0-a121-3b7ddeb3c420 (Power Source Opt
	#Power Scheme GUID: 37aa8291-02f6-4f6c-a377-6047bba97761 (Timers off (Pres
	#Power Scheme GUID: a666c91e-9613-4d84-a48e-2e4b7a016431 (Maximum Performa
	#Power Scheme GUID: e11a5899-9d8e-4ded-8740-628976fc3e63 (Video Playback)
	#9586a712-fcb4-4a06-af4b-52803dfbb9db = Performance
	try {
		$result = 0
		if ($Name -eq 'Custom') {
			if (Test-Path -Path $FileName) {
				POWERCFG -IMPORT $FileName
			}
			else {
				Write-Warning "Power Config file not found: $FileName"
				$result = -1
			}
		}
		else {
			switch ($Name) {
				'HighPerformance' {
					$ppguid = '8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c'
				}
				'Performance' {
					$ppguid = '9586a712-fcb4-4a06-af4b-52803dfbb9db'
				}
				'Balanced' {
					$ppguid = '381b4222-f694-41f0-9685-ff5bb260df2e'
				}
				'PowerSaver' {
					$ppguid = 'a1841308-3541-4fab-bc81-f71556f20b4a'
				}
				'EnergyStar' {
					$ppguid = 'de7ef2ae-119c-458b-a5a3-997c2221e76e'
				}
			}
			$currentScheme = POWERCFG -GETACTIVESCHEME
			$currentScheme = $currentScheme.Split()
			if ($currentScheme[3] -ne $ppguid) {
				Write-Host "Current plan is $($currentScheme[5])"
				POWERCFG -SETACTIVE $ppguid
				$newScheme = POWERCFG -GETACTIVESCHEME
				$newScheme = $($newScheme.Split('(')[1]).Replace(')','')
				Write-DsLog -Message "Active plan is now $newScheme"
			}
			else {
				Write-DsLog -Message "Current plan is already $Name"
			}
		}
		Write-Output $result
	}
	catch {
		Write-DsLog -Message $Error[0].Exception.Message -Category Error
	}
}