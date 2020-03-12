function Invoke-Fudge {
    [CmdletBinding()]
    param()

    end {
        $lastExit = $LASTEXITCODE
        $lastHistory = Get-History -Count 1
        $command = $lastHistory.CommandLine
        $rules = Get-Rules

        # $matchingRule = $rules |
        #     ForEach-Object {
        #         if ($_.PSObject.Properties.Name -contains 'commandLineRules') {
        #             $_.commandLineRules | Where-Object { $command -match $_.commandLine }
        #         }
        #     } |
        #     Select-Object -First 1

        $result = $null
        foreach ($r in $rules) {
            $result = & $r $command $lastExit
            if ($result) {
                break
            }
        }

        if (-not $result) {
            Write-Verbose "Could not find a rule matching the command [$command]"
        }
        else {
            $replaceText = $result
            Write-Debug "Fould matching rule`n`tCommand line:`t$command`n`tReplacement:`t$replaceText"
            Write-Output $replaceText
        }
    }
}

New-Alias -Name 'fudge' -Value 'Invoke-Fudge'
