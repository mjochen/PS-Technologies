$sharedFolder = "\\FS01.local.cursusdom.tm\Shared"

$groupOU = Get-ADOrganizationalUnit -Filter "Name -eq 'Groups' "

$folders = Get-ChildItem -Path $sharedFolder -Directory

$InheritanceFlag = [System.Security.AccessControl.InheritanceFlags]::ContainerInherit -bor `                    [System.Security.AccessControl.InheritanceFlags]::ObjectInherit$PropagationFlag = [System.Security.AccessControl.PropagationFlags]::None
$AllowFlag = [System.Security.AccessControl.AccessControlType]::Allow

# go through all folders, create groups and set permissions
foreach($folder in $folders)
{
    # create the groups, and store them in a variabele for future use
    $modify = New-ADGroup -GroupScope DomainLocal -Name $("DL_" + $folder.name + "_Modify") -Path $groupOU.DistinguishedName -PassThru
    $read = New-ADGroup -GroupScope DomainLocal -Name $("DL_" + $folder.name + "_Read") -Path $groupOU.DistinguishedName -PassThru

    # Setting NTFS is difficult, exhibit B:
    # (get the ACL)
    $acl = get-acl $folder.FullName

    # (add ACE to ACL)
    $principal = New-Object system.Security.Principal.NTAccount( $read.Name )
    $right = "ReadAndExecute"
    $rule=new-object System.Security.AccessControl.FileSystemAccessRule ($principal,$right,$InheritanceFlag,$PropagationFlag,$AllowFlag)
    $acl.SetAccessRule($rule)
    
    # (again)
    $principal = New-Object system.Security.Principal.NTAccount( $modify.Name  )
    $right = "Modify";
    $rule=new-object System.Security.AccessControl.FileSystemAccessRule ($principal,$right,$InheritanceFlag,$PropagationFlag,$AllowFlag)
    $acl.SetAccessRule($rule)
   
    # set ACL back to folder
    set-acl $folder.FullName $acl
}