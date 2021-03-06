#===========================================================================
# Add events to Form Objects
#===========================================================================
$btnExit.Add_Click({
$Form.Close()
})

#===========================================================================
# Stores WMI values in WMI Object from Win32_Operating System Class
#===========================================================================
# $oWMIOS = Get-WmiObject -Class win32_OperatingSystem

$oWMIOS = Get-ComputerInfo

#===========================================================================
# Links WMI Object Values to XAML Form Fields
#===========================================================================
$txtHostName.Text = "MyComputerName" # $oWMIOS.CsDNSHostName

$txtOSName.Text = $oWMIOS.OsName

#Formats and displays available memory
$sAvailableMemory = [math]::round($oWMIOS.CsPhyicallyInstalledMemory*1KB/1MB,0)
$sAvailableMemory = "$sAvailableMemory MB"
$txtAvailableMemory.Text = $sAvailableMemory

#Displays OS Architecture
$txtOSArchitecture.Text = $oWMIOS.OSArchitecture

#Displays Windows Directory
$txtWindowsDirectory.Text = $oWMIOS.OsWindowsDirectory

#Displays Version
$txtWindowsVersion.Text = $oWMIOS.WindowsCurrentVersion

#Displays System Drive
$txtSystemDrive.Text = $oWMIOS.OsSystemDrive
