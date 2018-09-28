Import-Module PSNeo4j
$ip = "..."

$Password = ConvertTo-SecureString -String "neo4j" -AsPlainText -Force
$Cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList neo4j, $password
Set-PSNeo4jConfiguration -BaseUri $ip -Credential $Cred

#https://glennsarti.github.io/blog/using-neo4j-dotnet-client-in-ps/

#region installation

<#
Install-PackageProvider nuget
Get-PackageSource
Get-package "*Neo*"
Install-Package Neo4j.Driver -verbose

Install-PackageProvider nuget

Install-Package Neo4j.Driver -Version 1.5.2 



Find-Package "zoomit"
Find-Package "*" -Source chocolatey
#>

Install-Module PSNeo4j

#endregion

#region connect

$Password = ConvertTo-SecureString -String "neo4j" -AsPlainText -Force
$neoCred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList neo4j, $password
Set-PSNeo4jConfiguration -Credential $Cred -BaseUri "http://$ip:7474"

Get-Neo4jUser



#endregion

#region test
Get-Command -Module psNeo4j

$services = Get-Service

$services | Select-Object -First 1 | fl *

foreach($service in $services)
{
    [pscustomobject]@{
    name = $service.Name
    displayName = $service.DisplayName
    } | New-Neo4jNode -Label Service -Passthru
}

#endregion

#region ad

#users
$users = Get-ADUser -Filter * -SearchBase ("ou=Acme," + (Get-ADDomain).DistinguishedName)

foreach($user in $users)
{
    [pscustomobject]@{
    name = $user.Name
    displayName = $user.DisplayName
    DistinguishedName=$user.DistinguishedName
    } | New-Neo4jNode -Label User -Passthru
}

# groups
$groups = Get-ADGroup -Filter *

foreach($group in $groups)
{
    [pscustomobject]@{
    name = $group.Name
    DistinguishedName = $group.DistinguishedName
    } | New-Neo4jNode -Label $group.GroupScope -Passthru
}

# membership
$groups = Get-ADGroup -Filter * -Properties Members

foreach($group in $groups)
{
    foreach($member in $group.members)
    {        New-Neo4jRelationship `            -LeftQuery "MATCH (left { DistinguishedName : `"$($member)`" })" `
            -RightQuery "MATCH (right { DistinguishedName : `"$($group.distinguishedname)`" })" `
            -Type 'MemberOf' -passThru      
    }
}

#endregion