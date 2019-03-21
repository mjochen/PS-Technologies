# connecting
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

$session2 = New-PSSession -ConfigurationName Microsoft.Exchange `
    -ConnectionUri $securityComplianceUrl `    -Credential $credential `
    -Authentication Basic -AllowRedirection

Import-PSSession $session2

# testing
Get-HoldCompliancePolicy

# close session
Remove-PSSession $session2