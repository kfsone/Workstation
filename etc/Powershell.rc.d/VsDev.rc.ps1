function vsdev () {
  $VsWhere = Join-Path (Join-Path (Join-Path ${env:ProgramFiles(x86)} 'Microsoft Visual Studio') Installer) vswhere.exe
  if ( Test-Path $VsWhere ) {
    $VisualStudioInstallPath = & $VsWhere -prerelease -latest -property installationPath | select -last 1
    Import-Module -ea stop (Join-Path (Join-Path (Join-Path $VisualStudioInstallPath Common7) Tools) Microsoft.VisualStudio.DevShell.dll)
    Enter-VsDevShell -VsInstallPath $VisualStudioInstallPath -SkipAutomaticLocation -DevCmdArguments "-arch=amd64 -host_arch=amd64"
  } else {
    write-error "Could not find ${vswhere}"
  }
}

