$file = "c:\tmp\dns-address.xml"

#region set to 8.8.8.8

Get-DnsClientServerAddress -InterfaceAlias "Wi-Fi" -AddressFamily IPv4 |
    Select-Object InterfaceIndex, ServerAddresses |
    Export-Clixml -Path $file

Set-DnsClientServerAddress -InterfaceAlias "Wi-Fi" -ServerAddresses "8.8.8.8"

#endregion

#region Revert

$obj = Import-Clixml -Path $file

Set-DnsClientServerAddress -InterfaceIndex $obj.InterfaceIndex -ServerAddresses $obj.ServerAddresses
# problem: dynamic DNS is now static. Not good.
Set-DnsClientServerAddress -InterfaceIndex $obj.InterfaceIndex -ResetServerAddresses

#endregion

