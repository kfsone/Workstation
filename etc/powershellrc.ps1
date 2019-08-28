# kfsone's Powershell Profile Script
# Author: Oliver 'kfs1' Smith <oliver@kfs.org>
# License: Public
#
# This file expects to live in ~/etc/ as "powershellrc.ps1".
#
# To use, source from your $profile script, e.g
#
#  [PS]> Out-File $profile ". ~/etc/powershellrc.ps1"

[CmdletBinding()]


# I use Chocolatey for package management on Windows. If the
# script is present, run it.
$ChocoRC = "${HOME}/etc/chocolateyrc.ps1"
if (Resolve-Path $ChocoRC -ErrorAction SilentlyContinue) {
  Write-Host "-- Loading ChocoRC"
  . $ChocoRC
}


# Locate the "Workstation home"
if (!$WSHome) {
  if ($env:WSHOME -And (Test-Path "$env:WSHOME")) {
    $WSHome = $env:WSHOME
  } else {
    ForEach ($path in "${HOME}","${HOME}/.local","$env:LOCAL_APPDATA") {
      if ($path) {
        ForEach ($folder in "Workstation",".Workstation") {
          $candidate = Join-Path $path $folder
          if (Test-Path "${candidate}") {
            $WSHome = $candidate
            break
          }
        }
        if ($WSHome) { break }
      }
    }
    if (!$WSHome) {
      Throw "Could not locate `$WSHome Workstation folder"
    }
  }
}
$env:WSHOME = [String]$WSHome
Write-Host "== WSHome: $WSHome"

# If the kfsone powershell rc directory is present, invoke the loader.
$KfsoneRC = "${WSHOME}/etc/Powershell.rc.d/LOADER.ps1"
if (Resolve-Path $KfsoneRC -ErrorAction SilentlyContinue) {
  # Run the scripts
  Write-Host "-- Running KfsoneRC"
  . $KfsoneRC

  # Define a function to make it easy to reload the scripts
  Function global:Load-KfsoneScripts { 
    . $Loader
  }
}

Add-Path -File ~/etc/extra-paths.cfg -ErrorAction SilentlyContinue

$LocalRC = "${HOME}/etc/localpowershellrc.ps1"
if (Resolve-Path $LocalRC -ErrorAction SilentlyContinue) {
  . $LocalRC
}

