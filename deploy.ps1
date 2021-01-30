Install-Module -Scope CurrentUser PSFzf
Install-Script -Scope CurrentUser Join -NoPathUpdate

$profile_loc = $PROFILE."CurrentUserAllHosts"
#$profile_parent = Split-Path -Parent $profile_loc
#$module_paths = $env:PsModulePath -Split ';'
#$user_module_path = $module_paths `
#    | Where-Object { (Split-Path -Parent $_) -eq $profile_parent } `
#    | Select-Object -First 1
#Copy-Item (Join-Path $profile_parent -ChildPath 'scripts\Join.ps1') (Join-Path $user_module_path -ChildPath 'Join.psm1')

Copy-Item profile.ps1 $profile_loc
