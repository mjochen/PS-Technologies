#region install FTP-server

# https://4sysops.com/archives/install-and-configure-an-ftp-server-with-powershell/

# Install the Windows feature for FTP
Install-WindowsFeature Web-FTP-Server -IncludeAllSubFeature
Install-WindowsFeature Web-Server -IncludeAllSubFeature  -IncludeManagementTools

# Import the module
Import-Module WebAdministration

# Create the FTP site
$FTPSiteName = 'Default FTP Site'
$FTPRootDir = 'C:\FTPRoot'
md $FTPRootDir
$FTPPort = 21
New-WebFtpSite -Name $FTPSiteName -Port $FTPPort -PhysicalPath $FTPRootDir

Get-childitem 

Set-ItemProperty 'IIS:\Sites\Default FTP Site' -Name ftpServer.security.ssl.controlChannelPolicy -Value 0
Set-ItemProperty 'IIS:\Sites\Default FTP Site' -Name ftpServer.security.ssl.dataChannelPolicy -Value 0

<# In GUI
- FTP Authentication: enable basic
- FTP AUthorization rules: Allow all users read and write
#>

#endregion

#region install module

# https://gallery.technet.microsoft.com/scriptcenter/PowerShell-FTP-Client-db6fe0cb

#download
#unzip
#move to %USERPROFILE%\Documents\WindowsPowerShell\Modules

Import-Module PSFTP 

Get-Command -Module PSFTP

#endregion

#region access FTP

$cred = Get-Credential

Get-help Set-FTPConnection -full

Set-FTPConnection -Credentials $cred -Server ftp://localhost -Session MyTestSession -UsePassive 
$Session = Get-FTPConnection -Session MyTestSession 
 
New-FTPItem -Session $Session -Name TestRootDir 
New-FTPItem -Session $Session -Name TestDir1 -Path /TestRootDir 
New-FTPItem -Session $Session -Name TestDir2 -Path /TestRootDir 
New-FTPItem -Session $Session -Name TestDir11 -Path /TestRootDir/TestDir1 

Get-FTPChildItem -Session $Session -Path /TestRootDir -Recurse -Depth 2 
 
Get-Process | Out-File MyProcesses.txt 
Get-ChildItem MyProcesses.txt | Add-FTPItem -Session $Session -Path /TestRootDir 
Get-ChildItem MyProcesses.txt | Add-FTPItem -Session $Session -Path /TestRootDir -Overwrite 
Get-ChildItem MyProcesses.txt | Add-FTPItem -Session $Session -Path /TestRootDir/TestDir1  
Get-ChildItem MyProcesses.txt | Add-FTPItem -Session $Session -Path /TestRootDir/TestDir2 -BufferSize 5 
Add-FTPItem -Session $Session -Path /TestRootDir/TestDir1/TestDir11 -LocalPath MyProcesses.txt 

#endregion

