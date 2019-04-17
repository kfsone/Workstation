Function Sudo-Powershell
{
  if ($IsWindows) {
    Start-Process powershell -verb runAs
  } else {
    $sudo = Get-Command sudo -Type Application
    if ($sudo) {
      Invoke-Expression $sudo
    }
  }
}
