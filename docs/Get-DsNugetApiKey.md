---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DsNugetApiKey.md
schema: 2.0.0
---

# Get-DsNugetApiKey

## SYNOPSIS
Get-DsNugetApiKey

## SYNTAX

```
Get-DsNugetApiKey [<CommonParameters>]
```

## DESCRIPTION
Returns API key stored in registry, following use of Set-DsNugetApiKey
or having set the registry value by some other means

## EXAMPLES

### EXAMPLE 1
```
$apikey = Get-DsNugetApiKey
Publish-Module -Name "MyModule" -NuGetApiKey $apikey
```

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Use Set-DsNugetApiKey to define the registry value first

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DsNugetApiKey.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DsNugetApiKey.md)

