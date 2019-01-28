<#
	.SYNOPSIS
	Download Garfield comics from the internet.
	
	.DESCRIPTION
	Download Garfield comics from the internet between two given days.

    .PARAMETER startDate
    First day to download. Defaults to yesterday.

    .PARAMETER endDate
    Last day to download. Defaults to today.

    .PARAMETER path
    Folderpath to save the files to. Defaults to c:\tmp\Garfield. Folder will be created if it doesn't exist.
	
    .PARAMETER unlimited
    If set, it allows unlimited downloads. Otherwise, maximum 10 cartoons are downloaded.
	
	.EXAMPLE
	Garfield.ps1
    Downloads yesterday's and today's comics.

    .EXAMPLE
	Garfield.ps1 -startDate (Get-Date 1-1-1992) -endDate (Get-Date 31-1-1992)
    Downloads the comics for january 1992.

#>

[CmdletBinding()]
param(
    [DateTime]$startDate = (Get-Date).addDays(-1),
    [DateTime]$endDate = (Get-Date),
    [string]$path = "c:\tmp\Garfield",
    [switch]$unlimited
)


if (-not (Test-Path $path)) {
    Write-Verbose "$path doesn't exist, creating..."
    New-Item -Value $path -ItemType Directory
}

$baseurl = "https://d1ejxu6vysztl5.cloudfront.net/comics/garfield/"
# /2017/2017-10-19
$extension = ".gif"

$destination = $path
$date = $startDate

if (-not $unlimited -and $endDate -gt $startDate.AddDays(10)) {
    $endDate = $startDate.AddDays(9)
    Write-Verbose "Not unlimited and downloading to much. Limiting to $endDate."
}

do {
    Write-Verbose "Downloading $date"
    $url = $baseurl + $date.ToString("yyyy/yyyy-MM-dd") + $extension
    $dest = Join-Path $destination ($date.ToString("yyyy-MM-dd") + $extension)

    Start-BitsTransfer -Source $url -Destination $dest

    $date = $date.AddDays(1)
}
while (($enddate - $Date) -gt -1)

