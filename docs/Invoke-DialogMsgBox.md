---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-DialogMsgBox.md
schema: 2.0.0
---

# Invoke-DialogMsgBox

## SYNOPSIS
Display Windows message box

## SYNTAX

```
Invoke-DialogMsgBox [-Message] <String> [-Title] <String> [[-ButtonType] <String>] [[-Icon] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Display a Windows message box

## EXAMPLES

### EXAMPLE 1
```
$choice = Invoke-DialogMsgBox -Message "Proceed?" -Title "Update Records" -ButtonType YesNo -Icon Question
```

## PARAMETERS

### -Message
Text to display in the message box

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

### -Title
Message box caption / title

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ButtonType
Ok, OkCancel, YesNo, YesNoCancel.
Default is Ok

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: Ok
Accept pipeline input: False
Accept wildcard characters: False
```

### -Icon
Error, Exclamation, Information, Question, Warning, None.
Default is Information

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-DialogMsgBox.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-DialogMsgBox.md)

