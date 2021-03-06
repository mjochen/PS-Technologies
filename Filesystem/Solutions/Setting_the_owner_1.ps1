$basefolder = "c:\TestFolder"
$username = "Morgan Freeman"

# must be run as administrator
$objOu = [ADSI]"WinNT://localhost"
$objUser = $objOU.Create("User", $username )
$objUser.setpassword("R1234-56")
$objUser.SetInfo()

# or starting from 5.0
New-LocalUser -Name "Morgan Lily" `
    -Password ( ConvertTo-SecureString "R1234-56" -AsPlainText -Force) `
    -AccountExpires (Get-Date).AddDays(1) `
    -Disabled:$False

# create folder
md "$basefolder\$username"

$acl = Get-Acl "$basefolder\$username"

$acl.SetAccessRuleProtection($True, $False)

$user = "CREATOR OWNER"
$rights = [System.Security.AccessControl.FileSystemRights]"FullControl"
$access = [System.Security.AccessControl.AccessControlType]::Allow
$inherit = [System.Security.AccessControl.InheritanceFlags]::ContainerInherit `
    -bor [System.Security.AccessControl.InheritanceFlags]::ObjectInherit
$propagation = [System.Security.AccessControl.PropagationFlags]::None
$accessrule = New-Object System.Security.AccessControl.FileSystemAccessRule($user,$rights,$inherit,$propagation,$access)

$acl.AddAccessRule($accessrule)

$user = "Users"
$rights = [System.Security.AccessControl.FileSystemRights]"ReadPermissions"
$access = [System.Security.AccessControl.AccessControlType]::Allow
$inherit = [System.Security.AccessControl.InheritanceFlags]::ContainerInherit `
-bor [System.Security.AccessControl.InheritanceFlags]::ObjectInherit
$propagation = [System.Security.AccessControl.PropagationFlags]::None
$accessrule = New-Object System.Security.AccessControl.FileSystemAccessRule($user,$rights,$inherit,$propagation,$access)

$acl.AddAccessRule($accessrule)

$acl | Set-Acl -Path "$basefolder\$username"

$acl.access

# changing the owner
$acl.Owner
$user = New-Object System.Security.Principal.NTAccount("$env:USERDOMAIN\$username")

$acl.SetOwner($user)

$acl | Set-Acl -Path "$basefolder\$username"
