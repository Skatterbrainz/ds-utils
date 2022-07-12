---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DsBrowserProfile.md
schema: 2.0.0
---

# Get-DsBrowserProfile

## SYNOPSIS
Query Browser Profiles

## SYNTAX

```
Get-DsBrowserProfile [[-Browser] <String>] [-AllUsers] [<CommonParameters>]
```

## DESCRIPTION
Query Browser profiles, returning ID, Name and UserName.
For current user or all users

## EXAMPLES

### EXAMPLE 1
```
Get-DsBrowserProfile
```

### EXAMPLE 2
```
Get-DsBrowserProfile -Browser Edge
```

### EXAMPLE 3
```
Get-DsBrowserProfile -Browser Chrome -AllUsers
```

## PARAMETERS

### -Browser
Optional.
Browser app to target for query (if installed)
* Default = Get default browser from registry query
* Chrome
* Edge
* Brave
* Firefox

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: Default
Accept pipeline input: False
Accept wildcard characters: False
```

### -AllUsers
Query all users on the computer

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

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DsBrowserProfile.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DsBrowserProfile.md)

