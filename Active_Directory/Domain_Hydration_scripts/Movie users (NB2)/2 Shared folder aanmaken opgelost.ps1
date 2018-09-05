# $cred = # credential niet nodig -> aangemeld met domain admin

$fs = New-PSSession -ComputerName FS01
New-PSSession DC01 
Enter-PSSession $fs

#region maak shared Folder, subfolders en share
$sharedFolder = "c:\Shared"
New-Item -itemtype Directory -path $sharedFolder

$folders = "Scripts","Animatie","Recepties"

foreach($folder in $folders)
{
    New-Item (Join-Path $sharedFolder $folder) -ItemType Directory
}

# shared folder sharen
New-SmbShare -Path $sharedFolder -Name "Shared" `
    -Description "De share van ons domein" `
    -FullAccess Everyone

#endregion

#region rechten instellen, mag ook met de GUI
$InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]::ContainerInherit -bor `                    [System.Security.AccessControl.InheritanceFlags]::ObjectInherit$PropagationFlag = [System.Security.AccessControl.PropagationFlags]::None
$AllowFlag = [System.Security.AccessControl.AccessControlType]::Allow

$acl = get-acl $sharedFolder
$acl.SetAccessRuleProtection($true,$false)
# https://msdn.microsoft.com/en-us/library/system.security.accesscontrol.objectsecurity.setaccessruleprotection(v=vs.110).aspx

# (add ACE to ACL)
$principal = New-Object system.Security.Principal.NTAccount( "local.cursusdom.tm", "Domain Admins" )
$right = "FullControl"
$rule=new-object System.Security.AccessControl.FileSystemAccessRule ($principal,$right,$InheritanceFlag,$PropagationFlag,$AllowFlag)
$acl.SetAccessRule($rule)

# (add ACE to ACL)
$principal = New-Object system.Security.Principal.NTAccount( "Administrators" )
$right = "FullControl"
$rule=new-object System.Security.AccessControl.FileSystemAccessRule ($principal,$right,$InheritanceFlag,$PropagationFlag,$AllowFlag)
$acl.SetAccessRule($rule)

# (add ACE to ACL)
$principal = New-Object system.Security.Principal.NTAccount( "SYSTEM" )
$right = "FullControl"
$rule=new-object System.Security.AccessControl.FileSystemAccessRule ($principal,$right,$InheritanceFlag,$PropagationFlag,$AllowFlag)
$acl.SetAccessRule($rule)

$acl.Access
   
# set ACL back to folder
set-acl $sharedFolder $acl

#endregion

