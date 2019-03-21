# connecting
Connect-MsolService -Credential $credential

# test connection
Get-MsolUser

# disconnecting
# Disconnection isn’t required
# Closing the console will disconnect the credentials
