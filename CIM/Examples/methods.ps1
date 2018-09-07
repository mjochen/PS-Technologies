notepad

$y = Get-WmiObject -Query 'Select * from Win32_Process where name like "notepad%"'
$y | Get-Member -MemberType Methods
# show all methods...

$y.GetOwner()

$x = Get-CimInstance -Query 'Select * from Win32_Process where name like "notepad%"'
$x | Get-Member -MemberType Methods
# will show only default methods, not class-specific

(Get-CimClass -ClassName Win32_Process).CimClassMethods
# shows all methods. To invoke, use "invoke-cimmethod"

Invoke-CimMethod -InputObject $x -MethodName GetOwner

# in the end, you get the same functionality, but CIM 'hides' the methods
# You should still use CIM though, since WMI is considered deprecated

# by the way, notice "Reboot()"
$pc = Get-WmiObject -Namespace "root\cimv2" -ComputerName "." -classname Win32_OperatingSystem
$pc | Get-Member -MemberType Methods

