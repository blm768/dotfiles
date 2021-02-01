Install-Module -Scope CurrentUser PSFzf

$profile_loc = $PROFILE."CurrentUserAllHosts"
Copy-Item profile.ps1 $profile_loc

# Windows Terminal

$config_dir = "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
$configs = , 'windows-terminal.json'
$local_file = "$config_dir\local.json"
if (Test-Path $local_file) {
    $configs += $local_file
}
$jq_query = @'
def merge($b):
    def merge_obj($b):
        $b + with_entries(
            .key as $key | .value |= if $key | in($b) then merge($b[$key]) else . end
        );
    if type == \"object\" and ($b | type) == \"object\" then
        merge_obj($b)
    elif type == \"array\" and ($b | type) == \"array\" then
        . + $b
    else
        $b
    end;

reduce .[] as $i ({}; merge($i))
'@.replace("`r`n", "`n")
$config = jq --slurp $jq_query $configs

# Need to do this to get UTF-8 w/o BOM when using PowerShell 5.x
[IO.File]::WriteAllLines("$config_dir\settings.json", $config)
