---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DsDefaultAppAssociations.md
schema: 2.0.0
---

# Get-DsDefaultAppAssociations

## SYNOPSIS
Get Windows default app associations table

## SYNTAX

```
Get-DsDefaultAppAssociations [[-FilePath] <String>] [[-RefreshDays] <Int32>] [-Force] [<CommonParameters>]
```

## DESCRIPTION
Returns default app associations for the current user

## EXAMPLES

### EXAMPLE 1
```
Get-DsDefaultAppAssociations
```

### EXAMPLE 2
```
Get-DsDefaultAppAssociations -Force
```

## PARAMETERS

### -FilePath
Path where export file is saved/maintained.
Default is user Documents path, filename is defaultapps.xml

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: "$($env:USERPROFILE)\documents\defaultapps.xml"
Accept pipeline input: False
Accept wildcard characters: False
```

### -RefreshDays
Number of days to reuse export file until forcing a refresh.
The default is seven (7) days

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 7
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Force a refresh of the export file

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DsDefaultAppAssociations.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DsDefaultAppAssociations.md)

