cls

#Top level namespace is ROOT.
#Elke namespace bevat een klasse __NAMESPACE, deze klasse geeft je de 'child' namespaces
$wmi = Get-WmiObject -Class __Namespace -Namespace root 

"Toont namespaces op " + $wmi[0].__server + " ... even geduld"

for ($i=0;$i -le $wmi.Length;$i++)
{
	if ($i -lt $wmi.Length)
	{
		Write-Host -NoNewline "."
		Start-Sleep -Milliseconds 75
	}
	else
	{
		Write-Host "."
	}
}

$wmi | Format-Table name
Write-Host -ForegroundColor green "Er zijn " $wmi.Length " namespaces op deze machine `n"