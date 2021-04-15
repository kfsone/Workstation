# Where my personal projects are kept
if (-not $env:GITHUB_ROOT) {
  foreach ($path in "dev","src","Projects","Dev","Development") {
    $github = Join-Path $HOME $path
    echo "testing $github"
    if (Test-Path (Join-Path $github "github.com" "kfsone")) {
      $env:GITHUB_ROOT = $github
      break
    }
  }
  if (-not $env:GITHUB_ROOT) {
    write-warning "XX Unable to find github base"
  }
}
if ($env:GITHUB_ROOT) {
  $env:GITHUB_CD = Join-Path $env:GITHUB_ROOT "github.com" "kfsone"
}

Function ghcd {
  Param([string] $Project = $env:GITHUB_CD)

  if ($Project -NE $env:GITHUB_ROOT && $Project -NE $env:GITHUB_CD) {
    Set-Location -erroraction stop $env:GITHUB_ROOT
    $candidates = "nibble.home.kfs.org","nibble.home.kfs.org/oliver","nibble.home.kfs.org","github.com/kfsone","github.com"
    foreach ($c in $candidates) {
      $candidate = Join-Path $c $Project
      if (Test-Path $candidate) {
        $Project = $candidate
        break
      }
    }
  }
  Set-Location -ErrorAction Stop $Project
}
