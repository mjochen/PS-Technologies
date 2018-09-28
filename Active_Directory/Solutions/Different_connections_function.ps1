#region setUserProperty

function Do-StuffToUsers
{
    param(
    $userList,
    $connection,
    $city
    )

    if(-not $connection.Trim().EndsWith(":"))
    {
        $connection = $connection.Trim() + ":"
    }

    Set-Location $connection

    foreach($user in $userList)
    {
        Set-ADUser -Identity $user.DistinguishedName -City $city
    }

    return 0
}

$users = Import-Csv $csv -Delimiter ";" | Where-Object server -eq 1

Do-StuffToUsers -userList $users -connection connect1 -city Madrid # note: connection without ":"

$users = Import-Csv $csv -Delimiter ";" | Where-Object server -eq 2

Do-StuffToUsers -userList $users -connection connect2: -city Berlin # note: connection with ":"

#endregion