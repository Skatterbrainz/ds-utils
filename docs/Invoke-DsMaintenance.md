---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-DsMaintenance.md
schema: 2.0.0
---

# Invoke-DsMaintenance

## SYNOPSIS
Run Maintenance Tasks

## SYNTAX

```
Invoke-DsMaintenance [[-Update] <String>] [-ForceReboot] [-ForceUpdate] [<CommonParameters>]
```

## DESCRIPTION
Run Ds-Utils Maintenance Tasks

## EXAMPLES

### EXAMPLE 1
```
Invoke-DsMaintenance -Update Modules
```

Updates PowerShell modules only

### EXAMPLE 2
```
Invoke-DsMaintenance -ForceReboot
```

Runs all update tasks and forces a restart at the end

### EXAMPLE 3
```
Invoke-DsMaintenance -ForceUpdate
```

Runs all update tasks with -Force applied to module updates

## PARAMETERS

### -Update
All, Modules, Windows, Packages...
* Modules = PowerShell modules
* Windows = Windows Updates
* Packages = Chocolatey Packages
Default = ALL

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: All
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForceReboot
Initiates a restart upon completion

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: Reboot

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ForceUpdate
Applies the -Force parameter Update-Module

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
Module AZ may display errors if the current shell has active references to Az.Accounts cmdlets

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-DsMaintenance.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-DsMaintenance.md)

