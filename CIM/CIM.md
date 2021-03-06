# WMI
## Basic information

Show system type, manufacturer and model of your PC. (Win32_ComputerSystem) Show al installed hotfixes. (Win32_QuickFixEngineering).


[Solution](Solutions/Basic_information_1.ps1)
## Desktop

Look into the Win32_Desktop class. Show the following properties: Name, IconTitleFaceName, ScreenSaverActive, ScreenSaverExecutable, Wallpaper.


[Solution](Solutions/Desktop_1.ps1)
## Desktop – v2

The command “Get-CimInstance Win32_Desktop” gives information of all desktops, whether they are in use or not. A lot of properties show metadata for WMI classes. Those properties start with __. Show for al desktops the regular properties with their values.

[Solution](Solutions/Desktop_–_v2_1.ps1)
## System drives

Get-CimInstance –class Win32_LogicalDisk gives an overview of all disks in a pc. Regular drives, DVD and USB-drives al appear in this list.

Show drive, volumename and the percentage of free space on every partition of the hard drive. Make sure it looks like the following list:

![Screenshot](ex-images/image7.png)


[Solution](Solutions/System_drives_1.ps1)


## Up and running

In the Win32_OperatingSystem-class there is a property that shows when the computer last booted. Use this to show for the current computer how long it has been running.

For example:

![Screenshot](ex-images/image8.png)

[Solution](Solutions/Up_and_running_1.ps1)
## Powerplan

Use Win32_PowerPlan in root\cimv2\power to change the power scheme of your computer.


[Solution](Solutions/Powerplan_1.ps1)
## Invoking methods

Use WMI to get the class for a notepad-process. Stop the process.

Then create a new instance of that class, and start it.


[Solution](Solutions/Invoking_methods_1.ps1)

## Change run-as account for a service

You can't change the run-as-account for a service using normal cmdlets. You can however change it using CIM.

First lookup a script that kind of does what you need it, then adapt it.

[Solution](Solutions/Change_service_account.ps1)