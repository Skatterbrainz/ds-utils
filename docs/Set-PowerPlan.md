---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Set-PowerPlan.md
schema: 2.0.0
---

# Set-PowerPlan

## SYNOPSIS
Set Active Power Plan

## SYNTAX

```
Set-PowerPlan [-Name] <String> [[-FileName] <String>] [<CommonParameters>]
```

## DESCRIPTION
Set Active Power Plan from a list of standard names

## EXAMPLES

### EXAMPLE 1
```
Set-PowerPlan -Name "Performance"
```

### EXAMPLE 2
```
Set-PowerPlan -Name "Custom" -FileName "c:\customplan.pow"
```

## PARAMETERS

### -Name
Power scheme name

```yaml
Type: String
Parameter Sets: (All)
Aliases: PlanName, Plan

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

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Set-PowerPlan.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Set-PowerPlan.md)

