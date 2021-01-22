#region remoting

$credDom = Get-Credential local.cursusdom.tm\Administrator
$s = New-PSSession -ComputerName "172.20.0.2" -Credential $credDom

Invoke-Command -Session $s -ScriptBlock { md c:\scripts }
Copy-Item -Path "C:\...\Movie users (NB2)\Gebruikers.csv" -Destination "c:\Scripts\Gebruikers.csv" -ToSession $s

Enter-PSSession $s
#endregion

#region functies
function Get-UniekeLogin ($SAM)
{
    if(Get-ADUser -Filter { SAMAccountName -eq $SAM } )
    {
        $getal = 0
        if([Int]::TryParse($SAM.Substring($SAM.Length-2),[ref]$getal))
        {
            $nieuweSam = $SAM.Substring(0,$SAM.Length-2) + ($getal + 1).ToString("00")
        }
        else
        {
            $nieuweSam = $SAM + "01"

        }
        return Get-UniekeLogin $nieuweSam
    }
    else
    {
        Return $SAM
    }
}

function Get-AllesVoorSpatie ($tekst)
{
    if($tekst.Contains(" "))
    {
        return $tekst.Substring(0,$tekst.IndexOf(" "))
    }
    else
    {
        return $tekst
    }
}

function Remove-HtmlQuote ($tekst)
{
    return $tekst.Replace("&amp;#x27;","'").Replace("&#x27;","'").Replace(":","")
}

#endregion

#region Variabelen instellen
$bedrijfsNaam = "Acme"
$domein = Get-ADDomain
$csvPad = "C:\Scripts\Gebruikers.csv"

#endregion

#region OU's aanmaken en opslaan
New-ADOrganizationalUnit -Name $bedrijfsNaam -Path $domein.DistinguishedName
$hoofdOU = Get-ADOrganizationalUnit -Filter { Name -eq $bedrijfsNaam }

New-ADOrganizationalUnit -Name "Users" -Path $hoofdOU.DistinguishedName
New-ADOrganizationalUnit -Name "Groups" -Path $hoofdOU.DistinguishedName
New-ADOrganizationalUnit -Name "Computers" -Path $hoofdOU.DistinguishedName
#endregion

#region CSV inlezen en gebruikers aanmaken
$userLocatie = Get-ADOrganizationalUnit -Filter { Name -eq  "Users" }

$alleGebruikers = Import-Csv $csvPad -Delimiter ";"
$alleGebruikersNamen = $alleGebruikers | Select-Object -Unique Name # uniek maken op Name

# $alleGebruikersNamen  = $alleGebruikersNamen | Where-Object Name -Like "David*"

foreach($gebruiker in $alleGebruikersNamen)
#foreach($gebruiker in ($alleGebruikersNamen | Select-Object -First 2))
{
    $Name = Remove-HtmlQuote $gebruiker.Name
    $SAM =  Get-UniekeLogin ( Get-AllesVoorSpatie $Name )
    $UPN = $SAM
    $paswoord = ConvertTo-SecureString "R1234-56" -AsPlainText -Force # omzetten naar securestring

    New-ADUser `
        -SamAccountName $SAM -UserPrincipalName $SAM `        -AccountPassword $paswoord -Enabled $true `        -DisplayName $Name -Name $Name `
        -Path $userLocatie.DistinguishedName
}

#endregion

#region Groepen maken en vullen...
$groepLocatie = Get-ADOrganizationalUnit -Filter { Name -eq  "Groups" }

$alleGebruikers = Import-Csv $csvPad -Delimiter ";"

$alleFilms = $alleGebruikers | Select-Object -Unique Movie # uniek maken op Name
foreach($film in $alleFilms)
{
    New-ADGroup -Name (Remove-HtmlQuote $film.Movie ) -GroupScope Global -Path $groepLocatie
}

$alleRollen = $alleGebruikers | Select-Object -Unique Role # uniek maken op Name
foreach($rol in $alleRollen)
{
    New-ADGroup -Name (Remove-HtmlQuote $rol.Role ) -GroupScope Global -Path $groepLocatie
}

foreach($gebruiker in $alleGebruikers)
{
    $naamvangebruiker = Remove-HtmlQuote $gebruiker.Name
    $ADgebruiker = Get-ADUser -Filter { DisplayName -eq $naamvangebruiker }

    $ADgebruiker | Add-ADPrincipalGroupMembership -MemberOf (Remove-HtmlQuote $gebruiker.Movie)
    $ADgebruiker | Add-ADPrincipalGroupMembership -MemberOf (Remove-HtmlQuote $gebruiker.Role)
}

#endregion