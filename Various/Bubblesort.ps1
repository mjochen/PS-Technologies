<#
[int[]]$array = (1..10)

for($i = 0; $i -lt 10; $i++)
{
    $array[$i] = Get-Random -Minimum 1 -Maximum 100
}
#>

$array.GetType()


function Sorteer
{
    [Cmdletbinding()]
    Param( $in )

    

    for($i = 0;$i-lt $in.Length; $i++)
    {
        Write-Verbose ($in -join "-")

        for($j = $i+1; $j -lt $in.Length; $j++)
        {
            #Write-Verbose "$i - $j"
            if($in[$i] -gt $in[$j])
            {
                $var = $in[$i]
                $in[$i] = $in[$j]
                $in[$j] = $var
            }
        }
    }
    
    return $in
}

Sorteer $array -Verbose
