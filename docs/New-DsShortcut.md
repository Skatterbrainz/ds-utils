---
external help file: ds-utils-help.xml
Module Name: ds-utils
online version: https://github.com/Skatterbrainz/ds-utils/blob/master/docs/New-DsShortcut.md
schema: 2.0.0
---

# New-DsShortcut

## SYNOPSIS
New-DsShortcut

## SYNTAX

```
New-DsShortcut [-Name] <String> [-TargetFile] <String> [[-WorkingDirectory] <String>] [[-Arguments] <String>]
 [[-Path] <String>] [[-WindowStyle] <String>] [[-IconLocation] <String>] [[-Description] <String>] [-Replace]
 [<CommonParameters>]
```

## DESCRIPTION
Create a new shortcut (.lnk file)

## EXAMPLES

### EXAMPLE 1
```
New-DsShortcut -Name "Notepad" -TargetFile "c:\windows\system32\notepad.exe"
```

## PARAMETERS

### -Name
Name of the shortcut file (base name)

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

### -TargetFile
Path to target of the shortcut

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

### -WorkingDirectory
Working directory path when launching the TargetFile

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

### -Arguments
Arguments to pass to the TargetFile when launched

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

### -Path
Path to save shortcut .lnk file
Known folders allowed: 'Desktop','Documents','StartMenu','Favorites','AllUserDesktop','AllUsersStartMenu'
Default = 'Desktop'

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: Desktop
Accept pipeline input: False
Accept wildcard characters: False
```

### -WindowStyle
Window style for opening target (Normal, Minimized or Maximized) Default = Normal

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: Normal
Accept pipeline input: False
Accept wildcard characters: False
```

### -IconLocation
Path to icon file, or path and index of embedded icon

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Description
Description for shortcut

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Replace
If shortcut file exists, replace it

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

[https://github.com/Skatterbrainz/ds-utils/blob/master/docs/New-DsShortcut.md](https://github.com/Skatterbrainz/ds-utils/blob/master/docs/New-DsShortcut.md)

