---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-CleanModules.md
schema: 2.0.0
---

# Invoke-CleanModules

## SYNOPSIS
Remove older PowerShell module versions

## SYNTAX

```
Invoke-CleanModules [[-Name] <String>] [-CleanUp] [<CommonParameters>]
```

## DESCRIPTION
Remove older PowerShell module versions

## EXAMPLES

### EXAMPLE 1
```
Invoke-CleanModules
Analyze all installed modules
```

### EXAMPLE 2
```
Invoke-CleanModules -Name Mailozaurr
Analyze module Mailozaurr only
```

### EXAMPLE 3
```
Invoke-CleanModules -Name Mailozaurr -CleanUp
Analyze and clean-up module Mailozaurr only
```

### EXAMPLE 4
```
Invoke-CleanModules -CleanUp
Analyze and clean-up all installed modules
```

## PARAMETERS

### -Name
Optional.
Name of specific module.
Default is all modules

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

### -CleanUp
Optional.
If included: attempt removal of older module versions

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

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-CleanModules.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-CleanModules.md)

