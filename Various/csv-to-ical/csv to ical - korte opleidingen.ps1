$csvPath = 'C:\Tmp\Korte opleidingen 2018-2019 Versie 4.csv'
# $outPath = 'c:\tmp\systeembeheerder ICS.ics'
$csvData = Get-Content -Path $csvPath | Select-Object -Skip 2 | ConvertFrom-Csv -Delimiter ";"

$Groepen = $csvData | Group-Object Docent | Where-Object Name -like "?*"

$Groepen[1].Group

$groepen = $Groepen | Where-Object Name -eq "JM"

foreach($groep in $Groepen)
{
    $outPath = "c:\tmp\Lessenrooster $($groep.Name).ics"
    Set-Content -Path $outPath -Value "BEGIN:VCALENDAR"
    foreach($les in $groep.Group)
    {
        Add-Content -Path $outPath -Value "BEGIN:VEVENT"
        Add-Content -Path $outPath -Value ("SUMMARY:Cevora: " + $les.Opleiding)

        $van = Get-Date ($les.Datum + " 9:00")
        $tot = Get-Date ($les.Datum + " 16:30")

        Add-Content -Path $outPath -Value ("DTSTART;VALUE=DATE-TIME:" + $van.ToString("yyyyMMddTHHmmss"))
        Add-Content -Path $outPath -Value ("DTEND;VALUE=DATE-TIME:" + $tot.ToString("yyyyMMddTHHmmss"))
        Add-Content -Path $outPath -Value ("LOCATION:" + $les.Lokaal)

        Add-Content -Path $outPath -Value "END:VEVENT"

    }
    Add-Content -Path $outPath -Value "END:VCALENDAR"

}