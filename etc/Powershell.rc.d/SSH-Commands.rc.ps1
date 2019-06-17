# SSH Functions

Function New-SSHPSSession {
  [CmdletBinding()]
  Param(
    [Parameter(HelpMessage='Name of the machine to connect to', Mandatory=$true)]
    [String] $HostName,

    [Parameter(HelpMessage='Username to use, if not the current user')]
    [String] $UserName = [Environment]::UserName,

    [Parameter(HelpMessage='Path to the key file to use, if one is required')]
    [String] $KeyFilePath
  )

  if (!$UserName) {
    throw "UserName is required"
  }

  if ($KeyFilePath) {
    New-PSSession -SSHTransport -UserName:$UserName -HostName:$HostName -KeyFilePath:$KeyFilePath
  } else {
    New-PSSession -SSHTransport -UserName:$UserName -HostName:$HostName
  }
}

Function Enter-SSHPSSession {
  [CmdletBinding()]
  Param(
    [Parameter(HelpMessage='Name of the machine to connect to', Mandatory=$true)]
    [String] $HostName,

    [Parameter(HelpMessage='Username to use, if not the current user')]
    [String] $UserName = [Environment]::UserName,

    [Parameter(HelpMessage='Path to the key file to use, if one is required')]
    [String] $KeyFilePath
  )

  if (!$UserName) {
    throw "UserName is required"
  }

  if ($KeyFilePath) {
    Enter-PSSession -SSHTransport -UserName:$UserName -HostName:$HostName -KeyFilePath:$KeyFilePath
  } else {
    Enter-PSSession -SSHTransport -UserName:$UserName -HostName:$HostName
  }
}
