# set up honeypot, collect IP's
New-Item -Path "c:\SharedFolder\" -ItemType Directory
New-SmbShare -Path c:\SharedFolder -FullAccess Everyone -Name "Really cool share" -Description "Not a honeypot at all"

New-Item -Path C:\SharedFolder\TheAnswerToLive.txt -ItemType File -Value "42"

$allIPs = Get-SmbOpenFile | Select-Object -Unique -ExpandProperty ClientComputerName 

#create the tagging-file
# connecting to an IP: trustedhosts has to allow it, and a credential is required
$cred = Get-Credential
Set-Item wsman:\localhost\client\trustedhosts * -Force
Invoke-Command -ComputerName $allIPs -Credential $cred -ScriptBlock {
    New-Item -Path c:\Message\PS00.txt -ItemType file -Value "From me to you!" -force }