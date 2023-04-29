---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-AiSpeakIt.md
schema: 2.0.0
---

# Get-AiSpeakIt

## SYNOPSIS
Speak a verbal response from ChatGPT using Windows Speech API

## SYNTAX

```
Get-AiSpeakIt [-Prompt] <String> [[-Coda] <String>] [-RepeatQuestion] [<CommonParameters>]
```

## DESCRIPTION
Do I need to clarify that?

## EXAMPLES

### EXAMPLE 1
```
Get-AiSpeakIt -Prompt "What is the fourth planet from our sun?"
```

## PARAMETERS

### -Prompt
The question or statement you wish to send to OpenAI.

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

### -Coda
The suffix to be appended to the response.
The default is usually enough.
:)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: Dumbass.
Accept pipeline input: False
Accept wildcard characters: False
```

### -RepeatQuestion
{{ Fill RepeatQuestion Description }}

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

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-AiSpeakIt.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-AiSpeakIt.md)

