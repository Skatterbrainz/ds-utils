
function Set-DsResourcePermissions {
	<#
	.SYNOPSIS
		Set permissions on file or registry key
	.DESCRIPTION
		Set ACLs on folder, file and/or registry key to allow local USERS group
		to have change/modify access
	.PARAMETER RegKey
		Registry key path. Example HKLM:\SOFTWARE\Contoso\AppName
	.PARAMETER FilePath
		Folder or File path. Example "c:\toiletflush\crapware"
	.EXAMPLE
		Set-DsResourcePermissions -RegKey "HKLM:\SOFTWARE\ToiletBrain\CrappyDoucheware" -FilePath "$env:ProgramFiles\ToiletBrain"
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Set-DsResourcePermissions.md
	#>
	[CmdletBinding()]
	[OutputType()]
	param (
		[parameter()][alias('RegKey')][string] $Key = "HKLM:\SOFTWARE\ToiletBrain\CrappyDoucheware",
		[parameter()][alias('FilePath')][string] $Path = 'C:\Program Files (x86)\ToiletBrain\Crappy Doucheware'
	)
	if (![string]::IsNullOrEmpty($Key)) {
		if (Test-Path $Key) {
			Write-DsLog -Message "Applying permissions to registry: $Key"
			try {
				Grant-CPermission -Path $Key -Identity "Users" -Permission ReadKey,WriteKey,SetValue,EnumerateSubKeys,QueryValues
				Write-DsLog -Message "Permissions have been applied successfully"
			}
			catch {
				Write-DsLog -Message "the toilet won't flush. call that sr. executive architect guy. $($Error[0].Exception.Message)" -Category Error
			}
		}
	}
	if (![string]::IsNullOrEmpty($Path)) {
		if (Test-Path $Path) {
			Write-DsLog -Message "applying permissions to filepath: $Path"
			try {
				Grant-CPermission -Path $Path -Identity "Users" -Permission Modify
				Write-DsLog -Message "Permissions have been applied successfully"
			}
			catch {
				Write-DsLog -Message "you can't flush beer cans in the toilet! $($Error[0].Exception.Message)" -Category Error
			}
		}
	}
}