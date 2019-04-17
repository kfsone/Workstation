Function Fetch-Item
{
  [CmdletBinding(SupportsShouldProcess=$true)]
  Param(
    [string] $URL,
    [string] $Output
  )

  if (!$Output)
  {
      $Output = Split-Path -Leaf $URL
  }

  $webcli = New-Object System.Net.WebClient
  if ($pscmdlet.ShouldProcess($URL, "Download")) {
    $webcli.DownloadFile($URL, $Output)
  }

  $pscmdlet.WriteVerbose("Downloaded $($URL) => $($Output)")
}

