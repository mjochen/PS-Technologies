# checking installation

# Office 365:
# - Sign-In assistant
# - Azure AD module

Install-Module MSOnline
Install-Module AzureAD

Get-Module -ListAvailable | Where-Object Name -Like "*MSOnline*"

Get-Module -ListAvailable | Where-Object Name -Like "MSOnline" | Import-Module
Get-Command -Module MSOnline*

# Skype for business

Get-Module  -ListAvailable | Where-Object Name -Like "*OnlineConnector"
Import-Module SkypeOnlineConnector

Get-Command -Module Skype*


# Sharepoint online

Get-Module -ListAvailable | Where-Object Name -Like "*sharepoint*"
Import-Module Microsoft.online.sharepoint.powershell -DisableNameChecking

Get-Command -Module Microsoft.online.sharepoint.powershell