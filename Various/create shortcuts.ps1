$shortcutfile = "C:\_Vakken\SCCM\Les\vms.csv"
$destination = "C:\_Vakken\SCCM\Les\links"


foreach($link in (Import-Csv $shortcutfile -Delimiter ";"))
{

    $TargetFile = $link.VMlink
    $ShortcutFile = join-path $destination ($link.vmname + ".lnk")
    $WScriptShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
    $Shortcut.TargetPath = $TargetFile
    $Shortcut.Save()
}