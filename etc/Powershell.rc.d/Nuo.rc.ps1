if (-Not $env:NUO_DEVROOT -And (Test-Path D:\Development\Projects\Evil02)) {
  $env:NUO_DEVROOT = "D:\Development\Projects\Evil02"
}

if ($env:NUO_DEVROOT) {
  function Set-NuoLocation {
    Param([string] $SubPath)
    $location = $env:NUO_DEVROOT
    if ($SubPath) {
      $location = Join-Path $location $subpath
      if (!(Test-Path $location)) {
        Write-Error "$location does not exist."
        return
      }
    }
    Set-Location $env:NUO_DEVROOT
    foreach ($pyv in 27,35,36,37,38,39,310) {
      if (Test-Path ".venv${pyv}") {
        . ./.venv${pyv}/scripts/activate.ps1
        break
      }
    }
    if ($IsWindows) {
      if (Get-Command vsdev) {
        vsdev -v 16
      }
    }

    Set-Location $location
  }

  Set-Alias nuo set-nuolocation
}
