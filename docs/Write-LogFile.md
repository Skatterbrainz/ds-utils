---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://4sysops.com/archives/use-powershell-to-test-if-a-windows-server-is-pending-a-reboot/
schema: 2.0.0
---

# Write-LogFile

## SYNOPSIS
Write to a custom log file

## SYNTAX

```
Write-LogFile [-Message] <String> [[-LogFile] <String>] [[-Category] <String>] [<CommonParameters>]
```

## DESCRIPTION
Write to a custom log file

## EXAMPLES

### EXAMPLE 1
```
Write-LogFile "this is a log entry"
```

### EXAMPLE 2
```
Write-LogFile -Category Warning -Message "this is a warning message"
```

## PARAMETERS

### -Message
Text for log detail entry

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

### -LogFile
Path and name of log file
Default is c:\windows\temp\ds-utils-YYYYMMDDhhmm.log

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: $(Join-Path $env:TEMP "ds-utils-$(Get-Date -f 'yyyyMMdd').log")
Accept pipeline input: False
Accept wildcard characters: False
```

### -Category
Info, Warning, or Error (Default: Info)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: Info
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Internal function

## RELATED LINKS
