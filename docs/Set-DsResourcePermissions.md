---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Set-DsResourcePermissions.md
schema: 2.0.0
---

# Set-DsResourcePermissions

## SYNOPSIS
Set permissions on file or registry key

## SYNTAX

```
Set-DsResourcePermissions [[-RegKey] <String>] [[-FilePath] <String>] [<CommonParameters>]
```

## DESCRIPTION
Set ACLs on folder, file and/or registry key to allow local USERS group
to have change/modify access

## EXAMPLES

### EXAMPLE 1
```
Set-DsResourcePermissions -RegKey "HKLM:\SOFTWARE\ToiletBrain\CrappyDoucheware" -FilePath "$env:ProgramFiles\ToiletBrain"
```

## PARAMETERS

### -RegKey
Registry key path.
Example HKLM:\SOFTWARE\Contoso\AppName

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: HKLM:\SOFTWARE\ToiletBrain\CrappyDoucheware
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath
Folder or File path.
Example "c:\toiletflush\crapware"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: C:\Program Files (x86)\ToiletBrain\Crappy Doucheware
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Set-DsResourcePermissions.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Set-DsResourcePermissions.md)

