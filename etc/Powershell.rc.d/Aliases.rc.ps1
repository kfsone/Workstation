# Aliases for things that are missing on Windows
if ($IsWindows) {
  Set-Alias   vi      vim
  Set-Alias   which   Get-Command
  Set-Alias   grep    Grep-String
  Set-Alias   touch   Touch-Item
}
