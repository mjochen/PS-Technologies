# connecting
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

$session = New-PSSession -ConfigurationName Microsoft.Exchange `
    -ConnectionUri $exchangeUrl `    -Credential $credential `
    -Authentication Basic -AllowRedirection

Import-PSSession $session

# testing
Get-Mailbox

# close session
Remove-PSSession $session
