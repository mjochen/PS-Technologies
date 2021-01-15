$jt = New-JobTrigger -Once -At (get-date).Date -RepetitionInterval (New-TimeSpan -Minutes 3) -RandomDelay 00:02:00 -RepetitionDuration ([TimeSpan]::MaxValue)
$opt = New-ScheduledJobOption -StartIfOnBattery
Register-ScheduledJob -Name "show animalfact" -ScriptBlock {

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

    New-Item -Path c:\tmp\fact.txt -ItemType File -Value $Fact -Force
    notepad c:\tmp\fact.txt
} -Trigger $jt -ScheduledJobOption $opt
