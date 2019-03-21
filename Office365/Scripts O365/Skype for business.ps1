# connecting
$session3 = New-CsOnlineSession -Credential $credential

Import-PSSession $session3

# testing
Get-CsTenant


# close session
Remove-PSSession $session3