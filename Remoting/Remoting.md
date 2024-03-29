# Remoting
## Get info

Find out what the name of a machine with a certain IP address is. Also find out what the OS is, and whether it's 32 or 64 bit.

[Solution](Solutions/Get_info_1.ps1)

## Tagging

Create a CSV-files with all IP-adresses of the computers in the room.

Get the names of all computers in this room. On all of those PC's a folder "C:\Message" is created if it doesn't exist yet.

Create a file "PSxx" (with xx being your tablenumber) with the following content:

> From: 		Your last and first name
>
> Message:	A message for the owner of the PC.

[Solution](Solutions/Tagging_1.ps1)

## Check connections

Your PC is approached remotely. You can only see this of you look at the list of running processes.

Using a script show the name of the process that is started if someone contacts your PC.

[Solution](Solutions/Check_connections_1.ps1)

## Linux remoting

Since PowerShell core remoting to linux-systems is also possible. Try to set it up!

[Solution](Solutions/Remoting_to_ubuntu.ps1)