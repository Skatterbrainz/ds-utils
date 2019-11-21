---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Set-DsComputerName.md
schema: 2.0.0
---

# Set-DsComputerName

## SYNOPSIS
Rename computer using common standard format

## SYNTAX

```
Set-DsComputerName [[-MaxNameLength] <Int32>] [-FormCode <String>] [-NoHyphen] [-Reboot] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
I hate repeating myself

## EXAMPLES

### EXAMPLE 1
```
Set-DsComputerName
```

(Defaults) results in name like "L-123456789"

### EXAMPLE 2
```
Set-DsComputerName -FormCode Suffix -NoHyphen
```

Results in name like "123456789L"

### EXAMPLE 3
```
Set-DsComputerName -FormCode None -MaxNameLength 8
```

Results in name like "12345678"

## PARAMETERS

### -MaxNameLength
Maximum length of new name (default is 15, which is the limit for Windows)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 15
Accept pipeline input: False
Accept wildcard characters: False
```

### -FormCode
Form-factor code placement: Prefix (default), Suffix, or None

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Prefix
Accept pipeline input: False
Accept wildcard characters: False
```

### -NoHyphen
Do not insert a hyphen separator between FormCode and SerialNumber

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

### -Reboot
Force a reboot at the end (default = no reboot)

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Actual Serial Number is used from WMI class Win32_SystemEnclosure
Chassis Type number is taken from Win32_SystemEnclosure and uses first
    element of result only, since docking stations, port replicators
    may return an array like (10,12) where 10 is the laptop, and 12 is the dock

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Set-DsComputerName.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Set-DsComputerName.md)

