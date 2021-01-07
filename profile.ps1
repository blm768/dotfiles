# Aliases

Set-Alias -Name open -Value Start-Process
Set-Alias -Name which -Value Get-Command

# Completion

Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
