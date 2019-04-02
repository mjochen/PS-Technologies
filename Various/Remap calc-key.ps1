# https://visser.io/2017/11/remap-the-calculator-keyboard-key-to-playpause-on-windows-10/

$exe = "C:\Users\Jochen Mariën\AppData\Local\Programs\Microsoft VS Code\Code.exe"
$path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AppKey\18"

Set-Location $path

New-ItemProperty -Path $path -Name "ShellExecute" -Value $exe -PropertyType String
