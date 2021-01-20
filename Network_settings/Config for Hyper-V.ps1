#region VMs en switch

# Get-Module -Name VMWare* | Remove-Module -force
Import-Module Hyper-V

Get-VM | ft vmname

Get-VMSwitch
New-VMSwitch -Name "10.0.0.0" -SwitchType Internal

Get-VM | Get-VMNetworkAdapter | Connect-VMNetworkAdapter -SwitchName "10.0.0.0"
#endregion

#region IP-settings

$cred = Get-Credential Administrator # R1234-56

Enter-PSSession -VMName "MS01" -Credential $cred

Get-netadapter
New-NetIPAddress -InterfaceIndex 4 -IPAddress 10.0.0.2 -PrefixLength 16 -DefaultGateway 10.0.0.1
Set-DnsClientServerAddress -InterfaceIndex 4 -ServerAddresses 10.0.0.2,10.0.0.17

Exit-PSSession
Enter-PSSession -VMName "MS02" -Credential $cred

Get-netadapter
New-NetIPAddress -InterfaceIndex 8 -IPAddress 10.0.0.3 -PrefixLength 16 -DefaultGateway 10.0.0.1
Set-DnsClientServerAddress -InterfaceIndex 8 -ServerAddresses 10.0.0.2,10.0.0.17

Exit-PSSession

# host!
# if previous static config exists
Get-NetAdapter -Name *10.0.0.0* | Remove-NetIPAddress -Confirm:$False 

Get-NetAdapter -Name *10.0.0.0* | New-NetIPAddress -IPAddress 10.0.0.4 -PrefixLength 16 -DefaultGateway 10.0.0.1
Get-NetAdapter -Name *10.0.0.0* | Set-DnsClientServerAddress -ServerAddresses 10.0.0.2,10.0.0.17
# because we didn't want a default gateway on the host
Get-NetAdapter -Name *10.0.0.0* | Remove-NetRoute -Confirm:$False 

#endregion

#region test

Ping 10.0.0.4 # no, windows firewall
Test-NetConnection -ComputerName 10.0.0.2 -CommonTCPPort WINRM

#endregion

