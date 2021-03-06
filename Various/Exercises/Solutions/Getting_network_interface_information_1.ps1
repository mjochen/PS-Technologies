$allAdapters = Get-NetAdapter
$list = @()

foreach($adapter in $allAdapters)
{
Write-Verbose "Create empty object"
$new = New-Object System.Management.Automation.PSObject

Write-Verbose "Add properties from netadapter"

$adapter.psobject.properties | ForEach-Object {
$new | Add-Member -MemberType NoteProperty -Name $_.Name -Value $_.Value }

Write-Verbose "Get corresponding addresses"
$addresses = Get-NetIPAddress -InterfaceIndex $adapter.InterfaceIndex -ErrorAction SilentlyContinue
$counter = 0

foreach($address in $addresses)
{
Write-Verbose "Add properties from addresses"

$adapter.psobject.properties | ForEach-Object {
$new | Add-Member -MemberType NoteProperty -Name ($counter.ToString() + $_.Name) -Value $_.Value }
$counter++
}

Write-Verbose "Store new object in list"
$list += $new
# http://stackoverflow.com/questions/14620290/powershell-array-add-vs

}

$list | Export-Csv c:\tmp\interfaces.csv -Delimiter ";"
