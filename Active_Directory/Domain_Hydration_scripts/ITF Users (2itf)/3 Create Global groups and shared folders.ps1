# Set variables
$companyName = "GeneralInc"

# Get domain name
$domain = (Get-ADDomain).DistinguishedName

# Create OU to house groups
$companyOU = Get-ADOrganizationalUnit -Filter "Name -eq '$companyName' "
$groupOU = New-ADOrganizationalUnit -name "Groups" -Path $companyOU.DistinguishedName -PassThru

# Create global groups
# one global group for every OU under Users...
$userOU = Get-ADOrganizationalUnit -Filter "Name -eq 'Users' " -SearchBase $companyOU.DistinguishedName

$allDepartments = Get-ADOrganizationalUnit -SearchBase $userOU.DistinguishedName -SearchScope OneLevel -Filter *

# check'em
# $allDepartments | ft

# create Global group for every OU, and add all users from that OU to the global group
foreach($department in $allDepartments)
{
    $groupName = "GG_" + $department.Name
    $theNewGroup = New-ADGroup -Name $groupName -GroupScope Global -GroupCategory Security -Path $groupOU.DistinguishedName -PassThru

    Get-ADUser -SearchBase $department.DistinguishedName -Filter * | Add-ADPrincipalGroupMembership -MemberOf $theNewGroup
}



