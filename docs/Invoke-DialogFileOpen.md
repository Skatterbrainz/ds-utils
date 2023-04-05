---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-DialogFileOpen.md
schema: 2.0.0
---

# Invoke-DialogFileOpen

## SYNOPSIS
Display a file open dialog form

## SYNTAX

```
Invoke-DialogFileOpen [[-InitialDirectory] <String>] [[-Filter] <String>] [[-Title] <String>] [-MultiSelect]
 [<CommonParameters>]
```

## DESCRIPTION
Display a file open dialog form to select one or more files to return the full names.

## EXAMPLES

### EXAMPLE 1
```
$files = Invoke-DialogFileOpen -InitialDirectory "c:\projects" -Filter "Python Files (*.py)|*.py" -Title "Select Files" -MultiSelect
```

## PARAMETERS

### -InitialDirectory
Default folder location

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
Optional.
File type filter, using paired format as follows:
* Default is "All Files (*.*)|*.*"
* Format is "Text Files (*.txt)|*.txt"

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
Optional.
Dialog form caption.
Default is "Select File"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: Select File
Accept pipeline input: False
Accept wildcard characters: False
```

### -MultiSelect
Optional.
Allows selecting multiple files.
Default is single selection only.

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

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-DialogFileOpen.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-DialogFileOpen.md)

