Function Run-CryofallServer() {
  Param(
    [Parameter(HelpMessage="Location of the Cryofall server install.")]
    [string]
    $ServerInstall = "G:/Games/Servers/CryoFall",

    [Parameter(HelpMessage="Path to the server binary (ServerInstall relative or can be absolute")]
    $ServerBinary = "./Binaries/Server/CryoFall_Server.dll",

    [Parameter(HelpMessage="Server action (load, loadOrNew, etc)")]
    [string]
    $Action = "load"
  )

  try {
    $PreviousLocation = Get-Location
    Set-Location -ErrorAction Stop $ServerInstall

    if (!(Test-Path $ServerBinary)) {
        throw "Missing server binary: $ServerBinary"
    }

    dotnet $ServerBinary $action

  } finally {
    Set-Location $PreviousLocation
  }
}
