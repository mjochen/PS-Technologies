# https://gallery.technet.microsoft.com/scriptcenter/79644be9-b5e1-4d9e-9cb5-eab1ad866eaf

$UserName = "Infralab\santhosh" 
$Password = "Password"
$Service = "WinRM" #Change service name with your service name

$srv = Get-CimInstance -ClassName Win32_service  -Filter "Name = '$Service'"
(Get-CimClass -ClassName Win32_service).CimClassMethods
$StopStatus = Invoke-CimMethod -InputObject $srv -MethodName StopService -WhatIf

If ($StopStatus.ReturnValue -eq "0") # validating status - http://msdn.microsoft.com/en-us/library/aa393673(v=vs.85).aspx
{
    write-host "Service Stopped Successfully"
}

$ChangeStatus = $svcD.change($null, $null, $null, $null, $null, $null, $UserName, $Password, $null, $null, $null)
If ($ChangeStatus.ReturnValue -eq "0") 
{
    write-host "Sucessfully Changed User Name"
}

$StartStatus = $svcD.StartService()
    
If ($StartStatus.ReturnValue -eq "0") 
{
    write-host "Service Started Successfully"
}