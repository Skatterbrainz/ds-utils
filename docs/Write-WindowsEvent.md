---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://4sysops.com/archives/use-powershell-to-test-if-a-windows-server-is-pending-a-reboot/
schema: 2.0.0
---

# Write-WindowsEvent

## SYNOPSIS
Workaround for Write-EventLog where -Source often pisses me off

## SYNTAX

```
Write-WindowsEvent [[-LogName] <String>] [[-EventID] <Int32>] [[-Category] <Int32>] [[-Severity] <String>]
 [[-ComputerName] <String>] [-Source] <String> [-Message] <String> [<CommonParameters>]
```

## DESCRIPTION
I'm still pissed.
I mean,seriously, too busy?
More things to rename to Defender something something?

## EXAMPLES

### EXAMPLE 1
```
Write-WindowsEvent -EventID 101 -Source "SCORCH" -Message "Runbook FUBAR-TARFU state: Stopped" -Severity "Warning"
```

## PARAMETERS

### -LogName
For now: System or Application.
That's it.
I'm cheap.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Application
Accept pipeline input: False
Accept wildcard characters: False
```

### -EventID
You guessed it: The event ID number.
The default is 1.
The value must be within the
range of 1 to 16,384.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -Category
I really don't care about Category, but it's whatever you want (within allowances)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -Severity
For now: Information,Warning or Error.
The default is Information

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: Information
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName
{{ Fill ComputerName Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: $env:COMPUTERNAME
Accept pipeline input: False
Accept wildcard characters: False
```

### -Source
And now, for the main event: The event source name.
The docs (as of 3/27/2023) show examples that
clearly imply you can provide any custom name you desire.
They show "MyApp".
But if you try that
you'll get punched in the face with something annoying, like:

\`\`\`Write-EventLog : The source name "MyApp" does not exist on computer "localhost"\`\`\`

* So I inserted my bite guard and strapped on the head gear and took the face hit for you.
* Source: https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/write-eventlog?view=powershell-5.1

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message
Say something.
I don't care.
You can say 'Hello world!' if it makes you happy.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 7
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
