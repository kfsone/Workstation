Enum VCSProvider {
  TortoiseSvn
  Git
}

Function Commit-Item
{
  [CmdletBinding(SupportsShouldProcess=$true)]
  Param(
    [String] $Path = ".",
    [VCSProvider] $Provider = [VCSProvider]::TortoiseSvn
  )

  $abspath = Resolve-Path -Absolute $Path
  if ($cmdlet.ShouldProcess($abspath, "Commit")) {
    switch ($Provider)
    {
      [VCSProvider]::TortoiseSvn
      { tortoiseproc /command:commit /path:$Path }

      [VCSProvider]::Git
      { git commit $Path }
    }
  }
}

