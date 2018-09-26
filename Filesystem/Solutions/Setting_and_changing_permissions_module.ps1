Install-Module -Name NTFSSecurity # sudo
Get-Command -Module NTFSSecurity

# Create with a cmdlet a new folder under the root of the C-drive called Testfolder.
$f = "c:\testfolder"
New-Item -Path $f -ItemType Directory

# Cycle through the ACL for this folder, and show every ACE with some details.
Get-NTFSAccess $f

# Copy the contents of the temp-folder to this new location.
Copy-Item -Path c:\tmp\* -Destination $folder -Recurse

# Disable the inheritance on the new folder
Disable-NTFSAccessInheritance $f

# Give your own account full management-rights over this folder and his files, but not the subfolders.
$user = $env:USERNAME
Add-NTFSAccess -Path $f -Account $user -AccessRights FullControl -AccessType Allow # sudo

# Transfer the accesspermissions from this folder to the folder Tmp.
md c:\temp
Get-NTFSAccess -Path $f | add-ntfsaccess -Path c:\temp # sudo

# Delete all non-inherited permissions on Tmp.
Get-NTFSAccess -Path $f | Where-Object InheritedFrom -eq "" | Remove-NTFSAccess

