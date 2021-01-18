# Test a server

Write a pester-test that checks if a server has:

* More than 10 gb harddrive free on every drive
* No processes that have used more than 5 minutes of CPU
* Are not using 8.8.8.8 as DNS-server

[Solution](Solutions/test_server.ps1)

And to help out, the command to find that information:

```PowerShell
# More than 10 gb harddrive free on every drive

Get-Volume | Where-Object DriveLetter -Like "?" | Select-Object -ExpandProperty SizeRemaining

# No processes that have used more than 5 minutes of CPU

$procs = Get-Process | Where-Object CPU -gt (60*5)
$procs.length | Should Be 0

# Are not using 8.8.8.8 as DNS-server

Get-DnsClientServerAddress | Where-Object ServerAddresses -eq "8.8.8.8" | Measure-Object | Select-Object -ExpandProperty Count
```

# Test the test

How could we test the previous exercise? Perhaps create a virtual harddrive that is only 8gb large?

[Solution](Solutions/Create_HD.ps1)

Another test:
* Export the network adapter ID and DNS-server address for the Wi-Fi adapter to an XML-file
* Change it to 8.8.8.8

And in the next part of that script:
* Read the DNS-server an network adapter-ID from the file
* Set it back to what it was

[Solution](Solutions/Change_DNS.ps1)