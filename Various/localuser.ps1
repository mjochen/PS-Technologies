Remove-LocalUser usr3

New-LocalUser -FullName infodag -Password (ConvertTo-SecureString "R1234-56" -AsPlainText -Force) -AccountNeverExpires -PasswordNeverExpires -UserMayNotChangePassword

# as admin...
Get-LocalUser "Morgan*", "Wesley" | Disable-LocalUser