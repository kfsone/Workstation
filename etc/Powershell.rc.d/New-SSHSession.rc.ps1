Function New-SSHSession
{
  [CmdletBinding(SupportsShouldProcess=$true)]
  param(
    [Parameter(Mandatory=$true)]
    [string] $HostName,
    [string] $User = [Environment]::UserName,
    [string] $Password
  )

  if ($Password) {
    return New-PSSession -SSHTransport -HostName $HostName -UserName $User -Password $Password
  } else {
    return New-PSSession -SSHTransport -HostName $HostName -UserName $User
  }
}

