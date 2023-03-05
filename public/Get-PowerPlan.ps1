function Get-PowerPlan {
	[CmdletBinding()]
	[OutputType()]
	<#
	.SYNOPSIS
		Returns the active Power Plan Name
	.DESCRIPTION
		Returns the active Power Plan Name
	.EXAMPLE
		Get-PowerPlan
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-PowerPlan.md
	#>
	param()
	$pplist = POWERCFG -LIST | Where-Object {$_ -like "Power Scheme*"}
	foreach ($pp in $pplist) {
		$pdata = (($pp.Split(":")).Trim())[1]
		$pguid = $pdata.Split(" ")[0]
		$pname = ($pdata.Split("(")[1]).Replace(")","")
		if ($pname.EndsWith("`*")) {
			$pname = $pname.Replace(" `*","")
			$data = @{
				Name = $pname
				GUID = $pguid
				IsActive = $True
			}
		}
		else {
			$data = @{
				Name = $pname
				GUID = $pguid
				IsActive = $False
			}
		}
		$(New-Object -TypeName PSObject -Property $data)
	}
}
