Get-ScheduledJob "say animalfact" | Unregister-ScheduledJob

$jt = New-JobTrigger -Once -At (get-date).Date -RepetitionInterval (New-TimeSpan -Minutes 3) -RandomDelay 00:02:00 -RepetitionDuration ([TimeSpan]::MaxValue)
$opt = New-ScheduledJobOption -StartIfOnBattery
Register-ScheduledJob -Name "say animalfact" -ScriptBlock {

    Switch ("cat","dog","giraffe"| Get-Random) {
        "cat" {
            $Fact = (ConvertFrom-Json (Invoke-WebRequest -Uri 'https://the-cat-fact.herokuapp.com/api/randomfact')).data.fact
        }
        "dog" {
            $Fact = (ConvertFrom-Json (Invoke-WebRequest -Uri 'https://dog-api.kinduff.com/api/facts')).facts
            $Fact = $Fact[0]
        }
        "giraffe" {
            $all = (Invoke-WebRequest -Uri 'http://www.randomgiraffefacts.com/index.cgi')
            $Fact = ($all.AllElements | Where-Object tagname -eq "H3" | Select-Object -First 1).innerHTML
        }
    }

    Add-Type -AssemblyName System.Speech
    $SpeechSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $SpeechSynth.Speak($Fact)
} -Trigger $jt -ScheduledJobOption $opt
