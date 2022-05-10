﻿#region feature installation
Get-WindowsFeature

Install-WindowsFeature -Name "DHCP", "DNS" -IncludeManagementTools -IncludeAllSubFeature
Install-WindowsFeature -Name "AD-Domain-Services" -IncludeManagementTools -IncludeAllSubFeature

#endregion

#region DHCP scope create
Get-Module -ListAvailable

Get-Command -Module "DhcpServer"

Add-DhcpServerv4Scope -StartRange 172.20.0.1 -EndRange 172.20.255.254 `
                            -Name "My scope" -SubnetMask 255.255.0.0
#endregion

#region AD installation

Get-Module -Name "*ADDS*" -ListAvailable

$R123 = ConvertTo-SecureString -String "R1234-56" -AsPlainText -Force

Install-ADDSForest `