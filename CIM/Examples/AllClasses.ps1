cls

$strComputer = "."
$intTeller = 0
$ns = "root"
$aantalKlassen = 0

Function ListNamespaces ($ns)
{
	$listNS = Get-WmiObject -Class __Namespace -Namespace $ns
	if ($listNS -eq $null) 
	{
		#Bepaal en tel klassen
		$klassen = Get-WmiObject -Namespace $ns  -List | Select-Object name
		$klassen
		Write-Host -ForegroundColor green "Er zijn " $klassen.Length " klassen in de $ns namespaces `n"
		$global:aantalKlassen = $global:aantalklassen + $klassen.Length
	}
	else
	{
		Foreach ($i in $listNS)
		{
			$ns = $i.__namespace + "\" + $i.Name
			write-host -BackgroundColor White -ForegroundColor DarkBlue "`t`t`t NAMESPACE : " $ns
			ListNamespaces ($ns)
		}
	}
}		

ListNamespaces ($ns)
Write-Host -ForegroundColor green "Er zijn in totaal " $aantalKlassen " klassen"
