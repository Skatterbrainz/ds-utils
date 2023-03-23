---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-ADUsersDisabled.md
schema: 2.0.0
---

# Get-ADUsersDisabled

## SYNOPSIS
Get AD user accounts which are currently disabled

## SYNTAX

```
Get-ADUsersDisabled [[-SearchBase] <String>] [[-Server] <String>] [[-Credential] <PSCredential>]
 [<CommonParameters>]
```

## DESCRIPTION
Get AD user accounts which are disabled along with extended properties
such as first and last name, UPN, UAC, employee ID, email address, and
last logon timestamp.

## EXAMPLES

### EXAMPLE 1
```
Get-ADUsersDisabled
Returns all disabled user accounts in the current domain.
```

### EXAMPLE 2
```
Get-ADUsersDisabled -SearchBase "OU=Sales,DC=contoso,DC=local"
Limits search to the specified LDAP path in the current domain
```

### EXAMPLE 3
```
Get-ADUsersDisabled -Server "sales.contoso.local" -Credential $mycredential
Limits search to the specified domain context and alternate credential.
Credential is not required if the current context is trusted in the target environment.
```

## PARAMETERS

### -SearchBase
Optional LDAP base path to limit search.
Subtree search scope is assumed.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Server
Optional Server or Domain name to limit search.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Optional Credential to control execution context.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-ADUsersDisabled.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-ADUsersDisabled.md)

