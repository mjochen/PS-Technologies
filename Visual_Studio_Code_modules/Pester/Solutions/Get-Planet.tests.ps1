. $PSScriptRoot/Get-Planet

Describe 'Get-Planet' {
    It "Given no parameters, it lists all 8 planets" {
      $allPlanets = Get-Planet
      $allPlanets.Count | Should -Be 8
    }
  
    Context "Filtering by Name" {
      It "Given valid -Name '<Filter>', it returns '<Expected>'" -TestCases @(
        @{ Filter = 'Earth'; Expected = 'Earth' }
        @{ Filter = 'ne*'  ; Expected = 'Neptune' }
        @{ Filter = 'ur*'  ; Expected = 'Uranus' }
        @{ Filter = 'm*'   ; Expected = 'Mercury', 'Mars' }
      ){
        param ($Filter, $Expected)
  
        $planets = Get-Planet -Name $Filter
        $planets.Name | Should -Be $Expected
      }
  
      It "Given invalid parameter -Name 'Alpha Centauri', it returns `$null" {
        $planets = Get-Planet -Name 'Alpha Centauri'
        $planets | Should -Be $null
      }
    }

    Context "Filtering by Population" {
      It "Given -Population -1, it returns `$null" {
        $planets = Get-Planet -Population -1
        $planets | Should -Be $null
      }

      It "Given -Population 7.5, it returns 'Earth'" {
        $planets = Get-Planet -Population 7.5
        $planets.Name | Should -Be 'Earth'
      }

      It "Given -Population 0, it returns seven planets" {
        $planets = Get-Planet -Population 0
        $planets.Length | Should -Be 7
      }
    }

    Context "Testing Order" {
      It "Order of planets is correct when no filters are used" {
        $planets = Get-Planet
        $planets[0].Name | Should -Be 'Mercury'
        $planets[1].Name | Should -Be 'Venus'
        $planets[2].Name | Should -Be 'Earth'
        $planets[3].Name | Should -Be 'Mars'
        $planets[4].Name | Should -Be 'Jupiter'
        $planets[5].Name | Should -Be 'Saturn'
        $planets[6].Name | Should -Be 'Uranus'
        $planets[7].Name | Should -Be 'Neptune'
      }

      It "Order of planets is correct when -Name filter is used" {
        $planets = Get-Planet -Name 'm*'
        $planets[0].Name | Should -Be 'Mercury'
        $planets[1].Name | Should -Be 'Mars'
      }
    }
  }