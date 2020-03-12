function Get-Rules {
    param(
        [Parameter(Position = 0)]
        [String] $Path
        ,

        [Parameter()]
        [Switch] $Force
    )

    $p = Get-ModulePrivateData
    if (-not $Force) {
        return $p.Rules
    }

    Get-ChildItem $Path -Filter "*.rules.ps1" |
        ForEach-Object {
            . $_.FullName | ForEach-Object { $p.Rules.Add($_) }
        }

    Set-ModulePrivateData $p

    return $p.Rules
}