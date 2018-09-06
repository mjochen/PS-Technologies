$csvPath = 'C:\Tmp\Lessenrooster Systeembeheerder 2017-2018-Versie 2018-01-12.csv'
$outPath = 'c:\tmp\systeembeheerder ICS.ics'
$csvData = Get-Content -Path $csvPath | Select-Object -Skip 1 | ConvertFrom-Csv -Delimiter ";"

#region per docent
$Groepen = $csvData | Group-Object Lesgever | Where-Object Name -like "?*"

foreach($groep in $Groepen)
{
    $outPath = "c:\tmp\Lessenrooster $($groep.Name).ics"
    Set-Content -Path $outPath -Value "BEGIN:VCALENDAR"
    foreach($les in $groep.Group)
    {
        Add-Content -Path $outPath -Value "BEGIN:VEVENT"
        Add-Content -Path $outPath -Value ("SUMMARY:Systeembeheerder: " + $les.Module)

        $van = Get-Date ($les.Datum + " " + $les.Van)
        $tot = Get-Date ($les.Datum + " " + $les.Tot)

        Add-Content -Path $outPath -Value ("DTSTART;VALUE=DATE-TIME:" + $van.ToString("yyyyMMddTHHmmss"))
        Add-Content -Path $outPath -Value ("DTEND;VALUE=DATE-TIME:" + $tot.ToString("yyyyMMddTHHmmss"))
        Add-Content -Path $outPath -Value ("LOCATION:" + $les.Lokaal)

        Add-Content -Path $outPath -Value "END:VEVENT"

    }
    Add-Content -Path $outPath -Value "END:VCALENDAR"
}
#endregion

#region hele groep

$csvData = $csvData | Where-Object Datum -gt (get-date)
$csvData = $csvData | Where-Object { $_.Module -notLike "*Vrij*" -and $_.Module -notlike "*Verwerking leerstof thuis*" }

$csvData | ft

Set-Content -Path $outPath -Value "BEGIN:VCALENDAR"

foreach($les in $csvData)
{
    Add-Content -Path $outPath -Value "BEGIN:VEVENT"
    Add-Content -Path $outPath -Value ("SUMMARY:Systeembeheerder: " + $les.Module)

    $van = Get-Date ($les.Datum + " " + $les.Van)
    $tot = Get-Date ($les.Datum + " " + $les.Tot)

    Add-Content -Path $outPath -Value ("DTSTART;VALUE=DATE-TIME:" + $van.ToString("yyyyMMddTHHmmss"))
    Add-Content -Path $outPath -Value ("DTEND;VALUE=DATE-TIME:" + $tot.ToString("yyyyMMddTHHmmss"))
    Add-Content -Path $outPath -Value ("LOCATION:" + $les.Lokaal)

    Add-Content -Path $outPath -Value "END:VEVENT"

}
Add-Content -Path $outPath -Value "END:VCALENDAR"

#endregion