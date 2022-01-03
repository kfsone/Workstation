Function GetGitRev () {
	if (git rev-parse --git-dir 2> $null) {
		$symbolicref = $(git symbolic-ref --short HEAD 2>$NULL)
		if (!$symbolicref) {
				$symbolicref = $(git describe --tags --always 2>$NULL)
		}
    return $symbolicref
	}

  return ""
}

###############################################################################
# Change prompt to be two lines.
#
Function Prompt {
  $location = "[$($executionContext.SessionState.Path.CurrentLocation)]"
  $branch = GetGitRev
  if ($branch) { 
    if ($branch -eq 'master' -or $branch -eq 'main' -or $branch -eq 'Trunk') {
      $branchtext = "`e[44m:${branch}:`e[0m "
    } else {
      $branchtext = "`e[45m|${branch}|`e[0m "
    }
  }
  $promptlevel = '>' * ($nestedPromptLevel + 1)
  "${branchtext}${location}`n${promptlevel} "
  # .Link# http://go.microsoft.com/fwlink/?LinkID=225750
  # # .ExternalHelp System.Management.Automation.dll-help.xml
}

