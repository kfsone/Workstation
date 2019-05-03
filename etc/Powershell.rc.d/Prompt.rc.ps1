###############################################################################
# Change prompt to be two lines.
#
Function Prompt {
  $location = "[$($executionContext.SessionState.Path.CurrentLocation)]"
  Write-Host -Background 1 -Foreground 7 "${location}`r"
  "$('>' * ($nestedPromptLevel + 1)) "
  # .Link# http://go.microsoft.com/fwlink/?LinkID=225750
  # # .ExternalHelp System.Management.Automation.dll-help.xml
}
