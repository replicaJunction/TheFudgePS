function Get-Rules {
    param(
        [Parameter()]
        [Switch] $Force
    )

    if (-not $Force -and (Get-Variable -Name 'rules' -Scope 'script' -ValueOnly -ErrorAction SilentlyContinue)) {
        return $script:rules
    }

    # $script:rules = Get-ChildItem $script:rulesPath -Filter "*.rules.json" |
    #     ForEach-Object -Parallel {
    #         Get-Content $_ | ConvertFrom-Json
    #     }
    $script:rules = New-Object -TypeName 'System.Collections.Generic.List[System.Management.Automation.ScriptBlock]'
    Get-ChildItem $script:rulesPath -Filter "*.rules.ps1" |
        ForEach-Object {
            . $_.FullName | ForEach-Object { $script:rules.Add($_) }
        }

    return $script:rules
}