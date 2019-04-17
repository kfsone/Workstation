[CmdletBinding(SupportsShouldProcess = $true)]
Param([String] $ScriptPath=$PSScriptRoot)

$pscmdlet.WriteVerbose("Searching $ScriptPath for .rc.ps1 scripts")
Get-ChildItem $ScriptPath -File -Filter *.rc.ps1 | ForEach {
  $script = $_.FullName
	if ($pscmdlet.ShouldProcess($script, "Source")) {
		. $script
	}
}
