Function Add-Path() {
	[CmdletBinding(SupportsShouldProcess=$true)]
	Param(
		[Parameter(HelpMessage='Specify file to load paths from')]
		[String] $File,
		
		[Parameter(HelpMessage='One or more paths to add to the PATH variable')]
		[String[]] $Paths
	)

  $PathSep = ':'
  if ($IsWindows) {
    $PathSep = ';'
  }

	# If there exists a local list of paths, add them to the path variable
	if ($File) {
		Resolve-Path $File >$nil
	 	ForEach ($newpath in (Get-Content $File) -Split "`n") {
		  $newpath = $newpath -Replace '\s*#.*',''
		  if ($newpath) {
			  $PathList += @($newpath)
		  }
		}
	}

	$PathList += $Paths
	$CurPaths = $env:PATH -Split $PathSep
	ForEach ($path in $pathlist) {
		if (!($path -In $curpaths)) {
			$pscmdlet.WriteVerbose("Add: $path")
			$CurPaths += @($path)
		}
	}
  $patn = $PathSep + $PathSep + '+'
	$paths = ($CurPaths -Join $PathSep) -Replace $patn,$PathSep
	$paths = $paths -Replace "(^${PathSep}|${PathSep}$)",''
	if ($paths -Ne $env:PATH) {
		if ($pscmdlet.ShouldProcess($Paths, "Set Path")) {
			$env:PATH = $paths
		}
	} else {
		$pscmdlet.WriteVerbose("No change")
	}
}
