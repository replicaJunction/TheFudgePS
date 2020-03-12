@(
    {
        param([string] $command, [int] $lastExit)

        if ($command -notmatch '^git stats') {
            return
        }

        return 'git status'
    }
)