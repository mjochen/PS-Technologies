# All credentials

$user = "ThomasMoreStudent29"
$email = "admin@ThomasMoreStudent29.onmicrosoft.com"
$domain = "ThomasMoreStudent29.onmicrosoft.com"
$sharepointUrl = "https://ThomasMoreStudent29-admin.sharepoint.com" # notice '-admin' in the url
$exchangeUrl = "https://outlook.office365.com/powershell-liveid/"
$securityComplianceUrl = "https://ps.compliance.protection.outlook.com/powershell-liveid/"

Set-Location "C:\_PowerShell\Scripts O365"

# read-host -assecurestring | convertfrom-securestring | out-file passwordO365.txt

$password = cat passwordO365.txt | ConvertTo-SecureString

$credential = new-object -typename System.Management.Automation.PSCredential -argumentlist $email, $password

Get-Credential | Get-Member