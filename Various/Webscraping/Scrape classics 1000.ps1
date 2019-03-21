$uri = "https://playground.radio1.be/c1000/2017/"
 
$ie = New-Object -comobject InternetExplorer.Application
$ie.Visible = $true
 
$ie.Navigate2($uri)
 
while($ie.ReadyState -ne 4) {start-sleep -m 100} 
 
$table = $ie.document.body.getElementsByTagName('table')[0]

$list = @()

Foreach($row in $table.rows)
{
    $nr = $row.cells[0].innerText
    $nummer = $row.cells[1].innerText

    $nummerNaam = $nummer.Substring(0,$nummer.IndexOf("-")).trim()
    $groepNaam = $nummer.Substring($nummer.IndexOf("-")).trim("-"," ")

    $list += [PSCustomObject] @{ positie=$nr ; nummer=$nummerNaam ; groep=$groepNaam }
}

$list | Export-Csv Classic1000-2017.CSV -Delimiter ";"
