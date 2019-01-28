$url = "https://garfield.com/comic/2013/01/02"
# $baseurl = "https://d1ejxu6vysztl5.cloudfront.net/comics/garfield/2013/2013-01-02.gif"

$baseurl = "https://d1ejxu6vysztl5.cloudfront.net/comics/garfield/"
# /2017/2017-10-19
$extension = ".gif"

$destination = "c:\tmp\Garfield"
md $destination

$date = (Get-Date).AddDays(-15)

do
{
    $url = $baseurl + $date.ToString("yyyy/yyyy-MM-dd") + $extension
    $dest = Join-Path $destination ($date.ToString("yyyy-MM-dd") + $extension)

    Start-BitsTransfer -Source $url -Destination $dest

    $date = $date.AddDays(1)
}
while(((Get-Date)-$date)-gt 0)

