function VPN () {
  Param(
    [Parameter(HelpMessage="Specify network name (default: SEMC)")]
    [String]
    $Network = "SEMC",
    [Parameter(HelpMessage="Connect to the VPN",
               ParameterSetName="VpnUp")]
    [Switch]
    $Up,
    [Parameter(HelpMessage="Disconnect the VPN",
               ParameterSetName="VpnDown")]
    [Switch]
    $Down
  )

  if ($IsWindows) {
    if ($Up) {
      rasdial "$Network"
    } else {
      rasdial "$Network" /disconnect
    }
  } elseif ($IsOSX) {
    if ($Up) {
      networksetup -connectpppoeservice "$Network"
    } else {
      networksetup -disconnectpppoeservice "$Network"
    }
  } else {
    Write-Error "Platform $(PSVersionTable.Platform) not supported"
  }
}
