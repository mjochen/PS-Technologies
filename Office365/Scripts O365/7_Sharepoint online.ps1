# connecting
Connect-SPOService -Url $sharepointUrl -Credential $credential

# testing
Get-SPOSite

# disconnect
Disconnect-SPOService