$csvPath = 'C:\Scripts\Agenda.csv'
$outPath = 'c:\tmp\Agenda ICS.ics'

$csvData = Get-Content -Path $csvPath | ConvertFrom-Csv -Delimiter ";"

Set-Content -Path $outPath -Value "BEGIN:VCALENDAR"
foreach($les in $csvData)
{
    Add-Content -Path $outPath -Value "BEGIN:VEVENT"
    Add-Content -Path $outPath -Value ("SUMMARY:Project T&H: " + $les.activiteit)

    $van = Get-Date ($les.Datum_start + " " + $les.Startuur)
    $tot = Get-Date ($les.Datum_einde + " " + $les.einduur)

    Add-Content -Path $outPath -Value ("DTSTART;VALUE=DATE-TIME:" + $van.ToString("yyyyMMddTHHmmss"))
    Add-Content -Path $outPath -Value ("DTEND;VALUE=DATE-TIME:" + $tot.ToString("yyyyMMddTHHmmss"))
    Add-Content -Path $outPath -Value ("LOCATION:" + $les.Plaats)

    Add-Content -Path $outPath -Value "END:VEVENT"

}
Add-Content -Path $outPath -Value "END:VCALENDAR"
