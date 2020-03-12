# TheFudgePS

This is a PowerShell module (and supporting key handler for PSReadline) that attempts to automatically correct the last thing you typed.

Inspired by a [Python script of another name](https://github.com/nvbn/thefuck/blob/master/thefuck/rules/git_checkout.py).

## Installation

This module may or may not ever be on the PowerShell gallery. You can always install it from the source here, though:

1. Download the repository
2. Copy the `src` directory to `$env:USERPROFILE\Documents\PowerShell\Modules`
3. Rename the copied `src` directory to `TheFudgePS`
4. Import the module: `Import-Module TheFudgePS`

## Registering the Key Handler

TheFudgePS includes a helper function to automatically register its primary function, `Invoke-Fudge`, as a PSReadline key handler (by default, Ctrl+f). Simply run `Register-FudgeKeyHandler` to register the key for the current session.

You can also pass a custom keyboard chord to the function if you'd like to bind it to a different key: `Register-FudgeKeyHandler -Key 'Ctrl+Shift+f'`

You can add this to your PowerShell profile if you'd like it to be available in every session.
