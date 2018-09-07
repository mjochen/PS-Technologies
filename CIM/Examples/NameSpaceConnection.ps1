Get-CimInstance -Namespace "root\securitycenter2" -classname antispywareproduct
Get-CimInstance -Namespace "root\securitycenter2" -classname antispywareproduct -ComputerName "."
Get-CimInstance -Namespace "root\cimv2" -ComputerName "." -classname Win32_Service -Filter "Name='DnsCache'"
