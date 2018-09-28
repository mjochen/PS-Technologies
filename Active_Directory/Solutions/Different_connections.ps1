$csv = "c:\tmp\users.csv"

#region Create CSV

$acme = Get-ADOrganizationalUnit -Filter { Name -like "Acme" }

$users = Get-ADUser -Filter { Name -like "A*" } -SearchBase $acme.DistinguishedName |
    Select-Object DistinguishedName
    
$users | ForEach-Object { $_ | Add-Member -MemberType NoteProperty -Name "Server" -Value (Get-Random -Minimum 1 -Maximum 3 ) }
    
$users | Export-Csv $csv -Delimiter ";"

#endregion

#region Create PSDrives

$server = (Get-ADDomainController).Hostname
$cred = Get-Credential PS\Admin
$domainRoot = (Get-ADDomain).DistinguishedName

New-PSDrive -PSProvider ActiveDirectory -name connect1 -Server $server `
												-root $domainRoot -Credential $cred

New-PSDrive -PSProvider ActiveDirectory -name connect2 -Server $server `
												-root $domainRoot -Credential $cred
#endregion

#region setUserProperty

$users = Import-Csv $csv -Delimiter ";" | Where-Object server -eq 1

Set-Location "connect1:"

foreach($user in $users)
{
    Set-ADUser -Identity $user.DistinguishedName -City "Madrid"
}

$users = Import-Csv $csv -Delimiter ";" | Where-Object server -eq 2

Set-Location "connect2:"

foreach($user in $users)
{
    Set-ADUser -Identity $user.DistinguishedName -City "Berlin"
}

#endregion
