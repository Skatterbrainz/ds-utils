---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-AiListen.md
schema: 2.0.0
---

# Invoke-AiListen

## SYNOPSIS

## SYNTAX

```
Invoke-AiListen [[-Language] <String>] [[-SafeWord] <String>] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
Invoke-AiListen
Waits for you to finish speaking a statement or question until you say 'stop'.
Then it submits your statement to OpenAI using the Get-AiSpeakIt function.
```

## PARAMETERS

### -Language
Default is 'en-US'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: En-US
Accept pipeline input: False
Accept wildcard characters: False
```

### -SafeWord
Word to listen for to trigger the listening to stop.
The default word is 'stop'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Stop
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-AiListen.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-AiListen.md)

