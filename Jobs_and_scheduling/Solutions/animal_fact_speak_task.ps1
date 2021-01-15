Get-ScheduledJob "say animalfact" | Unregister-ScheduledJob

#region create script

New-Item -Path c:\tmp\fact.ps1 -ItemType File -Force
Set-Content -Path c:\tmp\fact.ps1 -Value '
Switch ("cat","dog","giraffe"| Get-Random) {
    "cat" {
        $Fact = (ConvertFrom-Json (Invoke-WebRequest -Uri "https://the-cat-fact.herokuapp.com/api/randomfact")).data.fact
    }
    "dog" {
        $Fact = (ConvertFrom-Json (Invoke-WebRequest -Uri "https://dog-api.kinduff.com/api/facts")).facts
        $Fact = $Fact[0]
    }
    "giraffe" {
        $all = (Invoke-WebRequest -Uri "http://www.randomgiraffefacts.com/index.cgi")
        $Fact = ($all.AllElements | Where-Object tagname -eq "H3" | Select-Object -First 1).innerHTML
    }
}

Add-Type -AssemblyName System.Speech
$SpeechSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer
$SpeechSynth.Speak($Fact)'
#endregion

#region create task

$ta = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-ExecutionPolicy Bypass  -WindowStyle Hidden -File c:\tmp\fact.ps1"
$tt = New-ScheduledTaskTrigger -AtLogOn # -RandomDelay 00:03:00
$tp = New-ScheduledTaskPrincipal $env:USERNAME
$tss = New-ScheduledTaskSettingsSet
$t = New-ScheduledTask -Action $ta -Principal $tp -Trigger $tt -Settings $tss
Register-ScheduledTask Animal_fact -InputObject $t

#endregion
