# 'tinker' existed in d:\dev originally until I started having
# a local 'github' folder, so although this file is focused on
# 'tinker' it is now also kind of a natural home for my github
# alias too.

if (!$env:DEV_PATH) {
  if ((Test-Path D:) -And (Test-Path D:/Dev)) {
    $env:DEV_PATH = Join-Path D: Dev
  } else {
    $env:DEV_PATH = Join-Path $HOME Development
  }
}
$env:GITHUB_PATH = Join-Path $env:DEV_PATH github.com
 
$env:TINKER_PATH = Join-Path $env:GITHUB_PATH kfsone/tinker

Function GoHub {
  Param(
    [Parameter(Mandatory=$true)]
    [String] $project,
    [String] $user = "kfsone",
    [Switch] $create
  )

  $userPath = Join-Path $env:GITHUB_PATH $user
  if (-Not(Test-Path $userPath)) {
    if (!$create) {
      Write-Error "No such user folder: $userPath"
      return 1
    }
    New-Item -Directory $userPath -ErrorAction Stop
  }

  $projectPath = Join-Path $userPath $project
  if (-Not(Test-Path $projectPath)) {
    if (!$create) {
      Write-Error "No such project folder: $projectPath"
      return 1
    }
    New-Item -Directory $projectPath -ErrorAction stop
    git init .
  }

  Set-Location $projectPath
}

Function Tinker {
    Param([String] $language = "python")
    Set-Location (Join-Path $env:TINKER_PATH $language)
}
