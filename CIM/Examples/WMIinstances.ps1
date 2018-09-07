cls

Get-Command -Noun WMI*
Get-Command -Noun CIM*

Get-CimInstance -Classname Win32_Service |Format-Table DisplayName, State, StartMode -AutoSize

Get-CimInstance -classname Win32_TapeDrive |Format-Table DeviceID -AutoSize

Get-CimInstance -ClassName Win32_ComputerSystem
Get-CimInstance -ClassName Win32_OperatingSystem
