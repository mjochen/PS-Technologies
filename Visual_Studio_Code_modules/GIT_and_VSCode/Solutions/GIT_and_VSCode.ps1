function Get-Sysrootfiles($OutputType) {
    $current = Get-Location

    if($OutputType -eq 'File'){
        Get-ChildItem $env:HOMEDRIVE$env:HOMEPATH | Format-Table -Property Name,Length > $current\allfiles.txt
    }
    else {
        Get-ChildItem $env:HOMEDRIVE$env:HOMEPATH | Format-Table -Property Name,Length
    }
    
}

function Get-BigSysrootfiles($OutputType) {

    if($OutputType -eq 'File'){
        Get-ChildItem $env:SystemRoot | Where-Object -Property Length -GT 1000 | Sort-Object -Property Length > $env:HOMEDRIVE$env:HOMEPATH\Documents\$env:USERNAME-largefiles.txt
    }
    else {
        Get-ChildItem $env:SystemRoot | Where-Object -Property Length -GT 1000 | Sort-Object -Property Length
    }
    
}

Get-Sysrootfiles


Get-ChildItem $env:SystemRoot | Where-Object -Property Length -GT 1000 | Sort-Object -Property Length > $env:HOMEDRIVE$env:HOMEPATH\Documents\$env:USERNAME-largefiles.txt


Get-ChildItem $env:HOMEDRIVE$env:HOMEPATH -Recurse -Force | Where-Object -Property Name -Like "*$env:USERNAME*"


