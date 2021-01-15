#create scheduled job, run every half hour
#region create
$jt = New-JobTrigger -Once -At (get-date).Date -RepetitionInterval (New-TimeSpan -Minutes 30) -RepetitionDuration ([TimeSpan]::MaxValue)
$opt = New-ScheduledJobOption -StartIfOnBattery
Register-ScheduledJob -Name "create backup" -ScriptBlock {
    $file = "C:\tmp\puntenlijst Python november 2020 versie 16 november.xlsx"
    $dest = "c:\tmp\"

    $filename = (get-date -format "yyyy-MM-dd HH-mm") + " kopie" + (Get-Item $file).Extension

    Copy-Item -Path $file -Destination (Join-Path $dest $filename)
} -Trigger $jt -ScheduledJobOption $opt
#endregion

#region check results
Get-ScheduledJob
Get-Job
#endregion