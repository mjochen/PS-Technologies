$essentialUsers = @('John Deere', 'Gordon Freeman', 'Gabrielle Union')
$OUpath ='OU=Users,OU=Acme,DC=cursusdom,DC=local'

Describe "AD - Essential Users" -Tag Essential {
        $essentialUsers.ForEach({
        It "User named [$_] is present" {
            Get-ADUser -Filter * -SearchBase $OUpath | Select-Object -ExpandProperty "Name" | Should -Be $_
        }
    })
}