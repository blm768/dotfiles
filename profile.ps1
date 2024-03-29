# Aliases

Set-Alias -Name g -Value git
Set-Alias -Name open -Value Start-Process
Set-Alias -Name which -Value Get-Command

# Readline

Set-PSReadlineOption -EditMode vi

# Completion

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key Ctrl+d -Function DeleteCharOrExit
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
