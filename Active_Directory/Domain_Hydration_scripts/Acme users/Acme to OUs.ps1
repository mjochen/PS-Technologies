
$baseFolder = Get-ADOrganizationalUnit -filter {Name -eq "Users"}

$loc = New-ADOrganizationalUnit -Path $baseFolder.DistinguishedName -Name "Directie" -PassThru
Get-ADUser -SearchBase $baseFolder.DistinguishedName -SearchScope OneLevel -Filter { Name -like "Morgan*" } |
    Move-ADObject -TargetPath $loc.DistinguishedName

$loc = New-ADOrganizationalUnit -Path $baseFolder.DistinguishedName -Name "R&D" -PassThru
Get-ADUser -SearchBase $baseFolder.DistinguishedName -SearchScope OneLevel -Filter { Name -like "R*" -or Name -Like "D*"} |
    Move-ADObject -TargetPath $loc.DistinguishedName

$loc = New-ADOrganizationalUnit -Path $baseFolder.DistinguishedName -Name "Sales" -PassThru
Get-ADUser -SearchBase $baseFolder.DistinguishedName -SearchScope OneLevel -Filter { Name -like "S*"} |
    Move-ADObject -TargetPath $loc.DistinguishedName

$loc = New-ADOrganizationalUnit -Path $baseFolder.DistinguishedName -Name "Accountancy" -PassThru
Get-ADUser -SearchBase $baseFolder.DistinguishedName -SearchScope OneLevel -Filter { Name -like "A*" } |
    Move-ADObject -TargetPath $loc.DistinguishedName

$loc = New-ADOrganizationalUnit -Path $baseFolder.DistinguishedName -Name "Production" -PassThru
Get-ADUser -SearchBase $baseFolder.DistinguishedName -SearchScope OneLevel -Filter { Name -like "*" } |
    Move-ADObject -TargetPath $loc.DistinguishedName


$ous = Get-ADOrganizationalUnit -SearchBase $baseFolder.DistinguishedName -SearchScope OneLevel -Filter { Name -like "*" }
$acme = Get-ADOrganizationalUnit -filter { Name -eq "Acme" }
New-ADOrganizationalUnit -Path $acme.DistinguishedName -Name "Groups" # passthru...
$groupFolder = Get-ADOrganizationalUnit -filter { Name -eq "Groups" }

foreach($ou in $ous)
{
    $group = New-ADGroup -Path $groupFolder.DistinguishedName -Name $ou.Name -GroupCategory Security -GroupScope Global -PassThru
    Get-ADUser -SearchBase $ou.DistinguishedName -Filter { Name -like "*" } |
        Add-ADPrincipalGroupMembership -MemberOf $group
}
