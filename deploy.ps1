Install-Module -Scope CurrentUser PSFzf

$profile_loc = $PROFILE."CurrentUserAllHosts"
Copy-Item profile.ps1 $profile_loc

# Windows Terminal

function Merge-Objects {
    param ($left, $right)

    if ($left -eq $null) {
        return $right;
    }

    $type = $left.GetType();
    if ($right -ne $null -and $right.GetType() -eq $type) {
        if ($type -eq [System.Management.Automation.PSCustomObject]) {
            $out = [PSCustomObject]@{}
            foreach ($prop in $left | Get-Member -MemberType Properties) {
                $out | Add-Member -MemberType NoteProperty -Name $prop.Name -Value $left.($prop.Name)
            }
            Write-Debug $out
            foreach ($prop in $right | Get-Member -MemberType Properties) {
                if ($left | Get-Member $prop.Name -MemberType Properties) {
                    $val = Merge-Objects $left.($prop.Name) $right.($prop.Name)
                } else {
                    $val = $right.($prop.Name)
                }
                $out | Add-Member -MemberType NoteProperty -Name $prop.Name -Value $val -Force
            }
            return $out
        } elseif ($type -eq [System.Object[]]) {
            return $left + $right
        }
    }

    return $right;
}

$config_dir = "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
$config = Get-Content windows-terminal.json -Raw | ConvertFrom-Json
$local_file = "$config_dir\local.json"
if (Test-Path $local_file) {
    $local_config = Get-Content $local_file -Raw | ConvertFrom-Json
    $config = Merge-Objects $config $local_config
}
$config = ConvertTo-Json -InputObject $config -Depth 100

# Need to do this to get UTF-8 w/o BOM when using PowerShell 5.x
[IO.File]::WriteAllLines("$config_dir\settings.json", $config)
