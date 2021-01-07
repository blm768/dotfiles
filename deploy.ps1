Install-Module -Scope CurrentUser PSFzf

$profile_loc = $PROFILE."CurrentUserAllHosts"
Copy-Item profile.ps1 $profile_loc
