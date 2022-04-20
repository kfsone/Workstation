<#
.Description
Adds the 'vsdev' (alias for Enable-VsDevShell) command to your powershell arsenal.
#>


function Enable-VsDevShell () {
  # Locate the visual studio installer's "where" tool for locating vs paths.
  $VsWhere = Join-Path (Join-Path (Join-Path ${env:ProgramFiles(x86)} 'Microsoft Visual Studio') Installer) vswhere.exe
  if ( ! (Test-Path $VsWhere) ) {
    # Not found, can't help.
    throw "Visual studio is not installed in a recognized location. Could not find ${vswhere}"
  }
  
  # Get the most recent install path (-last 1) from its list of installed locations.
  $VisualStudioInstallPath = & $VsWhere -prerelease -latest -property installationPath | select -last 1

  # Import the devshell module from that install
  Import-Module -ea stop (Join-Path (Join-Path (Join-Path $VisualStudioInstallPath Common7) Tools) Microsoft.VisualStudio.DevShell.dll)

  # Use the module's "Enter-VsDevShell" to enable it properly
  Enter-VsDevShell -VsInstallPath $VisualStudioInstallPath -SkipAutomaticLocation -DevCmdArguments "-arch=amd64 -host_arch=amd64"
}

# Handy alias.
New-Alias -Name vsdev -Value Enable-VisualStudioEnv

