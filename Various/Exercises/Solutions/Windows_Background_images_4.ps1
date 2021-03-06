$folder = Get-Item "C:\tmp\Backgrounds\oneFolder"

$allImages = Get-ChildItem $folder -File

$random = Get-Random  -Minimum $allImages.GetLowerBound(0) -Maximum $allImages.GetUpperBound(0)

Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name wallpaper -value $allImages[$random].FullName
Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name WallpaperStyle -value 1
Set-ItemProperty -path 'HKCU:\Control Panel\Desktop\' -name TileWallpaper -value 0

rundll32.exe user32.dll, UpdatePerUserSystemParameters
