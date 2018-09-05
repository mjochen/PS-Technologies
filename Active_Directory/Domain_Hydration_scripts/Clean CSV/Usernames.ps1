#region import

$path = "C:\Scripts\Usernames.csv"

$allUsers = Import-Csv $path -Delimiter ";" -Encoding UTF7

$allUsers | Select-Object -First 5

#endregion

#region group creation

foreach($group in ($allUsers | Select-Object -Unique Departement) )
{
    Write-Host ("OU: " + $group.Departement)

}


#endregion

#region user creation

foreach($user in $allUsers)
{
    $fn = $user.Voornaam
    $ln = $user.Achternaam
    $name = $fn + " " + $ln
    $logonname = $name.Replace(" ",".")
    $ou = $user.Departement
    $groups = $user.Groepen.Split(",")

    Write-Host $fn
    Write-Host $ln
    Write-Host $name
    Write-Host $logonname
    Write-Host $ou

    foreach($group in $groups)
    {
        Write-Host $group
    }
}

#endregion