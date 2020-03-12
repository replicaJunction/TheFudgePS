function Get-ModulePrivateData {
    [CmdletBinding()]
    param()

    [hashtable] $p = $MyInvocation.MyCommand.Module.PrivateData
    [bool] $isDirty = $false

    # Create default entries if they don't exist

    if (-not $p.ContainsKey('Rules')) {
        $p['Rules'] = New-Object -TypeName 'System.Collections.Generic.List[System.Management.Automation.ScriptBlock]'
        $isDirty = $true
    }

    if ($isDirty) {
        $MyInvocation.MyCommand.Module.PrivateData = $p
    }

    Write-Output $p
}