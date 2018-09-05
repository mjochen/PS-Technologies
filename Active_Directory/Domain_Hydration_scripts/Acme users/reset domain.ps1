$domainName = $env:USERDNSDOMAIN
$domainPath = "OU=Acme," + (Get-ADDomain).DistinguishedName

$goodOus = "Acme","Admins","Computers","Clients","Servers","Users","Groups"

$allOus = Get-ADOrganizationalUnit -SearchBase $domainPath -SearchScope Subtree -Filter *

# remove "bad" OU's
foreach($ou in $allOus)
{
    if($ou.Name -notin $goodOus)
    {
        Set-ADOrganizationalUnit $ou -ProtectedFromAccidentalDeletion $false
        Remove-ADOrganizationalUnit $ou -Confirm:$false -Recursive
    }

}

# clear Admins
Get-ADUser -SearchBase "OU=Admins,$domainPath" -Filter { CN -ne "Admin" } | Remove-ADUser -Confirm:$false

# clear groups
Get-ADObject -SearchBase "OU=Groups,$domainPath" -Filter { Name -ne "Groups" } | Remove-ADObject -Confirm:$false

# recreate users
$userPath = "OU=Users,$domainPath"
$userPassword = ConvertTo-securestring -Force -AsPlainText "R1234-56"

try{

    New-ADUser -name "Morgan Freeman" -Path $userPath -samAccountName "Morgan.Freeman" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Paz Vega" -Path $userPath -samAccountName "Paz.Vega" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Heath Ledger" -Path $userPath -samAccountName "Heath.Ledger" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Julia Stiles" -Path $userPath -samAccountName "Julia.Stiles" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Joseph Gordon-Levitt" -Path $userPath -samAccountName "Joseph.Gordon-Levitt" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Larisa Oleynik" -Path $userPath -samAccountName "Larisa.Oleynik" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "David Krumholtz" -Path $userPath -samAccountName "David.Krumholtz" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Andrew Keegan" -Path $userPath -samAccountName "Andrew.Keegan" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Susan May Pratt" -Path $userPath -samAccountName "Susan.May.Pratt" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Gabrielle Union" -Path $userPath -samAccountName "Gabrielle.Union" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Larry Miller" -Path $userPath -samAccountName "Larry.Miller" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Daryl Mitchell" -Path $userPath -samAccountName "Daryl.Mitchell" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Allison Janney" -Path $userPath -samAccountName "Allison.Janney" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "David Leisure" -Path $userPath -samAccountName "David.Leisure" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Greg Jackson" -Path $userPath -samAccountName "Greg.Jackson" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Kyle Cease" -Path $userPath -samAccountName "Kyle.Cease" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Terence Heuston" -Path $userPath -samAccountName "Terence.Heuston" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Tony Shalhoub" -Path $userPath -samAccountName "Tony.Shalhoub" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Embeth Davidtz" -Path $userPath -samAccountName "Embeth.Davidtz" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Matthew Lillard" -Path $userPath -samAccountName "Matthew.Lillard" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Shannon Elizabeth" -Path $userPath -samAccountName "Shannon.Elizabeth" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Alec Roberts" -Path $userPath -samAccountName "Alec.Roberts" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "JR Bourne" -Path $userPath -samAccountName "JR.Bourne" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Rah Digga" -Path $userPath -samAccountName "Rah.Digga" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "F. Murray Abraham" -Path $userPath -samAccountName "F..Murray.Abraham" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Matthew Harrison" -Path $userPath -samAccountName "Matthew.Harrison" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Jacob Rupp" -Path $userPath -samAccountName "Jacob.Rupp" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Daniel Wesley" -Path $userPath -samAccountName "Daniel.Wesley" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "John Cusack" -Path $userPath -samAccountName "John.Cusack" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Amanda Peet" -Path $userPath -samAccountName "Amanda.Peet" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Chiwetel Ejiofor" -Path $userPath -samAccountName "Chiwetel.Ejiofor" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Thandie Newton" -Path $userPath -samAccountName "Thandie.Newton" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Oliver Platt" -Path $userPath -samAccountName "Oliver.Platt" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Thomas McCarthy" -Path $userPath -samAccountName "Thomas.McCarthy" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Woody Harrelson" -Path $userPath -samAccountName "Woody.Harrelson" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Danny Glover" -Path $userPath -samAccountName "Danny.Glover" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Liam James" -Path $userPath -samAccountName "Liam.James" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Morgan Lily" -Path $userPath -samAccountName "Morgan.Lily" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Zlatko Buric" -Path $userPath -samAccountName "Zlatko.Buric" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Beatrice Rosen" -Path $userPath -samAccountName "Beatrice.Rosen" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Alexandre Haussmann" -Path $userPath -samAccountName "Alexandre.Haussmann" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Philippe Haussmann" -Path $userPath -samAccountName "Philippe.Haussmann" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Johann Urb" -Path $userPath -samAccountName "Johann.Urb" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Jim Sturgess" -Path $userPath -samAccountName "Jim.Sturgess" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Kevin Spacey" -Path $userPath -samAccountName "Kevin.Spacey" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Kate Bosworth" -Path $userPath -samAccountName "Kate.Bosworth" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Aaron Yoo" -Path $userPath -samAccountName "Aaron.Yoo" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Liza Lapira" -Path $userPath -samAccountName "Liza.Lapira" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Jacob Pitts" -Path $userPath -samAccountName "Jacob.Pitts" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Jack McGee" -Path $userPath -samAccountName "Jack.McGee" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Josh Gad" -Path $userPath -samAccountName "Josh.Gad" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Helen Carey" -Path $userPath -samAccountName "Helen.Carey" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Jack Gilpin" -Path $userPath -samAccountName "Jack.Gilpin" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Donna Lows" -Path $userPath -samAccountName "Donna.Lows" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Butch Williams" -Path $userPath -samAccountName "Butch.Williams" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Ben Campbell" -Path $userPath -samAccountName "Ben.Campbell" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Robert Carlyle" -Path $userPath -samAccountName "Robert.Carlyle" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Catherine McCormack" -Path $userPath -samAccountName "Catherine.McCormack" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Rose Byrne" -Path $userPath -samAccountName "Rose.Byrne" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Jeremy Renner" -Path $userPath -samAccountName "Jeremy.Renner" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Harold Perrineau" -Path $userPath -samAccountName "Harold.Perrineau" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Idris Elba" -Path $userPath -samAccountName "Idris.Elba" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Imogen Poots" -Path $userPath -samAccountName "Imogen.Poots" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Mackintosh Muggleton" -Path $userPath -samAccountName "Mackintosh.Muggleton" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Amanda Walker" -Path $userPath -samAccountName "Amanda.Walker" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Emily Beecham" -Path $userPath -samAccountName "Emily.Beecham" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Beans El-Balawi" -Path $userPath -samAccountName "Beans.El-Balawi" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Gerard Butler" -Path $userPath -samAccountName "Gerard.Butler" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Lena Headey" -Path $userPath -samAccountName "Lena.Headey" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Dominic West" -Path $userPath -samAccountName "Dominic.West" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "David Wenham" -Path $userPath -samAccountName "David.Wenham" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Vincent Regan" -Path $userPath -samAccountName "Vincent.Regan" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Michael Fassbender" -Path $userPath -samAccountName "Michael.Fassbender" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Tom Wisdom" -Path $userPath -samAccountName "Tom.Wisdom" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Andrew Pleavin" -Path $userPath -samAccountName "Andrew.Pleavin" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Andrew Tiernan" -Path $userPath -samAccountName "Andrew.Tiernan" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Rodrigo Santoro" -Path $userPath -samAccountName "Rodrigo.Santoro" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Giovani Cimmino" -Path $userPath -samAccountName "Giovani.Cimmino" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Stephen McHattie" -Path $userPath -samAccountName "Stephen.McHattie" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Greg Kramer" -Path $userPath -samAccountName "Greg.Kramer" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Steven Strait" -Path $userPath -samAccountName "Steven.Strait" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Camilla Belle" -Path $userPath -samAccountName "Camilla.Belle" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Cliff Curtis" -Path $userPath -samAccountName "Cliff.Curtis" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Joel Virgel" -Path $userPath -samAccountName "Joel.Virgel" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Affif Ben Badra" -Path $userPath -samAccountName "Affif.Ben.Badra" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Nathanael Baring" -Path $userPath -samAccountName "Nathanael.Baring" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Mona Hammond" -Path $userPath -samAccountName "Mona.Hammond" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Reece Ritchie" -Path $userPath -samAccountName "Reece.Ritchie" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Joel Fry" -Path $userPath -samAccountName "Joel.Fry" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Omar Sharif" -Path $userPath -samAccountName "Omar.Sharif" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Armand Assante" -Path $userPath -samAccountName "Armand.Assante" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Sigourney Weaver" -Path $userPath -samAccountName "Sigourney.Weaver" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Loren Dean" -Path $userPath -samAccountName "Loren.Dean" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Michael Wincott" -Path $userPath -samAccountName "Michael.Wincott" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Kevin Dunn" -Path $userPath -samAccountName "Kevin.Dunn" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Mark Margolis" -Path $userPath -samAccountName "Mark.Margolis" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Kario Salem" -Path $userPath -samAccountName "Kario.Salem" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "Billy L. Sullivan" -Path $userPath -samAccountName "Billy.L..Sullivan" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "John Heffernan" -Path $userPath -samAccountName "John.Heffernan" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
    New-ADUser -name "John Hurt" -Path $userPath -samAccountName "John.Hurt" -AccountPassword $userPassword -PasswordNeverExpires $true -Enabled $true
}
Catch [Microsoft.ActiveDirectory.Management.ADIdentityAlreadyExistsException]
{
    # do nothing, continue
    

}
