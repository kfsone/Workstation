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

    [Parameter(HelpMessage="Mount PWD to specified path in container")]
    [String]
    [ValidateScript({ $_.StartsWith("/") })]
    $PWDMount,

    [Parameter(HelpMessage="Specify a local folder to be mounted at a location in the container")]
    [String[]]
    [ValidateScript({ $_.Contains("=/") })]
    $Mount,

    [Parameter(HelpMessage="Remove container on exit")]
    [Switch]
    $RM,

    [Parameter(HelpMessage="'docker' executable to use")]
    [String]
    $Docker = "docker"
  )

  $cmd_exec = $Docker
  $cmd_args = ("run", "--interactive", "--tty")

  if ($RM) { $cmd_args += ("--rm") }

  if ($PWDMount) {
    [String]$pwd_str = Resolve-Path (Get-Location).Path
    $cmd_args += ("--volume",  "${pwd_str}:${PWDMount}")
    $cmd_args += ("--workdir", "$PWDMount")
  }

  ForEach ($tuple in $Mount) {
    $source, $target = $tuple -Split "="
    [String]$source = (Resolve-Path $source).Path
    $cmd_args += ("-v", "${source}:${target}")
  }

  $cmd_args += ($container)

  if ($Command) {
    $cmd_args += ($command)
  }

  if ($pscmdlet.ShouldProcess("$cmd_exec $cmd_args", "Enter")) {
    &$cmd_exec $cmd_args
  }
}
