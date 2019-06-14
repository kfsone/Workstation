$ScriptPath = Join-Path $WSHOME etc/Powershell.rc.d

Get-ChildItem $ScriptPath -File *.rc.ps1 | ForEach {
  $script = $_.FullName
  Write-Host "-- + $script"
  . $script
}
