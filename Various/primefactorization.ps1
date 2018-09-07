$number = Get-Random -Minimum 1 -Maximum 10000
"$number : " + (primeFactors -n $number)
"$number : " + (calculate-primefactors -n $number)

# https://www.geeksforgeeks.org/print-all-prime-factors-of-a-given-number/
function primeFactors([int] $n) 
{
    $output = @() 
    # Print the number of 2s that divide n 
    while ($n%2 -eq 0) 
    { 
        $output += 2
        $n = $n /2 
    } 
  
    # n must be odd at this point.  So we can skip one element (Note i = i +2) 
    for ($i = 3; $i -le [Math]::Sqrt($n); $i = $i+2) 
    { 
        # While i divides n, print i and divide n 
        while ($n%$i -eq 0) 
        { 
            $output += $i;
            $n = $n/$i; 
        } 
    } 
  
    # This condition is to handle the case when n is a prime number greater than 2 
    if ($n -gt 2){ 
       $output += $n
    }
    return $output
} 

function calculate-primefactors($number)
{
    $i = 2

    while($number%$i -ne 0)
    {
        $i = $i + 1
        if($i -gt [Math]::Sqrt($number))
        {
            return @($number )
        }
    }

    return @($i) + (calculate-primefactors($number/$i))
}

