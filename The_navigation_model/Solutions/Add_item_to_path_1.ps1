$pathList = $env:Path.Split(";")
$pathList += "c:\tmp"
$env:Path = [String]::Join(";",$pathList)
