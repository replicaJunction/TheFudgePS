function Get-ModulePrivateData {
    [CmdletBinding()]
    param()

    $defaultPrivateData = @{}

    $p = $MyInvocation.MyCommand.Module.PrivateData

    if (-not $p) {
        # If no PrivateData exists, set it to a default value. This way, the user
        # can reference it without a NullReferenceException
        $p = $defaultPrivateData
        $MyInvocation.MyCommand.Module.PrivateData = $p
    }

    Write-Output $p
}