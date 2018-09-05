$domain = "dc=powershell,dc=local"$domain = (Get-ADDomain).DistinguishedName $pathInAD = "ou=Admins,ou=Acme,$domain"$csvfile = Get-Item "C:\Temp\cursisten.csv"New-ADOrganizationalUnit -name "Admins" -Path "OU=Acme,$domain"$import = Import-Csv $csvfile -Delimiter ';' -Encoding UTF7$import | ForEach-Object { $_.last = Set-ProperCapitalisation $_.last }#Import-Csv $csvfile -Delimiter ';' -Encoding UTF7 |
$import |
    foreach-object { new-aduser -Path $pathInAD `
        -SamAccountName $_.first.replace(' ','.') `
        -UserPrincipalName $_.first.replace(' ','.') `
        -DisplayName ($_.first + " " + $_.last) `
        -Name ($_.first + " " + $_.last) `
        -Surname $_.last `
        -Givenname $_.first `
        -Initials ( $_.first.Substring(0,1) + $_.last.Substring(0,1)) `
		-otherattributes @{'sn'="$($_.Last)";'physicaldeliveryofficename'="D213"} `
		-Description "Our Admins"  `
        -Company "Thomas More" `
		-AccountPassword (convertto-securestring -asplaintext "R1234-56" -force) -enabled $true }

# Import-Csv $csvfile -Delimiter ';' -Encoding UTF7 | ForEach-Object { $_.first.Substring(0,1) + $_.last.Substring(0,1) }

$allAdmins = Get-ADUser -Filter {description -eq "Our Admins"} -SearchBase $pathInAD

Add-ADGroupMember -Identity "Domain Admins" -Members $allAdmins

function Set-ProperCapitalisation
{
    Param (
        [Parameter(Mandatory=$True,Position=1)]
        [string]$text
    )

    $text = $text.Substring(0,1).ToUpper() + $text.Substring(1).ToLower()

    if($text.Contains(" "))
    {
        $text = $text.Substring(0,$text.IndexOf(" ")+1) + ( Set-ProperCapitalisation -text $text.Substring($text.IndexOf(" ")+1) )

    }

    return $text
}