$critical = @('SysMain', 'SystemEventsBroker')
$important = @('DHCP', 'DNSCache', 'PlugPlay')

Describe "OS - Critical Services" -Tag Critical {
        $critical.ForEach({
        It "Service [$_] is running" {
            Get-Service $_ | Select-Object -ExpandProperty "Status" | Should -Be 'Running'
        }
    })
}

Describe "OS - Important Services" -Tag Important {
        $important.ForEach({
        It "Service [$_] is running" {
            Get-Service $_ | Select-Object -ExpandProperty "Status" | Should -Be 'Running'
        }
    })
}
