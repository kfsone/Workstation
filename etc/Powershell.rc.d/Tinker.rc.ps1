# Switch to one of my "tinkering" projects.

$script:DEFAULT_BASE = [System.Environment]::GetEnvironmentVariable("TINKER_BASE")
if (! $script:DEFAULT_BASE) {
  $script:DEFAULT_BASE = "D:\Dev\Tinker"
}

Function Tinker
{
  [CmdletBinding(SupportsShouldProcess=$true)]
  Param(
    [String] $Language = "python",
    [String] $Base     = $script:DEFAULT_BASE
  )

  $destination = Join-Path -Path "$Base" -ChildPath "$Language"
  if ($pscmdlet.ShouldProcess($destination, "Change Directory")) {
    Set-Location $destination
  }
}
