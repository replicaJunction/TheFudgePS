[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [String[]] $TestName
    ,

    [Parameter()]
    [String] $ModulePath
    ,

    [Parameter()]
    [Switch] $VSCode
)

$ProjectRoot = Split-Path $PSScriptRoot -Parent
$ProjectName = Split-Path $ProjectRoot -Leaf

if ($ModulePath) {
    Write-Verbose "Testing provided module path $ModulePath"
}
else {
    $ModulePath = Join-Path -Path $ProjectRoot -ChildPath "src\$ProjectName.psd1"
}

# If the module is installed to PSModulePath and we try to import it ourselves, Pester can
# get really confused. Disabling this allows us to explicitly import the version of the
# module we want to test.
if (-not (Get-Variable 'PSModuleAutoLoadingPreference' -ValueOnly -Scope Global -ErrorAction SilentlyContinue)) {
    $oldModuleLoadingPreference = $null
}
else {
    $oldModuleLoadingPreference = $global:PSModuleAutoLoadingPreference
}
$global:PSModuleAutoLoadingPreference = 'None'

# Remove any existing versions of the module (in case they came from a different path)
Remove-Module $ProjectName -Force -ErrorAction SilentlyContinue

Write-Verbose "Importing module from path [[ $ModulePath ]]"
Import-Module $ModulePath -Force

$pesterSplat = @{
    Path = $PSScriptRoot
}

if ($TestName) {
    $pesterSplat['TestName'] = $TestName
}

if ($VSCode) {
    $pesterSplat['PesterOption'] = @{
        IncludeVSCodeMarker = $true
    }
}

Write-Verbose "Running Pester"
Invoke-Pester @pesterSplat

# Restore module autoloading to its previous state
$global:PSModuleAutoLoadingPreference = $oldModuleLoadingPreference
