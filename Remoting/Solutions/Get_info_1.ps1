$theIP = "10.145.6.59"

New-PSSession -ComputerName $theIp -Credential $cred
Enter-PSSession -Id 27

$env:PROCESSOR_ARCHITECTURE
$env:OS
[environment]::OSVersion.Version
[environment]::OSVersion.VersionString
$env:COMPUTERNAME

Exit-PSSession
