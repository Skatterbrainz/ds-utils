---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-DsFileSaveDialog.md
schema: 2.0.0
---

# Invoke-DsFileSaveDialog

## SYNOPSIS
Display a file Save or SaveAs dialog

## SYNTAX

```
Invoke-DsFileSaveDialog [[-InitialDirectory] <String>] [[-Filter] <String>] [[-Title] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Same as the synopsis

## EXAMPLES

### EXAMPLE 1
```
$filepath = Invoke-DsFileSaveDialog
```

## PARAMETERS

### -InitialDirectory
Default directory location

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

### -Filter
File type filter.
Default is "All Files (*.*)|*.*"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: All Files (*.*)|*.*
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
Dialog caption

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: Save File
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-DsFileSaveDialog.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-DsFileSaveDialog.md)

