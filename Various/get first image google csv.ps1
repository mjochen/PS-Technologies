<#
	.SYNOPSIS
	This script will download the first found picture in Google for every person in a CSV.

    .PARAMETER CSV
    Location of the CSV-file. Make sure the fields "first" and "last" are present

    .PARAMETER location
    location to save the images. Default is c:\tmp. If it doesn't exist, the folder will be created.
	
	.EXAMPLE
	Get-ComputerSystem -ComputerName DC01 -Detail
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory=$True,
               ValueFromPipeline=$true)]
    [string]$CSV,
	[string]$location="C:\tmp"
)

Write-Verbose "Testing file"
if(-not (Test-Path $CSV))
{
    Write-Error "File can't be found."
    break
}

Write-Verbose "Checking to-save-location"
if(-not (Test-Path $location))
{
    New-Item $location -ItemType Directory -Force
}

Write-Verbose "Adding `"`\`" to location"
if(-not $location.EndsWith("\"))
{
    $location += "\"
}

Write-Verbose "Loading users from csv"
$all = Import-Csv -Path $CSV -Delimiter ";" -Encoding UTF7

$notExistFirst = -not [bool]($all[0].PSobject.Properties.name -match "first")
$notExistLast = -not [bool]($all[0].PSobject.Properties.name -match "last")

Write-Debug ("First doesn't exists? " + $notExistFirst)
Write-Debug ("Last doesn't exists? " + $notExistLast)


if($notExistFirst -and $notExistLast )
{
    Write-Error "First and/or Last aren't present in the CSV-file"
    break
}

Write-Verbose "Getting information from google"
$results = $all | foreach-object { Invoke-WebRequest "https://www.google.be/search?q=$($_.first)+$($_.last)&tbm=isch" }

Write-Verbose "Storing pictures"
$results | ForEach-Object{ Start-BitsTransfer -Source $_.Images[0].src -Destination ($location + $_.ParsedHtml.title.substring(0,$_.ParsedHtml.title.indexof("-")-1) + ".jpg") }  

