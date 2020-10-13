$name = "Hannah"
"Hello " + $name

Write-Output "Hello " + $name # wrong
Write-Output "Hello $name" # correct
Write-Output ("Hello " + $name) # correct