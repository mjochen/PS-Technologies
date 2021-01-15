$Task = Get-ScheduledTask -TaskName "Animal_fact"

$Task.Triggers.Repetition.StopAtDurationEnd = "False"
$Task.Triggers.Repetition.Interval = "PT10M"

$Task | Set-ScheduledTask