function Register-FudgeKeyHandler {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string] $Key = 'Ctrl+f'
    )

    Set-PSReadLineKeyHandler -Key $Key `
        -BriefDescription TheFudge `
        -LongDescription 'Invoke-TheFudge' `
        -ScriptBlock {

        param($key, $arg)

        [string] $line = $null
        [int] $cursor = $null
        [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

        $fudge = Invoke-Fudge

        if ($fudge) {
            if ($line) {
                [Microsoft.PowerShell.PSConsoleReadLine]::AddToHistory($line)
                [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
            }

            [Microsoft.PowerShell.PSConsoleReadLine]::Insert("<# fudge #> " + $fudge)
        }
        else {
            $str = '<# fudge: no match found #> '
            [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition(0)
            [Microsoft.PowerShell.PSConsoleReadLine]::Insert($str)
            [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + $str.Length)
        }
    }
}