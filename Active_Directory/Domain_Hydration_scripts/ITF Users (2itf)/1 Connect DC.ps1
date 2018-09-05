$ip = "172.20.0.2"
#$cred = Get-Credential CD\Admin
$cred = Get-Credential CD\Administrator
#$cred | Export-Clixml "C:\_Vakken\Powershell\Technologies\AD\Manage local domain\Admin-R1234-56.xml"
$cred = Import-Clixml "C:\_Vakken\Powershell\Technologies\AD\Manage local domain\Admin-R1234-56.xml"

$dc = New-PSSession -ComputerName $ip -Credential $cred
Enter-PSSession $dc

Exit-PSSession

# FS
$ipFS = "172.20.1.2"

$fs = New-PSSession -ComputerName $ipFS -Credential $cred
Enter-PSSession $fs