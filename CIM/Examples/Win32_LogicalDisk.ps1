cls

$strComputer = "."

Get-CimInstance -ClassName Win32_LogicalDisk -computername $strComputer|
Format-Table DeviceID, @{Label="Vrije Ruimte in GB"; `
expression={$_.freespace/1GB};Alignment="right";Formatstring="N0"} –AutoSize
