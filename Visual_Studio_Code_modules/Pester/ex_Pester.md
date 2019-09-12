# Pester

Pester is the ubiquitous test and mock framework for PowerShell.
(This file is based on the Pester official [repo](https://github.com/pester/Pester).)

## Installation

Pester is compatible with Windows PowerShell 2.x - 5.x on Windows 10, 8, 7, Vista and even 2003.
Since version 4.0.9 Pester is compatible also with PowerShell Core 6.x on Windows, Linux, macOS but with some [limitations](https://github.com/pester/Pester/wiki/Pester-on-PSCore-limitations).

Pester comes pre-installed with Windows 10, but we recommend updating, by running this PowerShell command _as administrator_:

```powershell
Install-Module -Name Pester -Force -SkipPublisherCheck
```

Not running Windows 10 or facing problems? See the [full installation and update guide](https://github.com/pester/Pester/wiki/Installation-and-Update).

## Features

### Assertions

Pester comes with a suite of assertions that cover a lot of common use cases. Pester assertions range from very versatile, like `Should -Be`, to specialized like `Should -Exists`. Here is how you ensure that a file exists:

```powershell
Describe 'Multiplication operator *' {
    It 'Multiplies positive numbers' {
        6 * 5 | Should -Be 30
    }
}

Describe 'Notepad' {
    It 'Exists in Windows folder' {
        'C:\Windows\notepad.exe' | Should -Exist
    }
}
```

Learn more about assertion on [the Pester wiki](https://github.com/pester/Pester/wiki/Should).

## Exercise: Add-Numbers

- Make a `Add-Numbers.ps1` script with a single function that adds two numbers which you pass on as two parameters
- Make the covering tests `Add-Numbers.ps1` script that tests if the function:
    - adds positive numbers
    - adds negative numbers
    - adds one negative number to a positive number
    - concatenates strings if given strings
    - does not return 0 when adding two non-zero numbers

## Exercise: Planets expanded

#### Part 1:
- Add filter Population that returns planets with population larger or equal to the given number (in billions).
- Use 7.5 as the population of Earth. Use 0 for all other planets.
- Make sure to cover these test cases:
    - Population 7.5 returns Earth
    - Population 0 returns all planets
    - Population -1 returns no planets

#### Part 2 (intermediate): 
- Test that planets are returned in the correct order, from the one closest to the Sun.
- Make sure to cover these test cases:
    - Order of planets is correct when no filters are used.
    - Order of planets is correct when -Name filter is used.

#### Part 3 (advanced): Add function that will list moons orbiting a given planet.
- Make sure you can list all moons.
- Make sure you can filter moons for given planet.
- Make sure you Get-Planet and Get-Moon functions work together.

```PowerShell
$moons = Get-Planet Earth | Get-Moon
$moons.Name | Should -Be Moon
```

## Exercise: UserDiagnostics

- Use Pester to check whether the Names of a few essential users in your domain/OU are present. 
- You can choose these Names of these users yourself for the sake of the exercise.

