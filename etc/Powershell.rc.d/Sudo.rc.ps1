Function Sudo-Powershell
{
  if ($IsWindows) {
    $Command = @('Start-Process', 'powershell','-verb','runAs')
  } else {
    $Command = @(Get-Command sudo -Type Application) 
  }
  $Command = ($Command,"`"$Args`"")
  Invoke-Expression "$command"
}
