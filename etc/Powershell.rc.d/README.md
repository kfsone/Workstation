# kfsone's powershell fragments

Author: Oliver 'kfsone' Smith <oliver@kfs.org>

Powershell scripts that can be invoked as part of $profile.

I place them into ~/etc/Powershell.rc.d/ and then do the following in my $profile:

```powershell
# Implemented as a function so it's easy to reload on changes.
Function Load-KfsoneScripts ()
{
  Param([String]$Loader = "~/etc/Powershell.rc.d/LOADER.ps1")
  if (Test-Path $Loader) {
	. $Loader
  }
}

Load-KfsoneScripts
```

Or if you don't care about reloads:

```powershell
. ~/etc/Powershell.rc.d/LOADER.ps1
```

Note: Only scripts suffixed ".rc.ps1" will be loaded.

