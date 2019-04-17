###############################################################################
# Unix-like "grep"

Function Grep-String
{
  Param(
    [Parameter(Mandatory=$true)]
    [String] $Pattern,
    [String[]] $Files = "*.*",
    [Switch] $CaseSensitive,
    [Switch] $Recurse
  )

  Get-ChildItem -Recurse:$Recurse -Include $Files | `
    Select-String -Pattern $Pattern -CaseSensitive:$CaseSensitive
}

