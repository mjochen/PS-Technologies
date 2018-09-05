# Set variables
$companyName = "GeneralInc"

# Get domain name
$domain = (Get-ADDomain).DistinguishedName

# Create OU to store users in
$companyOU = New-ADOrganizationalUnit -Name $companyName -Path $domain -PassThru
$userOU = New-ADOrganizationalUnit -name "Users" -Path $companyOU.DistinguishedName -PassThru

# Import CSV-file
$allUsers = Import-Csv C:\tmp\Users.csv -Delimiter ";" -Encoding UTF7

# Create OU's from CSV-file
Foreach($ou in ($allUsers | Select-Object OU -Unique))
{
    New-ADOrganizationalUnit -Name $ou.OU -Path $userOU.DistinguishedName
}

# Create Users from CSV-file
Foreach($user in ($allUsers))
{
    $SAM = $user.FirstName + "." + $user.LastName
    $UPN = $SAM
    $password = ConvertTo-SecureString $user.Password -AsPlainText -Force
    $Name = $user.FirstName + " " + $user.LastName
    $location = Get-ADOrganizationalUnit -Filter "Name -eq '$($user.OU)'"

    New-ADUser `        -SamAccountName $SAM -UserPrincipalName $UPN `        -AccountPassword $password -Enabled $true `        -GivenName $user.FirstName -Surname $user.LastName `        -DisplayName $Name -Name $Name `        -Path $location.DistinguishedName
}

