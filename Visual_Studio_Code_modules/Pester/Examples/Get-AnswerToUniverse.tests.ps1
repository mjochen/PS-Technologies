. $PSScriptRoot/Get-AnswerToUniverse

Describe "[Universe]" {
    Context "The answer to everything" {
        It "The answer is [42]" {
            $answer = Get-AnswerToUniverse
            $answer | Should -Be 42
        }
    }
}