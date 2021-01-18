#region install pester

Get-Module -Name Pester -ListAvailable

# 3.4 - in every version of windows, but you can update using

Install-Module -Name Pester -Force

# but this might give difficulties later on...

#endregion

#region The cmdlets for the test

# More than 10 gb harddrive free on every drive

Get-Volume | Where-Object DriveLetter -Like "?" | Select-Object -ExpandProperty SizeRemaining

# No processes that have used more than 5 minutes of CPU

$procs = Get-Process | Where-Object CPU -gt (60*5)
$procs.length | Should Be 0

# Are not using 8.8.8.8 as DNS-server

Get-DnsClientServerAddress | Where-Object ServerAddresses -eq "8.8.8.8" | Measure-Object | Select-Object -ExpandProperty Count


#endregion

#region tests

Describe "Test-this-server" {
    Context "More than 10 gb harddrive free on every drive" {
        It "Drives?" {
            Get-Volume |
                Where-Object DriveLetter -Like "?" |
                Select-Object -ExpandProperty SizeRemaining |
                Should BeGreaterThan 10GB
        }
    }
    
    Context "No processes that have used more than 5 minutes of CPU" {
        It "Processes?" {
            $procs = Get-Process | Where-Object CPU -gt (60*5)
            $procs.length | Should Be 0
        }
    }

    Context "Are not using 8.8.8.8 as DNS-server" {
        It "DNS?" {
            Get-DnsClientServerAddress |
                Where-Object ServerAddresses -eq "8.8.8.8" |
                Measure-Object |
                Select-Object -ExpandProperty Count |
                Should Be 0
        }
    }
}


#endregion