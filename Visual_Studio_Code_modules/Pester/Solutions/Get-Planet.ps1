function Get-Planet ([string]$Name = '*', $Population = '*') {
    $planets = @(
        @{ Name = 'Mercury' 
        Population = 0}
        @{ Name = 'Venus' 
        Population = 0}
        @{ Name = 'Earth' 
        Population = 7.5}
        @{ Name = 'Mars' 
        Population = 0}
        @{ Name = 'Jupiter' 
        Population = 0}
        @{ Name = 'Saturn' 
        Population = 0}
        @{ Name = 'Uranus' 
        Population = 0}
        @{ Name = 'Neptune' 
        Population = 0}
    ) | foreach { New-Object -TypeName PSObject -Property $_ }

    $planets | where { $_.Name -like $Name } | where { $_.Population -like $Population }
}

Get-Planet