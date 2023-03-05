function Remove-AppxPackages {
	<#
	.SYNOPSIS
		Removes AppxPackages for current user only
	.DESCRIPTION
		Removes AppxPackages for current user only
	.PARAMETER Name
		Name of Appx Package, or multiple names
	.EXAMPLE
		Remove-AppxPackages -Name ('xbox','zune')
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Remove-AppxPackages.md
	#>
	[CmdletBinding()]
	[OutputType()]
	param (
		[parameter()]
		[ValidateNotNullOrEmpty()]
		[alias('Package','PackageName')][string[]] $Name = ('xbox','skype','zune','officehub','solitaire')
	)
	Write-Host "removing windows store apps for current user" -ForegroundColor cyan
	# use: (Get-AppxPackage).Name to display package names
	foreach ($pkg in $Name) {
		try {
			Write-Host "Removing appx package: $pkg"
			Get-AppxPackage |
				Where-Object {$_.Name -match $pkg} |
					Remove-AppxPackage -ErrorAction Stop
		}
		catch {
			Write-Error $_.Exception.Message
		}
	}
}
