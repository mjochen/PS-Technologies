Get-CimInstance win32_computersystem | FL -Property SystemType, Manufacturer, Model
Get-CimInstance Win32_ComputerSystem -Property SystemType, Manufacturer, Model

Get-CimInstance Win32_QuickFixEngineering | Ft -Property HotFixID
Get-CimInstance Win32_QuickFixEngineering -Property HotFixID

Get-HotFix
