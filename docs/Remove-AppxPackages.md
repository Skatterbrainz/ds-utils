---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Remove-AppxPackages.md
schema: 2.0.0
---

# Remove-AppxPackages

## SYNOPSIS
Removes AppxPackages for current user only

## SYNTAX

```
Remove-AppxPackages [[-Name] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Removes AppxPackages for current user only

## EXAMPLES

### EXAMPLE 1
```
Remove-AppxPackages -Name ('xbox','zune')
```

## PARAMETERS

### -Name
Name of Appx Package, or multiple names

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Package, PackageName

Required: False
Position: 1
Default value: ('xbox','skype','zune','officehub','solitaire')
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Remove-AppxPackages.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Remove-AppxPackages.md)

