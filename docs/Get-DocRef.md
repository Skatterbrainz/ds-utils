---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DocRef.md
schema: 2.0.0
---

# Get-DocRef

## SYNOPSIS
Opens link to Microsoft Doc for Variable Data Type

## SYNTAX

```
Get-DocRef [-VariableRef] <Object> [-Search] [<CommonParameters>]
```

## DESCRIPTION
Opens a link in a web browser to the Microsoft Doc page for the
data type associated with a PowerShell variable.
The Search parameter
searches Google for the variable type, for situations when there is no
direct MS Doc page available.

## EXAMPLES

### EXAMPLE 1
```
$myVar | Get-DocRef
```

If $myVar is of type System.Array, opens

### EXAMPLE 2
```

```

## PARAMETERS

### -VariableRef
PowerShell variable (object)

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Search
Switch to perform search instead of direct link

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

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DocRef.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DocRef.md)

