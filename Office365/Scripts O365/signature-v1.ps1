# https://4sysops.com/archives/add-a-signature-to-office-365-emails-with-powershell/

#set folder location for files, the folder must already exist
$save_location = 'c:\tmp'
md $save_location
$email_domain = '@ThomasMoreStudent29.onmicrosoft.com'

#Get a list of all the filenames in the target folder
$sig_files = Get-ChildItem -Path $save_location

#Now push the html to the users signature
foreach ($item in $sig_files) {

  $user_name = $($item.Basename) + $email_domain
  $filename = $save_location + $($item.Basename) + ".htm"

  Write-Host "Now attempting to set signature for " $user_name
  set-mailboxmessageconfiguration -identity $user_name -signaturehtml (get-content $filename) -autoaddsignature $true 
}

#disconnect O365 connection
get-PSSession | remove-PSSession