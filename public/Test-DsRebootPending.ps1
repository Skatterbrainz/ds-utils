
function Test-DsRebootPending {
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
    [CmdletBinding()]
	[OutputType()]
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
    $result = $false
    foreach ($test in $pendingRebootTests) {
        $result = Invoke-Command -ScriptBlock $test.Test
        if ($test.TestType -eq 'ValueExists' -and $result) {
            Write-DsLog -Message "test: $($test.Name) = TRUE"
            $result = $true
        }
        elseif ($test.TestType -eq 'NonNullValue' -and $result -and $result.($test.Name)) {
            Write-DsLog -Message "test: $($test.Name) = TRUE"
            $result = $true
        }
        else {
            Write-DsLog -Message "test: $($test.Name) = FALSE"
            #$false
        }
    }
    $result
}