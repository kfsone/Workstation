if ($IsWindows) {
  $env:GOROOT="C:\Go"
  [Environment]::SetEnvironmentVariable("GOROOT", $env:GOROOT, "User")
  Write-Host "Setting GOROOT to ${env:GOROOT}"
} else {
  if (!$env:GOROOT) {
    $env:GOROOT = "/usr/local/go"
  }
  [Environment]::SetEnvironmentVariable("GOROOT", $env:GOROOT, "User")
  Write-Host "Setting GOROOT to ${env:GOROOT}"
}

if (! $env:GOPATH) {
  $env:GOPATH = Join-Path "${HOME}" "go"
  [Environment]::SetEnvironmentVariable("GOPATH", $env:GOPATH, "User")
  Write-Host "Setting GOPATH to ${env:GOPATH}"
}

# Where my personal projects are kept
$env:GOBASE = "github.com/kfsone"

Function GoCD {
  Param([string] $Project = $env:GOBASE)

  cd $env:GOPATH
  if (-Not(Test-Path src)) {
    New-Item -Type Directory "src" -ErrorAction Stop
  }
  Set-Location -ErrorAction Stop src
  if ($Project -NE $env:GOBase) {
    $myproj = Join-Path $env:GOBASE $Project
    if (Test-Path $myproj) {
      $Project = $myproj
    }
  }
  Set-Location -ErrorAction Stop $Project
}
