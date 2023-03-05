---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-Shortcut.md
schema: 2.0.0
---

# Get-Shortcut

## SYNOPSIS
Get-DsShortcut

## SYNTAX

```
Get-Shortcut [-Path] <String> [<CommonParameters>]
```

## DESCRIPTION
Return shortcut properties

## EXAMPLES

### EXAMPLE 1
```
Get-Shortcut -Path "$($env:USERPROFILE)\Desktop\GitHub Desktop.lnk"
```

## PARAMETERS

### -Path
Path and name of .lnk file

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-Shortcut.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-Shortcut.md)

