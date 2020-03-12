Set-StrictMode -Version Latest

$allFiles = @( Get-ChildItem -Path "$PSScriptRoot\*\*.ps1" -ErrorAction SilentlyContinue)
# Dot source the files
foreach ($import in $allFiles) {
    try {
        . $import.fullname
    }
    catch {
        Write-Error "Failed to import file $($import.fullname): $_"
    }
}

# Export the public functions
$PublicFunctions = @( Get-ChildItem -Path "$PSScriptRoot\Public\*.ps1" -ErrorAction SilentlyContinue )
Export-ModuleMember -Function ($PublicFunctions | Select-Object -ExpandProperty Basename)

# Export aliases
Export-ModuleMember -Alias 'fudge'

Get-Rules -Path "$PSScriptRoot\Rules" -Force
