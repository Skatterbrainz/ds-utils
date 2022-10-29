function Remove-DsAppxPackages {
	<#
	.SYNOPSIS
		Removes AppxPackages for current user only
	.DESCRIPTION
		Removes AppxPackages for current user only
	.PARAMETER PackageName
		Name of Appx Package, or multiple names
	.EXAMPLE
		Remove-DsAppxPackages -PackageName ('xbox','zune')
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Remove-DsAppxPackages.md
	#>
	[CmdletBinding()]
	[OutputType()]
	param (
		[parameter()]
		[ValidateNotNullOrEmpty()]
		[alias('Name','Package')][string[]] $PackageName = ('xbox','skype','zune','officehub','solitaire')
	)
	Write-Host "removing windows store apps for current user" -ForegroundColor cyan
	# use: (Get-AppxPackage).Name to display package names
	foreach ($pkg in $PackageNames) {
		try {
			Write-DsLog -Message "Removing appx package: $pkg"
			Get-AppxPackage |
				Where-Object {$_.Name -match $pkg} | 
					Remove-AppxPackage -ErrorAction Stop
		}
		catch {
			Write-DsLog -Message $($_.Exception.Message) -Category Error
			Write-Error $_.Exception.Message
		}
	}
}
