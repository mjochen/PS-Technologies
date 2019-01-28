# Copyright (C) Microsoft Corporation. All rights reserved.

  $osver = [System.Environment]::OSVersion.Version
  $win7 = New-Object System.Version 6, 1, 7601, 0

  if($osver -lt $win7)
  {
      Write-Error "OS Version is not compatible for this script. Please run on Windows 7 or above"
      return
  }

  Try
  {
      Import-Module GroupPolicy
  }
  Catch
  {
      Write-Error "GP Management tools may not be installed on this machine. Script cannot run"
      return
  }

  $arrgpo = New-Object System.Collections.ArrayList

  foreach ($loopGPO in Get-GPO -All)
  {
      if ($loopGPO.User.Enabled)
      {
          $AuthPermissionsExists = Get-GPPermissions -Guid $loopGPO.Id -All | Select-Object -ExpandProperty Trustee | ? {$_.Name -eq "Authenticated Users"}
          If (!$AuthPermissionsExists)
          {
              $arrgpo.Add($loopGPO) | Out-Null
          }
      }
  }

  if($arrgpo.Count -eq 0)
  {
      echo "All Group Policy Objects grant access to 'Authenticated Users'"
      return
  }
  else
  {
      Write-Warning  "The following Group Policy Objects do not grant any permissions to the 'Authenticated Users' group:"
      foreach ($loopGPO in $arrgpo)
      {
          write-host "'$($loopgpo.DisplayName)'"
      }
  }

  $title = "Adjust GPO Permissions"
  $message = "The Group Policy Objects (GPOs) listed above do not have the Authenticated Users group added with any permissions. Group policies may fail to apply if the computer attempting to list the GPOs required to download does not have Read Permissions. Would you like to adjust the GPO permissions by adding Authenticated Users group Read permissions?"

  $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", `
      "Adds Authenticated Users group to all user GPOs which don't have 'Read' permissions"

  $no = New-Object System.Management.Automation.Host.ChoiceDescription "&No", `
      "No Action will be taken. Some Group Policies may fail to apply"

  $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)

  $result = $host.ui.PromptForChoice($title, $message, $options, 0)

  $appliedgroup = $null

  switch ($result)
  {
      0 {$appliedgroup = "Authenticated Users"}
      1 {$appliedgroup = $null}
  }


  If($appliedgroup)
  {
      foreach($loopgpo in $arrgpo)
      {
          write-host "Adding 'Read' permissions for '$appliedgroup' to the GPO '$($loopgpo.DisplayName)'."
          Set-GPPermissions -Guid $loopgpo.Id -TargetName $appliedgroup -TargetType group -PermissionLevel GpoRead | Out-Null
      }
  }