#region Groepen in AD

$ou = Get-ADOrganizationalUnit -Filter { Name -eq "Groups" }

foreach($g in ("Gemakkelijk","Gemiddeld","Moeilijk") )
{
    New-ADGroup -Name "DL_$g" -GroupCategory Security `
                -GroupScope Global -Path $ou.DistinguishedName
}
#endregion

#region FGPP's
New-ADFineGrainedPasswordPolicy -Name "Gemakkelijk" -Precedence 100 `                -ComplexityEnabled $false -MinPasswordLength 2 `
                -ReversibleEncryptionEnabled $true

New-ADFineGrainedPasswordPolicy -Name "Gemiddeld" -Precedence 20 `                -ComplexityEnabled $false -MinPasswordLength 4 `
                -ReversibleEncryptionEnabled $true

New-ADFineGrainedPasswordPolicy -Name "Moeilijk" -Precedence 10 `                -ComplexityEnabled $false -MinPasswordLength 6 `
                -ReversibleEncryptionEnabled $true

#endregion

#region koppelen aan elkaar

# pasword policy -> DL-Groep

foreach($g in ("Gemakkelijk","Gemiddeld","Moeilijk") )
{
    Add-ADFineGrainedPasswordPolicySubject -Identity "$g" `
            -Subjects "DL_$g"
}

# DL-Groep -> G-Groep

Add-ADGroupMember -Identity "DL_Gemakkelijk" `
    -Members "Actor", "Writer"

Add-ADGroupMember -Identity "DL_Gemiddeld" `
    -Members "Director"

Add-ADGroupMember -Identity "DL_Moeilijk" `
    -Members "Domain Admins"

#endregion

#region testen

Get-ADUser -Filter { Name -eq "Jim Carrey" } |
    Get-ADUserResultantPasswordPolicy

Get-ADUser -Filter { Name -eq "Quentin Tarantino" } |
    Get-ADUserResultantPasswordPolicy

Get-ADUser -Filter { Name -eq "Vinny Diesel" } |
    Get-ADUserResultantPasswordPolicy


#endregion