# Jobs and scheduling
## Copy a file

As a sort of very basic backup, you need to copy a file every three minutes. Create a scheduled job for this.

[Solution](Solutions/copy_file.ps1)

## Open notepad randomly

Think back of the animal-fact-file. Open a notepad on a computer containing a random animal fact on irregular intervals.

[Solution](Solutions/animal_fact.ps1)

The code for showing the notepad:

```PowerShell
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
```

Did it work? Why not? Check task manager to see if any notepads are running...

```PowerShell
Get-Process "Notepad" -IncludeUserName
```

Fix by removing the scheduled job, and creating a new one that reads the quotes out loud.

```PowerShell
Add-Type -AssemblyName System.Speech
$SpeechSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer
$SpeechSynth.Speak($Fact)
```

[Solution](Solutions/animal_fact_speak.ps1)

Works great, doesn't it? Indeed, it doesn't. Scheduled jobs can't be run interactively. You could run the script at logon as a scheduled *task*, not job, and that would solve it:

[Solution](Solutions/animal_fact_speak_task.ps1)

That works, but it kind of misses the point: we need this task to be preformed repeatedly throughout the day.

[The solution according to Microsoft](https://docs.microsoft.com/en-us/archive/blogs/platformspfe/configuring-advanced-scheduled-task-parameters-using-powershell)

[Solution](Solutions/animal_fact_repeat.ps1)

# A list

Show a list of all scheduled tasks, grouped by the state they are in.

[Solution](Solutions/grouping_tasks.ps1)
