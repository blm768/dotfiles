Install-Module -Scope CurrentUser PSFzf
Install-Script -Scope CurrentUser Join -NoPathUpdate

$profile_loc = $PROFILE."CurrentUserAllHosts"
Copy-Item profile.ps1 $profile_loc
