function Set-ModulePrivateData {
    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions", "")]
    param(
        [Parameter(
            Mandatory,
            Position = 0
        )]
        [Hashtable] $PrivateData
    )

    process {
        $MyInvocation.MyCommand.Module.PrivateData = $PrivateData
    }
}