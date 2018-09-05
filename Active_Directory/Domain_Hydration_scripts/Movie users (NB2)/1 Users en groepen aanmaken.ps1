#region functies
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
    return $tekst.Replace("&amp;#x27;","'").Replace("&#x27;","'")
}

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

#endregion

#region Variabelen instellen
$bedrijfsNaam = "Acme"
$domein = Get-ADDomain
$csvPad = "C:\Scripts\Gebruikers.csv"

#endregion

#region OU's aanmaken en opslaan
New-ADOrganizationalUnit -Name $bedrijfsNaam -Path ...
$hoofdOU = Get-ADOrganizationalUnit -Filter { Name -eq $bedrijfsNaam }

New-ADOrganizationalUnit -Name "Users" -Path ...
New-ADOrganizationalUnit -Name "Groups" -Path ...
New-ADOrganizationalUnit -Name "Computers" -Path ...
#endregion

#region CSV inlezen en gebruikers aanmaken
$userLocatie = Get-ADOrganizationalUnit -Filter { Name -eq "Users" }

$alleGebruikers = Import-Csv $csvPad -Delimiter ";"
$alleGebruikersNamen = $alleGebruikers | Select-Object ... # uniek maken op Name

Get-Process | Select-Object -First 2

#foreach($gebruiker in $alleGebruikersNamen)
foreach($gebruiker in ($alleGebruikersNamen | Select-Object -First 2))
{
    $SAM = ... # alles voor de spatie
    $UPN = $SAM
    $Name = $gebruiker.Name
    $paswoord = ... "R1234-56" # omzetten naar securestring

    New-ADUser `
        -SamAccountName $SAM -UserPrincipalName $SAM `        -AccountPassword $paswoord -Enabled $true `        -DisplayName $Name -Name $Name `
        -Path $userLocatie.DistinguishedName
}

#endregion

#region Groepen maken en vullen...
$alleFilms = $alleGebruikers | ... 

$groepLocatie = Get-ADOrganizationalUnit -Filter { Name -eq "Groups" }

foreach($film in $alleFilms)
{
    $groepnaam = Remove-HtmlQuote $film.Movie

    New-ADGroup -Name $groepnaam `
        -GroupCategory Security -GroupScope Global `
        -Path $groepLocatie
}

$alleRollen = ...

foreach(...)
{
    ...
}


# groepen vullen:

foreach($gebruiker in $alleGebruikers)
{
    $naamvangebruiker = ... $gebruiker.Name
    $ADgebruiker = Get-ADUser -Filter { ... }

    # "Add-ADPrincipalGroupMembership" of "Add-ADGroupMember" ?

    $ADgebruiker | Add-AD... -MemberOf (Remove-HtmlQuote $gebruiker.Movie)
    $ADgebruiker | Add-AD... -MemberOf (Remove-HtmlQuote $gebruiker.Role)
}

#endregion