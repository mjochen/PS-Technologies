# see also: https://gist.github.com/atifaziz/9390344

#$top = Get-WmiObject -Class Win32_process | Where-Object ParentProcessId -eq "" | ft


function Print-ChildrenProcesses 
{
    [cmdletbinding()]
    Param($processID = "", $level = 0)

    Write-Verbose "Printing for process $processID, $level"
    
    $processes = Get-WmiObject -Class Win32_process | Where-Object ParentProcessId -eq $processID
    foreach($process in $processes)
    {
        $tabs = "`t" * $level
        Write-Output ($tabs + $process.ProcessId + ": " +$process.name)
        Write-Verbose "Calling for process $($process.ProcessId), $($level+1)"
        if($process.ProcessId -ne 0)
        {
            Print-ChildrenProcesses -processID $process.ProcessId -level ($level+1)
        }
    }
}
 
Print-ChildrenProcesses -verbose     
