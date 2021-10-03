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

try {
  $tmpscript = Join-Path $env:TEMP ws.setup.ps1
  copy $DefaultScript $tmpscript
  & $tmpscript -ea stop
} finally {
  rm $tmpscript
}
