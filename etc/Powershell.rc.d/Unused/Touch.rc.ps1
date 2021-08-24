###############################################################################
# Update the last-write time of a file, or create the file if it doesn't
# already exist.

Function Touch-Item
{
  [CmdletBinding(SupportsShouldProcess=$true)]
  Param(
		[Parameter(Mandatory=$true)]
		[string] $filepath,
		# Setting -Update prevents creation of new item
		[switch] $UpdateOnly
	)

  # Find the item to see if it exists.
  $item = Get-Item -ErrorAction Ignore $filepath
  if (!$item) {
    # doesn't already exist, create it.
    if (!$UpdateOnly -And $pscmdlet.ShouldProcess("$filepath", "Create")) {
      New-Item -File $filepath
    }
  } else {
    if ($pscmdlet.ShouldProcess($item.FullName, "Modify Timestamp")) {
      $item.LastWriteTime = Get-Date
    }
  }
}

