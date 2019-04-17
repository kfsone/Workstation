Function Enter-DockerContainer
{
  [CmdletBinding(SupportsShouldProcess=$true)]
  Param(
    [Parameter(Mandatory=$true, HelpMessage="Name/tag of the container to enter")]
    [String]
    $Container,

    [Parameter(HelpMessage="Command line to execute in the container")]
    [String]
    $Command,

    [Parameter(HelpMessage="Remove container on exit")]
    [Switch]
    $RM = $true,

    [Parameter(HelpMessage="'docker' executable to use")]
    [String]
    $Docker = "docker"
  )

  $cmd_exec = $Docker
  $cmd_args = ("run", "-it")
  if ($RM) { $cmd_args += ("--rm") }
  $cmd_args += ($container)
  if ($command) {
    $cmd_args += ($command)
  }

  if ($pscmdlet.ShouldProcess("$cmd_exec $cmd_args", "Enter")) {
    &$cmd_exec $cmd_args
  }
}
