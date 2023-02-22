---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DsFolderDialog.md
schema: 2.0.0
---

# Get-DsFolderDialog

## SYNOPSIS
Display a Folder selection dialog

## SYNTAX

```
Get-DsFolderDialog [[-InitialDirectory] <String>] [<CommonParameters>]
```

## DESCRIPTION
Display a folder selection dialog to choose a target folder

## EXAMPLES

### EXAMPLE 1
```
$folder = Get-DsFolderDialog -InitialDirectory "c:\projects"
```

## PARAMETERS

### -InitialDirectory
Optional.
If empty, will default to the current default working directory

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DsFolderDialog.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DsFolderDialog.md)

