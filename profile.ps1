# Aliases

Set-Alias -Name open -Value Start-Process
Set-Alias -Name which -Value Get-Command

# Readline

Set-PSReadlineOption -EditMode vi

# Completion

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
