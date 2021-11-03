function vsdev () {
  Param([string] $Version = "latest")
  $VsWhere = Join-Path (Join-Path (Join-Path ${env:ProgramFiles(x86)} 'Microsoft Visual Studio') Installer) vswhere.exe
  if ( Test-Path $VsWhere ) {
    if ($Version -eq "latest") {
      $VisualStudioInstallPath = & $VsWhere -prerelease -latest -property installationPath | select -last 1
    } else {
      $VisualStudioInstallPath = & $VsWhere -prerelease -version "[${Version}.0,${Version}.9999)" -property installationPath | select -last 1
    }
    Import-Module -ea stop (Join-Path (Join-Path (Join-Path $VisualStudioInstallPath Common7) Tools) Microsoft.VisualStudio.DevShell.dll)
    Enter-VsDevShell -VsInstallPath $VisualStudioInstallPath -SkipAutomaticLocation -DevCmdArguments "-arch=amd64 -host_arch=amd64"
  } else {
    write-error "Could not find ${vswhere}"
  }
}

