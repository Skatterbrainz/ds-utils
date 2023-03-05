---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-WindowsMaintenance.md
schema: 2.0.0
---

# Invoke-WindowsMaintenance

## SYNOPSIS
Run Maintenance Tasks

## SYNTAX

```
Invoke-WindowsMaintenance [-WindowsUpdate] [-MicrosoftUpdate] [-ChocolateyPackages] [-WingetPackages]
 [-Modules] [-ForceReboot] [-ForceUpdate] [<CommonParameters>]
```

## DESCRIPTION
Run Ds-Utils Maintenance Tasks

## EXAMPLES

### EXAMPLE 1
```
Invoke-WindowsMaintenance -Modules
Updates PowerShell modules only
```

### EXAMPLE 2
```
Invoke-WindowsMaintenance -WindowsUpdate -Modules -WingetPackages -ForceReboot
Invokes Windows updates, PowerShell module updates and WinGet package updates, and forces a restart at the end
```

### EXAMPLE 3
```
Invoke-WindowsMaintenance -ForceUpdate
Runs all update tasks with -Force applied to module updates
```

## PARAMETERS

### -WindowsUpdate
Invoke Windows updates
If no switches are provided, this option is derived as $True

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

### -MicrosoftUpdate
Invoke Microsoft updates

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

### -ChocolateyPackages
Invoke Chocolatey package updates (if Chocolatey is installed)

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

### -WingetPackages
Invoke WinGet package updates (if Winget is installed)

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

### -Modules
Invoke PowerShell module updates

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

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-WindowsMaintenance.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-WindowsMaintenance.md)

