#region logon (disable powercli)
$cred = Get-Credential "Administrator"
Remove-Module "Vmware*"
$PSModuleAutoloadingPreference = "none"
Get-Module -ListAvailable
Import-Module "Hyper-V"
Enter-PSSession -VMName "DC01" -Credential $cred
#endregion

#region install domain

Get-WindowsFeature "AD*"
Install-WindowsFeature "AD-Domain-Services" -IncludeAllSubFeature -IncludeManagementTools

Install-ADDSForest -DomainName "Local.powershell.tm" -DomainNetbiosName "PS"

# return to connect, different credentials!

#endregion


#region create Admin

New-ADUser -Name "Admin" -UserPrincipalName "Admin" -SamAccountName "Admin" `
    -AccountPassword (ConvertTo-SecureString "R1234-56" -AsPlainText -Force) -Enabled $true

Get-ADUser "Admin" | Add-ADPrincipalGroupMembership -MemberOf "Domain Admins"
Get-ADUser "Admin" | Add-ADPrincipalGroupMembership -MemberOf "Administrators"

#endregion