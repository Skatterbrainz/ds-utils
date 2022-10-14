---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DsRegistryValue.md
schema: 2.0.0
---

# Get-DsRegistryValue

## SYNOPSIS
Get-DsRegistryValue

## SYNTAX

```
Get-DsRegistryValue [-KeyPath] <String> [-ValueName] <String> [[-ComputerName] <String>]
 [[-InputFile] <String>] [[-OutputFile] <String>] [-ADGridSelect] [<CommonParameters>]
```

## DESCRIPTION
Export remote registry values

## EXAMPLES

### EXAMPLE 1
```
$key = "HKLM:SYSTEM\CurrentControlSet\Control\SystemInformation"
$val = "BIOSVersion"
Get-DsRegistryValue -KeyPath $key -ValueName $val -ADGridSelect
```

### EXAMPLE 2
```
$key = "HKLM:SYSTEM\CurrentControlSet\Control\SystemInformation"
$val = "BIOSVersion"
Get-DsRegistryValue -KeyPath $key -ValueName $val -InputFile "c:\temp\computers.txt"
```

### EXAMPLE 3
```
$key = "HKLM:SYSTEM\CurrentControlSet\Control\SystemInformation"
$val = "BIOSVersion"
Get-DsRegistryValue -KeyPath $key -ValueName $val -ComputerName "DC01,DC02,DC03"
```

### EXAMPLE 4
```
$key = "HKLM:SOFTWARE\Policies\Microsoft\Windows NT\Printers\PointAndPrint"
$val = "NoWarningNoElevationOnInstall"
Get-DsRegistryValue -KeyPath $key -ValueName -InputFile "c:\temp\computers.txt"
```

## PARAMETERS

### -KeyPath
Required.
Registry path in PSProvider format (e.g.
HKLM:SOFTWARE, not HKEY_LOCAL_MACHINE\SOFTWARE)

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

### -ValueName
Required.
Name of Registry value

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

### -ComputerName
Optional.
Names of one or more computers (comma-delimited)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -InputFile
Optional.
Path\Name of file containing computer names to query

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutputFile
Optional.
Path\Name of CSV output file

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ADGridSelect
Optional.
Prompt user to select computers read in from AD using a gridview listmenu

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
1.0.0 - 2022-08-04 - David Stein / https://github.com/Skatterbrainz

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DsRegistryValue.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DsRegistryValue.md)

