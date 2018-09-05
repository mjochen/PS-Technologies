#region Lees bestand, maak CSV

$namen = Get-Content C:\tmp\eiland.txt | Where-Object { $_ -like " *" }

$lijst = @()

foreach($naam in $namen)
{
    $exp = New-Object PSCustomObject
    $naam = $naam.Trim()

    $exp | Add-Member -MemberType NoteProperty -Name Voornaam -Value $naam.SubString(0,$naam.IndexOf(" "))
    $exp | Add-Member -MemberType NoteProperty -Name Achternaam -Value $naam.SubString($naam.IndexOf(" ")+1)
    $exp | Add-Member -MemberType NoteProperty -Name Paswoord -Value (-join ((65..90) + (97..122) | Get-Random -Count 5 | ForEach-Object { [char]$_ }))

    $lijst += $exp
}

$lijst | Export-Csv -Path c:\tmp\heteiland.csv -Delimiter ";"

#endregion

#region Maak users aan



#endregion