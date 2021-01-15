$baseuri = "http://dilbert.com/strip/" # 2018-04-05
$destination = "c:\tmp\dilbert"

# md $destination

$date = Get-Date -Format "yyyy-MM-dd"

$site = Invoke-WebRequest ($baseuri + $date)

$imgURL = ($site.Images | Where-Object Width -eq 900).src

$imgFile = Join-Path $destination ($date + ".jpg")

Invoke-WebRequest -URI $imgURL -OutFile $imgFile

$site | Get-Member