# Get the service-instance

$service = Get-WmiObject -Query "SELECT * FROM Win32_Service WHERE name='certpropsvc'"
$service | Get-Member

# Content of a property
$service.StartMode 	#Possible is Boot, System, AUTO, Manual, Disabled (see WMI CIM Studio) 
$service.StartMode = "Disabled" # No error message

$service = Get-WmiObject -Query "SELECT * FROM Win32_Service WHERE name='certpropsvc'"
$service.StartMode
# but no change

# There is a method to set the startmode
$service.ChangeStartMode("Disabled") #Possible is Boot, System, AUTOMATIC, Manual, Disabled

# Changing a non read-only property
$drive = Get-WmiObject -Query "SELECT * FROM Win32_LogicalDisk WHERE name ='C:'"
$drive.VolumeName = "Schijf Karin"
$drive.Put()

<#
Change multiple properties at once with Set-WMIInstance.
Properties are passed as pairs (name=<value>) using a hash-table
We're adding an environment-variabel for a user.
#>

Set-WMIInstance -Class win32_Environment `
-Arguments  @{Name="testvar";VariableValue="testvalue";UserName="CURSUS01\Roger"} #Workgroup: pcname\username
                                                                                  #Domain: domainname\username
cls;Get-WmiObject Win32_Environment -Filter  "name='testvar'" 
Get-WmiObject Win32_Environment -Filter  "name='testvar'"  | Remove-WmiObject

