$now = Get-Date
$booted = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
$up = $now - $booted
$pc = (Get-CimInstance Win32_OperatingSystem).CSName
write-host "$pc is $($up.days) days, $($up.hours) hours and $($up.Minutes) minutes up and running"