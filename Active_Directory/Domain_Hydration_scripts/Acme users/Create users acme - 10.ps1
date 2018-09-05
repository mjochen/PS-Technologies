$domein="DC=cursusdom,DC=local"

New-ADOrganizationalUnit -name "Acme" -path "$domein"
New-ADOrganizationalUnit -name "Users" -path "OU=Acme,$domein"

New-ADUser -name "Morgan Freeman" -Path "OU=Users,OU=Acme,$domein" -samAccountName "Morgan.Freeman" -AccountPassword (ConvertTo-securestring -Force -AsPlainText "R1234-56") -PasswordNeverExpires $true -Enabled $true
New-ADUser -name "Paz Vega" -Path "OU=Users,OU=Acme,$domein" -samAccountName "Paz.Vega" -AccountPassword (ConvertTo-securestring -Force -AsPlainText "R1234-56") -PasswordNeverExpires $true -Enabled $true
New-ADUser -name "Heath Ledger" -Path "OU=Users,OU=Acme,$domein" -samAccountName "Heath.Ledger" -AccountPassword (ConvertTo-securestring -Force -AsPlainText "R1234-56") -PasswordNeverExpires $true -Enabled $true
New-ADUser -name "Julia Stiles" -Path "OU=Users,OU=Acme,$domein" -samAccountName "Julia.Stiles" -AccountPassword (ConvertTo-securestring -Force -AsPlainText "R1234-56") -PasswordNeverExpires $true -Enabled $true
New-ADUser -name "Larisa Oleynik" -Path "OU=Users,OU=Acme,$domein" -samAccountName "Larisa.Oleynik" -AccountPassword (ConvertTo-securestring -Force -AsPlainText "R1234-56") -PasswordNeverExpires $true -Enabled $true
New-ADUser -name "Andrew Keegan" -Path "OU=Users,OU=Acme,$domein" -samAccountName "Andrew.Keegan" -AccountPassword (ConvertTo-securestring -Force -AsPlainText "R1234-56") -PasswordNeverExpires $true -Enabled $true
New-ADUser -name "Gabrielle Union" -Path "OU=Users,OU=Acme,$domein" -samAccountName "Gabrielle.Union" -AccountPassword (ConvertTo-securestring -Force -AsPlainText "R1234-56") -PasswordNeverExpires $true -Enabled $true
New-ADUser -name "Larry Miller" -Path "OU=Users,OU=Acme,$domein" -samAccountName "Larry.Miller" -AccountPassword (ConvertTo-securestring -Force -AsPlainText "R1234-56") -PasswordNeverExpires $true -Enabled $true
New-ADUser -name "Daryl Mitchell" -Path "OU=Users,OU=Acme,$domein" -samAccountName "Daryl.Mitchell" -AccountPassword (ConvertTo-securestring -Force -AsPlainText "R1234-56") -PasswordNeverExpires $true -Enabled $true
New-ADUser -name "Greg Jackson" -Path "OU=Users,OU=Acme,$domein" -samAccountName "Greg.Jackson" -AccountPassword (ConvertTo-securestring -Force -AsPlainText "R1234-56") -PasswordNeverExpires $true -Enabled $true
