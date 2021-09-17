Param(
  [String]
  $DefaultScript = (Join-Path "config" "common-setup.scr")
)

Function Ensure-Dir {
	Param([Parameter(Mandatory = $true)][String] $Path)

	if (!(Test-Path $Path)) {
		$dir = mkdir $Path
	}
}

Get-Content $DefaultScript | Invoke-Expression
