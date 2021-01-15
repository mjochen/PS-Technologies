$baseuri = "https://www.gocomics.com/garfield/"
$location = "c:\tmp\Garfield"

$date = (Get-Date).AddDays(-15)

do
{
    $date

    $uri = $baseuri + $date.ToString("yyyy/MM/dd")

    $webpage = Invoke-WebRequest -Uri $uri
    $uri = ($webpage.Images | Where-Object alt -like "Garfield Comic Strip for*").src

    $filename = Join-Path $location ("Garfield " + $date.ToString("yyyy-MM-dd") + ".gif")
    Invoke-WebRequest -Uri $uri -OutFile $filename

    $date = $date.AddDays(1)
}
while(((Get-Date)-$date)-gt 0) 
