---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Set-DsPowerPlan.md
schema: 2.0.0
---

# Set-DsPowerPlan

## SYNOPSIS
Set Active Power Plan

## SYNTAX

```
Set-DsPowerPlan [-PlanName] <String> [[-FileName] <String>] [<CommonParameters>]
```

## DESCRIPTION
Set Active Power Plan from a list of standard names

## EXAMPLES

### EXAMPLE 1
```
Set-DsPowerPlan -PlanName "Performance"
```

### EXAMPLE 2
```
Set-DsPowerPlan -PlanName "Custom" -FileName "c:\customplan.pow"
```

## PARAMETERS

### -PlanName
Name of power plan to set active. 
 
Balanced, Performance, HighPerformance, PowerSaver, EnergyStar, Custom

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -FileName
PowerPlan file to import and set Active, when PlanName is set to Custom

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Set-DsPowerPlan.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Set-DsPowerPlan.md)

