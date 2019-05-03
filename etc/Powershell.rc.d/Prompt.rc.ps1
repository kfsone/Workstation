###############################################################################
# Change prompt to be two lines.
#
Function Prompt {
  "[$($executionContext.SessionState.Path.CurrentLocation)]`r`n$('>' * ($nestedPromptLevel + 1)) "
  # .Link# http://go.microsoft.com/fwlink/?LinkID=225750
  # # .ExternalHelp System.Management.Automation.dll-help.xml
}
