---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Install-DsPackages.md
schema: 2.0.0
---

# Install-DsPackages

## SYNOPSIS
Install Chocolatey and List of Packages

## SYNTAX

```
Install-DsPackages [[-Packages] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Install Chocolatey and List of Packages

## EXAMPLES

### EXAMPLE 1
```
Install-DsPackages
Installs the default list of packages
```

### EXAMPLE 2
```
Install-DsPackages -Packages ('visualstudiocode','git','github-desktop')
```

## PARAMETERS

### -Packages
Name(s) of Chocolatey packages
Default = ('dotnet3.5','7zip','notepadplusplus','adobereader','googlechrome')

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: ('dotnet3.5','7zip','notepadplusplus','adobereader','googlechrome')
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Install-DsPackages.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Install-DsPackages.md)

