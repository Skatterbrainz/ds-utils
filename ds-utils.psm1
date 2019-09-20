#requires -RunAsAdministrator

<#
.SYNOPSIS
    Return true if a reboot is pending (local machine)
.EXAMPLE
    if (Test-DsRebootPending) { ... }
.NOTES
    Internal function
    Thanks to https://4sysops.com/archives/use-powershell-to-test-if-a-windows-server-is-pending-a-reboot/
.OUTPUTS
    True or False
.LINK
    https://4sysops.com/archives/use-powershell-to-test-if-a-windows-server-is-pending-a-reboot/
#>
function Test-DsRebootPending {
    [CmdletBinding()]
    param ()
    $pendingRebootTests = @(
        @{
            Name = 'RebootPending'
            Test = { Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing' -Name 'RebootPending' -ErrorAction Ignore }
            TestType = 'ValueExists'
        }
        @{
            Name = 'RebootRequired'
            Test = { Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update' -Name 'RebootRequired' -ErrorAction Ignore }
            TestType = 'ValueExists'
        }
        @{
            Name = 'PendingFileRenameOperations'
            Test = { Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager' -Name 'PendingFileRenameOperations' -ErrorAction Ignore }
            TestType = 'NonNullValue'
        }
    )
    foreach ($test in $pendingRebootTests) {
        $result = Invoke-Command -ScriptBlock $test.Test
        if ($test.TestType -eq 'ValueExists' -and $result) {
            $true
        }
        elseif ($test.TestType -eq 'NonNullValue' -and $result -and $result.($test.Name)) {
            $true
        }
        else {
            $false
        }
    }
}

<#
.SYNOPSIS
    Write to a custom log file
.DESCRIPTION
    Write to a custom log file
.PARAMETER LogFile
    Path and name of log file
    Default is c:\windows\temp\ds-utils-YYYYMMDDhhmm.log
.PARAMETER Category
    Info, Warning, or Error (Default: Info)
.PARAMETER Message
    Text for log detail entry
.EXAMPLE
    Write-DsLog "this is a log entry"
.EXAMPLE
    Write-DsLog -Category Warning -Message "this is a warning message"
.NOTES
    Internal function
#>
function Write-DsLog {
    [CmdletBinding()]
    param (
        [parameter()][ValidateNotNullOrEmpty()] [string] $LogFile = $(Join-Path $env:SystemRoot "temp\ds-utils-$(Get-Date -f 'yyyyMMddhhmm').log"),
        [parameter()][ValidateSet('Info','Error','Warning')] [string] $Category = 'Info',
        [parameter(Mandatory)] [ValidateNotNullOrEmpty()] [string] $Message
    )
    try {
        $strdata = "$(Get-Date -f 'yyyy-MM-dd hh:mm:ss') - $Category - $Message"
        $strdata | Out-File -FilePath $LogFile -Append
        switch ($Category) {
            'Warning' { Write-Warning $strdata }
            'Error' { Write-Warning $strdata }
            default { Write-Host $strdata -ForegroundColor Cyan }
        }
    }
    catch {
        Write-Error "Write-DsLog (error): $($Error[0].Exception.Message)"
    }
}

<#
.SYNOPSIS
    Run Maintenance Tasks
.DESCRIPTION
    Run Ds-Utils Maintenance Tasks
.PARAMETER Update
    All, Modules, Windows, Packages...
    * Modules = PowerShell modules
    * Windows = Windows Updates
    * Packages = Chocolatey Packages
    Default = ALL
.PARAMETER ForceReboot
    Initiates a restart upon completion
.EXAMPLE
    Invoke-DsMaintenance -Update Modules
    Updates PowerShell modules only
.EXAMPLE
    Invoke-DsMaintenance -ForceReboot
    Runs all update tasks and forces a restart at the end
.NOTES
.LINK
    https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-DsMaintenance.md
#>
function Invoke-DsMaintenance {
    [CmdletBinding()]
    param (
        [parameter()] [ValidateSet('All','Modules','Windows','Packages')] [string] $Update = 'All',
        [parameter()] [switch] $ForceReboot
    )
    try {
        if ($Update -in ('All','Modules')) {
            Write-DsLog -Message "updating powershell modules"
            Update-Module
            Write-DsLog -Message "powershell modules have been updated"
        }
        if ($Update -in ('All','Packages')) {
            if (Test-Path (Join-Path $env:ProgramData "chocolatey\choco.exe")) {
                Write-DsLog -Message "updating chocolatey packages"
                cup all -y
                Write-DsLog -Message "chocolatey packages have been updated"
            }
            else {
                Write-DsLog -Message  "chocolatey is not installed (skipping updates)" -Category 'Warning'
                Write-Warning "chocolatey is not installed (skipping package updates)"
            }
        }
        if ($Update -in ('All','Windows')) {
            Write-DsLog "updating windows and office products"
            $res = Get-WindowsUpdate -AcceptAll -Install -WindowsUpdate -IgnoreReboot
            Write-DsLog "$($res.Count) windows updates were applied"
        }
        if (Test-DsRebootPending) {
            Write-DsLog "tasks completed (reboot required)"
            if ($ForceReboot) {
                Write-Output 1641
                Write-DsLog "rebooting computer in 15 seconds"
                Restart-Computer -Timeout 15
            }
        }
        else {
            Write-DsLog "tasks completed"
            Write-Output 0
        }
    }
    catch {
        Write-DsLog -Category 'Error' -Message "$($Error[0].Exception.Message)"
        Write-Output -1
    }
}

<#
.SYNOPSIS
    Rename computer using common standard format
.DESCRIPTION
    I hate repeating myself
.PARAMETER MaxNameLength
    Maximum length of new name (default is 15, which is the limit for Windows)
.PARAMETER FormCode
    Form-factor code placement: Prefix (default), Suffix, or None
.PARAMETER NoHyphen
    Do not insert a hyphen separator between FormCode and SerialNumber
.PARAMETER Reboot
    Force a reboot at the end (default = no reboot)
.EXAMPLE
    Set-DsComputerName
    (Defaults) results in name like "L-123456789"
.EXAMPLE
    Set-DsComputerName -FormCode Suffix -NoHyphen
    Results in name like "123456789L"
.EXAMPLE
    Set-DsComputerName -FormCode None -MaxNameLength 8
    Results in name like "12345678"
.NOTES
    Actual Serial Number is used from WMI class Win32_SystemEnclosure
    Chassis Type number is taken from Win32_SystemEnclosure and uses first
        element of result only, since docking stations, port replicators
        may return an array like (10,12) where 10 is the laptop, and 12 is the dock
.LINK
    https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Set-DsComputerName.md
#>
function Set-DsComputerName {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [parameter()][ValidateRange(3,15)][int] $MaxNameLength = 15,
        [parameter()][ValidateSet('Prefix','Suffix','None')][string] $FormCode = 'Prefix',
        [parameter()][switch] $NoHyphen,
        [parameter()][switch] $Reboot
    )
    # rename computer to "X-12345678"
    [string]$sn = (Get-WmiObject -Class Win32_SystemEnclosure).SerialNumber
    [int]$ct = ((Get-WmiObject -Class Win32_SystemEnclosure).ChassisTypes)[0]
    Write-Verbose "serialnumber = $sn"
    Write-Verbose "chassistype = $ct"
    # desktops
    if ($ct -in (3..7)+(13,34,35)) { $ff = 'D' }
    # laptops
    elseif ($ct -in (10,11,12,14)+(15..30)+(31,32,33,36)) { $ff = 'L' }
    # servers
    elseif ($ct -in (17..24)) { $ff = 'S' }
    # unknown
    else { $ff = 'X' }
    if ($NoHyphen) { $sep = "" } else { $sep = "-" }
    if ($FormCode -eq 'None') { $fc = ""; $sep = "" } else { $fc = $ff }
    $nx = "$fc$sep$sn"
    if ($nx.Length -gt $MaxNameLength) {
        $over = $nx.Length - $MaxNameLength
        $sn = $sn.substring($over, $sn.Length - $over)
        $nx = "$fc$sep$sn"
    }
    Write-Host "renaming computer to $nx" -ForegroundColor cyan
    if ($Reboot) {
        Rename-Computer -NewName $nx -Force -Restart
    }
    else {
        Rename-Computer -NewName $nx -Force
    }
}

<#
.SYNOPSIS
    Install Chocolatey and List of Packages
.DESCRIPTION
    Install Chocolatey and List of Packages
.PARAMETER Packages
    Name(s) of Chocolatey packages
    Default = ('dotnet3.5','7zip','notepadplusplus','adobereader','googlechrome')
.EXAMPLE
    Install-DsPackages
    Installs the default list of packages
.EXAMPLE
    Install-DsPackages -Packages ('visualstudiocode','git','github-desktop')
.LINK
    https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Install-DsPackages.md
#>

function Install-DsPackages {
    [CmdletBinding()]
    param (
        [parameter()]
        [ValidateNotNullOrEmpty()]
        [string[]] $Packages = ('dotnet3.5','7zip','notepadplusplus','adobereader','googlechrome')
    )
    try {
        if (!(Test-Path (Join-Path $env:ProgramData "Chocolatey\choco.exe"))) {
            Write-Host "installing chocolatey" -ForegroundColor cyan
            Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
            Write-Verbose "chocolatey has landed!"
        }
        cup $Packages -y
        Write-Output 0
    }
    catch {
        Write-Error $Error[0].Exception.Message
        Write-Output -1
    }
}

<#
.SYNOPSIS
    Returns the active Power Plan Name
.DESCRIPTION
    Returns the active Power Plan Name
.EXAMPLE
    Get-DsPowerPlan
.LINK
    https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DsPowerPlan.md
#>

function Get-DsPowerPlan {
    param()
    $pplist = POWERCFG -LIST | Where-Object {$_ -like "Power Scheme*"}
    foreach ($pp in $pplist) {
        $pdata = (($pp.Split(":")).Trim())[1]
        $pguid = $pdata.Split(" ")[0]
        $pname = ($pdata.Split("(")[1]).Replace(")","")
        if ($pname.EndsWith("`*")) {
            $pname = $pname.Replace(" `*","")
            $data = @{
                Name = $pname
                GUID = $pguid
                IsActive = $True
            }
        }
        else {
            $data = @{
                Name = $pname
                GUID = $pguid
                IsActive = $False
            }
        }
        $xdata = New-Object -TypeName PSObject -Property $data
        Write-Output $xdata
    }
}

<#
.SYNOPSIS
    Set Active Power Plan
.DESCRIPTION
    Set Active Power Plan from a list of standard names
.PARAMETER PlanName
    Name of power plan to set active.    
    Balanced, Performance, HighPerformance, PowerSaver, EnergyStar, Custom
.PARAMETER FileName
    PowerPlan file to import and set Active, when PlanName is set to Custom
.EXAMPLE
    Set-DsPowerPlan -PlanName "Performance"
.EXAMPLE
    Set-DsPowerPlan -PlanName "Custom" -FileName "c:\customplan.pow"
.LINK
    https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Set-DsPowerPlan.md
#>

function Set-DsPowerPlan {
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$True, HelpMessage="Power scheme name")]
            [ValidateSet('Balanced','HighPerformance','Performance','PowerSaver','EnergyStar','Custom')]
            [string] $PlanName,
        [parameter(Mandatory=$False, HelpMessage="Custom power plan filename")]
            [ValidateNotNullOrEmpty()]
            [string] $FileName = ""
    )
    #Power Scheme GUID: 1ca6081e-7f76-46f8-b8e5-92a6bd9800cd (Maximum Battery
    #Power Scheme GUID: 2ae0e187-676e-4db0-a121-3b7ddeb3c420 (Power Source Opt
    #Power Scheme GUID: 37aa8291-02f6-4f6c-a377-6047bba97761 (Timers off (Pres
    #Power Scheme GUID: a666c91e-9613-4d84-a48e-2e4b7a016431 (Maximum Performa
    #Power Scheme GUID: e11a5899-9d8e-4ded-8740-628976fc3e63 (Video Playback)
    #9586a712-fcb4-4a06-af4b-52803dfbb9db = Performance
    try {
        $result = 0
        if ($PlanName -eq 'Custom') {
            if (Test-Path -Path $FileName) {
                POWERCFG -IMPORT $FileName
            }
            else {
                Write-Warning "Power Config file not found: $FileName"
                $result = -1
            }
        }
        else {
            switch ($PlanName) {
                'HighPerformance' {
                    $ppguid = '8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c'
                }
                'Performance' {
                    $ppguid = '9586a712-fcb4-4a06-af4b-52803dfbb9db'
                }
                'Balanced' {
                    $ppguid = '381b4222-f694-41f0-9685-ff5bb260df2e'
                }
                'PowerSaver' {
                    $ppguid = 'a1841308-3541-4fab-bc81-f71556f20b4a'
                }
                'EnergyStar' {
                    $ppguid = 'de7ef2ae-119c-458b-a5a3-997c2221e76e'
                }
            }
            $currentScheme = POWERCFG -GETACTIVESCHEME
            $currentScheme = $currentScheme.Split()
            if ($currentScheme[3] -ne $ppguid) {
                Write-Host "Current plan is $($currentScheme[5])"
                POWERCFG -SETACTIVE $ppguid
                $newScheme = POWERCFG -GETACTIVESCHEME
                $newScheme = $($newScheme.Split('(')[1]).Replace(')','')
                Write-Host "Active plan is now $newScheme"
            }
            else {
                Write-Host "Current plan is already $PlanName"
            }
        }
        Write-Output $result
    }
    catch {
        Write-Error $Error[0].Exception.Message 
    }
}

<#
.SYNOPSIS
    Disable AD machine account password sync
.DESCRIPTION
    Disable AD machine account password sync. Most often used with
    virtual machines which are repeatedly reverted to snapshots/checkpoints
    for development and testing purposes.
.EXAMPLE
    Disable-DsMachinePasswordSync
.LINK
    https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Disable-DsMachinePasswordSync.md
#>

function Disable-DsMachinePasswordSync {
    [CmdletBinding()]
    param()
    try {
        New-Item -Path HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters -Name DisablePasswordChange -Value 1 -ItemType DWORD
    }
    catch {
        Write-Error $Error[0].Exception.Message
    }
}

<#
.SYNOPSIS
    Pin Shortcut to Taskbar
.DESCRIPTION
    Pin Shortcut to Taskbar
.PARAMETER Target
    Path and name of item to target shortcut
.EXAMPLE
    Add-DsTaskbarShortcut -Target "c:\windows\notepad.exe"
.LINK
    https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Add-DsTaskbarShortcut.md
#>

function Add-DsTaskbarShortcut {
    [CmdletBinding()]
    param (
        [parameter(Mandatory=$True, HelpMessage="Target item to pin")]
        [ValidateNotNullOrEmpty()]
        [string] $Target
    )
    if (!(Test-Path $Target)) {
        Write-Warning "You freaking dumbass!!! $Target does not exist"
        break
    }
    try {
        $KeyPath1  = "HKCU:\SOFTWARE\Classes"
        $KeyPath2  = "*"
        $KeyPath3  = "shell"
        $KeyPath4  = "{:}"
        $ValueName = "ExplorerCommandHandler"
        $ValueData =
            (Get-ItemProperty `
                ("HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\" + `
                    "CommandStore\shell\Windows.taskbarpin")
            ).ExplorerCommandHandler
    
        $Key2 = (Get-Item $KeyPath1).OpenSubKey($KeyPath2, $true)
        $Key3 = $Key2.CreateSubKey($KeyPath3, $true)
        $Key4 = $Key3.CreateSubKey($KeyPath4, $true)
        $Key4.SetValue($ValueName, $ValueData)
    
        $Shell = New-Object -ComObject "Shell.Application"
        $Folder = $Shell.Namespace((Get-Item $Target).DirectoryName)
        $Item = $Folder.ParseName((Get-Item $Target).Name)
        $Item.InvokeVerb("{:}")
    
        $Key3.DeleteSubKey($KeyPath4)
        if ($Key3.SubKeyCount -eq 0 -and $Key3.ValueCount -eq 0) {
            $Key2.DeleteSubKey($KeyPath3)
        }
    }
    catch {
        Write-Error $Error[0].Exception.Message
    }
}

<#
.SYNOPSIS
    Removes AppxPackages for current user only
.DESCRIPTION
    Removes AppxPackages for current user only
.PARAMETER PackageNames
    Array of Appx Package names
.EXAMPLE
    Remove-DsAppxPackages -Packages ('xbox','zune')
.LINK
    https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Remove-DsAppxPackages.md
#>
function Remove-DsAppxPackages {
    [CmdletBinding()]
    param (
        [parameter()]
        [ValidateNotNullOrEmpty()]
        [string[]] $PackageNames = ('xbox','skype','zune','officehub','solitaire')
    )
    Write-Host "removing windows store apps for current user" -ForegroundColor cyan
    # use: (Get-AppxPackage).Name to display package names
    foreach ($pkg in $PackageNames) {
        Get-AppxPackage | Where-Object {$_.Name -match $pkg} | Remove-AppxPackage -ErrorAction SilentlyContinue
    }
}

<#
.SYNOPSIS
    Customize Start Menu and TaskBar
.DESCRIPTION
    (same)
.PARAMETER FeatureName
    Name of feature to configure or disable
.NOTES
    https://www.howto-connect.com/registry-hacks-for-start-menu-and-taskbar-in-windows-10/
.LINK
    https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Set-DsWin10StartMenu.md
#>

function Set-DsWin10StartMenu {
    [CmdletBinding()]
    param (
        [parameter(Mandatory)]
        [ValidateSet('RecentApps','ContextMenu','PeopleIcon')]
        [string] $FeatureName
    )
    switch ($FeatureName) {
        'RecentApps' {
            New-Item -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Name HideRecentlyAddedApps -Value 1 -ItemType DWORD
        }
        'ContextMenu' {
            New-Item -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer -Name DisableContextMenusInStart -Value 0 -ItemType DWORD
        }
        'PeopleIcon' {
            New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People -Name PeopleBand -Value 0 -ItemType DWORD
        }
    }
}

<#
.SYNOPSIS
    Returns local group members
.DESCRIPTION
    I hate repeating myself
.PARAMETER ComputerName
    Name of computer (if remote). Default = 'localhost'
.PARAMETER GroupName
    Name of local group. Default = 'Administrators'
.NOTES
    Adapted from https://gallery.technet.microsoft.com/scriptcenter/List-local-group-members-c25dbcc4
.LINK
    https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-DsLocalGroupMembers.md
#>
function Get-DsLocalGroupMembers {  
    param(  
        [parameter(ValueFromPipeline=$true,ValueFromPipelineByPropertyName=$true)] [Alias("Name")] [string]$ComputerName = 'localhost', 
        [string]$GroupName = "Administrators"  
    )  
    begin {}
    process {
        # If the account name of the computer object was passed in, it will 
        # end with a $. Get rid of it so it doesn't screw up the WMI query.
        $ComputerName = $ComputerName.Replace("`$", '')

        # Initialize an array to hold the results of our query.
        $arr = @()

        # Get hostname of remote system.  $computername could reference cluster/alias name.  Need real hostname for subsequent WMI query.
        $hostname = (Get-WmiObject -ComputerName $ComputerName -Class Win32_ComputerSystem).Name
        $wmi = Get-WmiObject -ComputerName $ComputerName -Query "SELECT * FROM Win32_GroupUser WHERE GroupComponent=`"Win32_Group.Domain='$Hostname',Name='$GroupName'`""

        # Parse out the username from each result and append it to the array.
        if ($null -ne $wmi) {
            foreach ($item in $wmi) {
                $data = $item.PartComponent -split "\,"
                $domain = ($data[0] -split "=")[1]
                $name = ($data[1] -split "=")[1]
                $arr += ("$domain\$name").Replace("""","")
                [Array]::Sort($arr)
            }
        }
        #$hash = @{ComputerName=$ComputerName;Members=$arr}
        #return $hash
        return $arr
    }
    end{}
}

<#
.SYNOPSIS
    Disable Windows 10 Telemetry Collection and Upload
.DESCRIPTION
    Disable Windows 10 Telemetry Collection and Upload
.LINK
    https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Disable-DsWindowsTelemetry.md
#>

function Disable-DsWindowsTelemetry {
    [CmdletBinding()]
    param()
    try {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' -Name 'AllowTelemetry' -ItemType DWORD -Value 0 -Force
    }
    catch {
        Write-Error $Error[0].Exception.Message
    }
}