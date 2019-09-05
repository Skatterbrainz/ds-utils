#requires -RunAsAdministrator

<#
.SYNOPSIS
    Return true if a reboot is pending (local machine)
.EXAMPLE
    if (Test-RebootPending) { ... }
.NOTES
    Thanks to https://4sysops.com/archives/use-powershell-to-test-if-a-windows-server-is-pending-a-reboot/
.OUTPUTS
    True or False
#>
function Test-RebootPending {
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
.DESCRIPTION
.PARAMETER LogFile
.PARAMETER Category
.PARAMETER Message
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
.DESCRIPTION
.PARAMETER Update
.EXAMPLE
.NOTES
.OUTPUTS
#>
function Invoke-DsMaintenance {
    [CmdletBinding()]
    param (
        [parameter()] [ValidateSet('All','Modules','Windows','Packages')] [string] $Update = 'All',
        [parameter()] [switch] $ForceReboot
    )
    try {
        switch ($Update) {
            'All' {
                Write-DsLog -Message "updating powershell modules"
                Update-Module
                Write-DsLog -Message "powershell modules have been updated"
                if (Test-Path (Join-Path $env:ProgramData "chocolatey\choco.exe")) {
                    Write-DsLog -Message "updating chocolatey packages"
                    cup all -y
                    Write-DsLog -Message "chocolatey packages have been updated"
                }
                else {
                    Write-DsLog -Message  "chocolatey is not installed (skipping updates)" -Category 'Warning'
                    Write-Warning "chocolatey is not installed (skipping package updates)"
                }
                Write-DsLog "updating windows and office products"
                $res = Get-WindowsUpdate -AcceptAll -Install -WindowsUpdate -IgnoreReboot
                Write-DsLog "$($res.Count) windows updates were applied"
            }
        }
        if (Test-RebootPending) {
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