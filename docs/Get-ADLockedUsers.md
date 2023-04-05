---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-ADLockedUsers.md
schema: 2.0.0
---

# Get-ADLockedUsers

## SYNOPSIS
Get Active Directory user accounts which are currently locked

## SYNTAX

```
Get-ADLockedUsers [[-EventID] <Int32>] [[-LogName] <String>] [[-DaysBack] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Get Active Directory user accounts which are currently locked

## EXAMPLES

### EXAMPLE 1
```
Get-ADLockedUsers -DaysBack 7
```

## PARAMETERS

### -EventID
Required.
Event ID of user account lock event.
Default = 4740

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 4740
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogName
Required.
Name of Windows Event Log to search.
Default = "Security"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Security
Accept pipeline input: False
Accept wildcard characters: False
```

### -DaysBack
Required.
Number of days to search back from current date.
Range = 1 to 30.
Default = 3

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 3
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Requires ActiveDirectory PowerShell module (RSAT installed, or on a DC)

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-ADLockedUsers.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-ADLockedUsers.md)

