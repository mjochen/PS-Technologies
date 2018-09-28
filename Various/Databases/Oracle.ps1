$pathCSV = "C:\scripts\lego-database"
$hostname = "..."
$username = "Lego"
$password = "..."

#region functions


function toNumber ([String] $t)
{
    $nr = $t.trim().Trim("'","$","€").Trim()
    $nr = $nr.Replace(".",",")

    $outNr = 0

    if([Double]::TryParse($nr,[ref]$outNr))
    {
        return $outNr
    }
    else
    {
        RETURN "NULL"
    }
    
}

function toNull ([String] $t)
{
    if($t.Length -eq 0 -or $t -eq "NULL")
    {
        RETURN "NULL"
    }
    else
    {
        RETURN "'$($t.trim("'"))'"
    }
    
}

function escape ([String] $t)
{
    $t = $t.Replace("'","''")
    $t = $t.Trim().Trim('"')

    return $t
    
}

#endregion

#region uris

# https://osric.com/chris/accidental-developer/2016/03/querying-an-oracle-database-from-powershell/
# http://community.idera.com/powershell/ask_the_experts/f/sql_server__sharepoint-9/5709/query-oracle-database-with-powershell

#endregion

#region connection

[System.Reflection.Assembly]::LoadWithPartialName("System.Data.OracleClient")

$connectionString = "Data Source=(DESCRIPTION=(ADDRESS_LIST=(ADDRESS=(PROTOCOL=TCP)(Host=$hostname)(Port=1521)))(CONNECT_DATA=(SID=xe)));User ID=$username;Password=$password"

$connection = New-Object System.Data.OracleClient.OracleConnection($connectionString)

$connection.Open()

$command = new-Object System.Data.OracleClient.OracleCommand($queryString, $connection)

#endregion

#region testing

$queryString = "SELECT * FROM Lego.Thema"

$command.CommandText = $queryString

$employeesNames = $command.ExecuteReader()

while($employeesNames.Read())
{
    $employeesNames.GetString(0)
}

write-host "Number of employees: "

$employeesNames | get-member

$employeesNames.GetInt32(0)



$queryString = "INSERT INTO theme (themeID, Name, parentID) VALUES (1, 'Technic',NULL)"

$qs2 = "INSERT INTO theme (themeID, Name, parentID) VALUES (2, 'Arctic Technic',1)"

$command = new-Object System.Data.OracleClient.OracleCommand($queryString, $connection)

$command.CommandText = $qs2

$command.ExecuteNonQuery()

write-host "Number of employees: "$employeesNames

#endregion

#region themes

$csv = "themes.csv"

$allData = Import-Csv -path (Join-Path $pathCSV $csv)

$command = new-Object System.Data.OracleClient.OracleCommand("Select * from thema;", $connection)

foreach($theme in $allData) # | select-object -First 10 -skip 2))
{
    $queryString = "INSERT INTO thema (themaID, naam, hoofdthemaID) VALUES ($($theme.id),'$($theme.name)',$(toNull($theme.parent_id)))"

    $queryString

    $command.CommandText = $queryString
    $command.ExecuteNonQuery()

}

#endregion

