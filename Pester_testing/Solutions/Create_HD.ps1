# Filesystem/Solutions/Creating_and_formatting_a_drive_1.ps1

$vhd_file = "c:\tmp\temp_drive.vhdx"

New-VHD -Path $vhd_file -SizeBytes 5gb -Dynamic
Mount-VHD -Path $vhd_file
$disk = Get-Disk -FriendlyName "*Virtual Disk*" | Where-Object PartitionStyle -eq "RAW"
$disk | Initialize-Disk -PartitionStyle GPT
$partition = $disk | New-Partition -AssignDriveLetter -UseMaximumSize
$partition | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Backup" -Confirm:$false