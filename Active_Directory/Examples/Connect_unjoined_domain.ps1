# run with windowsKey-R, doesn't work in ISE
runas /netonly /User:Niels@local.powershell.tm "mmc %Systemroot%\system32\dsa.msc"

# params
$serverIP = "10.145.6.35"
$domainName = "DC=local,dc=powershell,dc=tm"
$domainUser = "PS\Niels"

Get-NetAdapter

Set-DnsClientServerAddress -InterfaceIndex "..." -ServerAddresses $serverIP

ping local.powershell.tm

$cred = Get-Credential $domainUser

New-PSDrive -Name AD -PSProvider ActiveDirectory `
    -Root $domainName -server $serverIP -Credential $cred

Set-Location AD:

# to test...
New-ADUser 