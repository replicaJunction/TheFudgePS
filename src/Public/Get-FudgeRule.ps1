function Get-FudgeRule {
    [CmdletBinding()]
    param(
        [Parameter()]
        [Switch] $Force
    )

    end {
        Get-Rules -Force:$Force | Write-Output
    }
}