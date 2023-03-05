---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/ConvertFrom-HexErrorCode.md
schema: 2.0.0
---

# ConvertFrom-HexErrorCode

## SYNOPSIS
Convert from Hex Error code

## SYNTAX

```
ConvertFrom-HexErrorCode [-HexErrorCode] <Object> [<CommonParameters>]
```

## DESCRIPTION
Convert Hex error code

## EXAMPLES

### EXAMPLE 1
```
0xC00D2717L | ConvertFrom-HexErrorCode
returns: 3222087447
```

## PARAMETERS

### -HexErrorCode
Error code to convert

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
By Trevor Jones - https://smsagent.blog/2015/06/25/translating-error-codes-for-windows-and-configuration-manager/

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/ConvertFrom-HexErrorCode.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/ConvertFrom-HexErrorCode.md)

