$location = "c:\tmp\Backup.vhdx"

New-VHD -Path $location -SizeBytes 512GB -Dynamic
Mount-VHD -Path $location
$disk = Get-Disk -FriendlyName "*Virtual Disk*" | Where-Object PartitionStyle -eq "RAW"
$disk | Initialize-Disk -PartitionStyle GPT
$partition = $disk | New-Partition -AssignDriveLetter -UseMaximumSize
$partition | Format-Volume -FileSystem NTFS -NewFileSystemLabel "Backup" -Confirm:$false

# or...

New-VHD -Path $location -SizeBytes 512GB -Dynamic |
    Mount-VHD -Passthru |
    Initialize-Disk -PassThru -PartitionStyle GPT |
    New-Partition -AssignDriveLetter -UseMaximumSize |
    Format-Volume -FileSystem exFAT -Confirm:$false -Force