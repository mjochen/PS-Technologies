# https://www.thomasmaurer.ch/2018/07/create-a-usb-drive-for-windows-server-2019-installation/

# Define Path to the Windows Server 2019 ISO
$ISOFile = "F:\OneDrive\OneDrive - Thomas More\_Data\ISO\Windows 10\20190326 Windows 10 en.iso"
 
# Get the USB Drive you want to use, copy the friendly name
Get-Disk | Where BusType -eq "USB"
 
# Get the right USB Drive (You will need to change the FriendlyName)
$USBDrive = Get-Disk | Where FriendlyName -like "Kingston*"
 
# Replace the Friendly Name to clean the USB Drive (THIS WILL REMOVE EVERYTHING)
$USBDrive | Clear-Disk -RemoveData -Confirm:$true -PassThru -RemoveOEM

# https://forum-en.msi.com/index.php?topic=163500.0
# "Convert GPT" (of mbr) in diskpart, via PS lukt het niet...
 
# Convert Disk to GPT
$USBDrive | Initialize-Disk -PartitionStyle GPT
# or $USBDrive | Initialize-Disk -PartitionStyle MBR
 
# Create partition primary and format to FAT32
$Volume = $USBDrive | New-Partition -UseMaximumSize -AssignDriveLetter | Format-Volume -FileSystem FAT32 -NewFileSystemLabel WIN10
 
# Mount iso
$ISOMounted = Mount-DiskImage -ImagePath $ISOFile -StorageType ISO -PassThru
 
# Driver letter
$ISODriveLetter = ($ISOMounted | Get-Volume).DriveLetter
 
# Copy Files to USB (except install.wim)
Copy-Item -Path ($ISODriveLetter +":\*") -Destination ($Volume.DriveLetter + ":\") -Recurse
 
# Dismount ISO
Dismount-DiskImage -ImagePath $ISOFile