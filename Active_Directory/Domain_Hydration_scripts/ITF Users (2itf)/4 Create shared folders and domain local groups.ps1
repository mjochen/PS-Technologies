# create Folders in a shared folder
$sharedFolder = "c:\Shared"

$folders = "Facturen","Promomateriaal","Productierapporten","Netwerkdocumentatie","Onderzoeksrapporten"

foreach($folder in $folders)
{
    New-Item (Join-Path $sharedFolder $folder) -ItemType Directory
}

# setting the variables (again)
$companyName = "GeneralInc"
$companyOU = Get-ADOrganizationalUnit -Filter "Name -eq '$companyName' "
$groupOU = Get-ADOrganizationalUnit -Filter "Name -eq 'Groups' " -SearchBase $companyOU.DistinguishedName

# Creating groups and setting permissions for folders
$sharedFolder = "\\fs\Shared"
$folders = Get-ChildItem -Path "\\fs\Shared" -Directory
# $folders is now no longer an array with strings, but an array with folder-objects
# Which is much better when assigning priviliges

# Setting NTFS is difficult, exhibit A:
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