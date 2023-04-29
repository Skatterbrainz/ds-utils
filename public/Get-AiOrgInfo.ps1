function Get-AiOrgInfo {
	<#
	.SYNOPSIS
		Returns information about an organization using OpenAI to do the searching
	.DESCRIPTION
		Returns information about an organization using OpenAI to do the searching
	.PARAMETER Name
		The name of the organization or business.
	.EXAMPLE
		Get-AiOrgInfo 'Amazon'
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-AiOrgInfo.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory)][string]$Name
	)
	if (!(Get-Module PowerShellAI -ListAvailable)) {
		Write-Warning "Requires PowerShell module: PowerShellAI"
	} else {
		$owner = ""; $se = ""; $sp = ""
		$owned = ai "Response with yes or no only: Is $Name owned by another business entity?"
		if ($owned -eq "Yes") {
			$owner = ai "What is the name of the business entity that owns the business '$Name'?"
		}
		$founded = ai "When was $Name founded?"
		$pub = ai "Response with yes or no only: Is $Name a publicly-traded business?"
		if ($pub -eq "Yes") {
			$se = ai "What exchange trades stock shares for '$Name'?"
			$sp = ai "What is the current stock share price for '$Name'?"
		}
		$web = ai "Without any other text, what is the URL to the main web site for '$Name'?"
		[PSCustomObject]@{
			Name = $Name
			Founded = $founded
			Web = $web
			Public = $pub
			Exchange = $se
			Price = $sp
			Subsidiary = $owned
			Owner = $owner
		}
	}
}