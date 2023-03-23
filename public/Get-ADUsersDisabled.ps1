function Get-ADUsersDisabled {
	<#
	.SYNOPSIS
		Get AD user accounts which are currently disabled
	.DESCRIPTION
		Get AD user accounts which are disabled along with extended properties
		such as first and last name, UPN, UAC, employee ID, email address, and
		last logon timestamp.
	.PARAMETER SearchBase
		Optional LDAP base path to limit search. Subtree search scope is assumed.
	.PARAMETER Server
		Optional Server or Domain name to limit search.
	.PARAMETER Credential
		Optional Credential to control execution context.
	.EXAMPLE
		Get-ADUsersDisabled
		Returns all disabled user accounts in the current domain.
	.EXAMPLE
		Get-ADUsersDisabled -SearchBase "OU=Sales,DC=contoso,DC=local"
		Limits search to the specified LDAP path in the current domain
	.EXAMPLE
		Get-ADUsersDisabled -Server "sales.contoso.local" -Credential $mycredential
		Limits search to the specified domain context and alternate credential.
		Credential is not required if the current context is trusted in the target environment.
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-ADUsersDisabled.md
	#>
	[CmdletBinding()]
	param (
		[parameter()][string]$SearchBase = "",
		[parameter()][string]$Server = "",
		[parameter()][pscredential]$Credential
	)
	if (!(Get-Module ActiveDirectory -ListAvailable)) {
		Write-Warning "Required PowerShell module not installed: ActiveDirectory"
		break
	}
	$Properties = ("UserPrincipalName","sn","givenName","UserAccountControl","employeeId","mail","lastLogonTimestamp")
	try {
		$params = @{
			AccountDisabled = $True
			UsersOnly = $True
		}
		if (![string]::IsNullOrWhiteSpace($SearchBase)) {
			$params.Add("SearchBase", $SearchBase)
			$params.Add("SearchScope", "Subtree")
		}
		if ($Credential) {
			$params.Add("Credential", $Credential)
		}
		if (![string]::IsNullOrWhiteSpace($Server)) {
			$params.Add("Server", $Server)
		}
		$users = @(Search-ADAccount @params -ErrorAction Stop)
		foreach ($user in $users) {
			$params = @{
				Identity = $user.DistinguishedName
				Properties = $Properties
			}
			if ($Credential) {
				$params.Add("Credential", $Credential)
			}
			if (![string]::IsNullOrWhiteSpace($Server)) {
				$params.Add("Server", $Server)
			}
			$userx = Get-ADUser @params -ErrorAction Stop
			$upath = Split-LDAP $userx.DistinguishedName
			if ($null -ne $userx.lastLogonTimestamp) {
				$llogon = [datetime]::FromFileTime($userx.lastLogonTimestamp).ToString('g')
			} else {
				$llogon = $null
			}
			[pscustomobject]@{
				SamAccountName = $userx.SamAccountName
				UserPrincipalName = $userx.UserPrincipalName
				EmployeeId = $userx.EmployeeId
				EmailAddress = $userx.mail
				UserAccountControl = $userx.UserAccountControl
				LastLogonTimestamp = $llogon
				Path = $upath
			}
		}
	} catch {
		Write-Error $_.Exception.Message
	}
}
