
Function Is-OddOrEven {
    param ( $in )

    if ( $in.gettype().Name.Substring(0, 3) -NE "Int") {
        Throw "Not an integer-type."
    }

    while ( $in -gt 1) {
        $in -= 2
    }

    if ($in -eq 0) {
        return "Even!"
    }
    else {
        return "Odd!"
    }
}

Foreach ($i in (1..10)){
    $number = ( Get-Random -Minimum 100 -Maximum 500000 )
    Write-Host "$number is $(Is-OddOrEven $number )"
}