# Module manifest for module 'ds-utils'
# Generated by: David Stein
# Generated on: 9/5/2019

@{
    RootModule = '.\ds-utils.psm1'
    ModuleVersion = '1.2.6'
    # CompatiblePSEditions = @()
    GUID = 'b6ecd834-9725-40e5-bb06-ece649b9e6b8'
    Author = 'David Stein'
    CompanyName = 'David Stein'
    Copyright = '(c) 2019 David Stein. All rights reserved.'
    Description = 'Miscellaneous utilities by a miscellaneous human'
    PowerShellVersion = '4.0'
    # PowerShellHostName = ''
    # PowerShellHostVersion = ''
    # DotNetFrameworkVersion = ''
    # CLRVersion = ''
    # ProcessorArchitecture = ''
    RequiredModules = @('pswindowsupdate')
    # RequiredAssemblies = @()
    # ScriptsToProcess = @()
    # TypesToProcess = @()
    # FormatsToProcess = @()
    # NestedModules = @()
    FunctionsToExport = @(
        'Add-DsTaskbarShortcut',
        'Disable-DsMachinePasswordSync',
        'Get-DsLocalGroupMembers',
        'Get-DsPowerPlan',
        'Install-DsPackages',
        'Invoke-DsMaintenance',
        'Remove-DsAppxPackages',
        'Set-DsComputerName',
        'Set-DsPowerPlan',
        'Set-DsWin10StartMenu',
        'Set-DsWindowsTelemetry',
        'Show-DsExplorerMenuBar',
        'Show-DsFileExtensions',
        'Convert-ErrorCode'
    )
    CmdletsToExport = '*'
    VariablesToExport = '*'
    AliasesToExport = '*'
    # DscResourcesToExport = @()
    # ModuleList = @()
    # FileList = @()
    PrivateData = @{
        PSData = @{
            Tags = @('dave','dsutils','ds-utils','skatterbrainz')
            LicenseUri = 'https://raw.githubusercontent.com/Skatterbrainz/ds-utils/master/LICENSE'
            ProjectUri = 'https://github.com/Skatterbrainz/ds-utils'
            # IconUri = ''
            ReleaseNotes = 'https://github.com/Skatterbrainz/ds-utils'
        } # End of PSData hashtable
    } # End of PrivateData hashtable
    # HelpInfoURI = ''
    # DefaultCommandPrefix = ''
    }