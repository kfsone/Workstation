if (!$env:GOROOT) {
  if (!$IsLinux) {
    $env:GOROOT="C:\Go"
  } else {
	$env:GOROOT = "/usr/local/go";
  }
  if (Test-Path $env:GOROOT) {
    Write-Host "Setting GOROOT to ${env:GOROOT}"
    [Environment]::SetEnvironmentVariable("GOROOT", $env:GOROOT, "User")
  }
}

if (!$env:GOPATH) {
  $env:GOPATH = Join-Path "${HOME}" "go"
  if (Test-Path $env:GOPATH) {
    Write-Host "Setting GOPATH to ${env:GOPATH}"
    [Environment]::SetEnvironmentVariable("GOPATH", $env:GOPATH, "User")
  }
}

# Where my personal projects are kept
$env:GOBASE = Join-Path "github.com" "kfsone"

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
