$url = "https://makemeapassword.ligos.net/api/v1/passphrase/json?pc=1&wc=6"

$newpassword = (ConvertFrom-Json (Invoke-WebRequest -Uri $url)).pws[0]

$securestring = ConvertTo-SecureString -String $newpassword -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential("admin" ,$securestring)