﻿Get-Mailbox | foreach-object { `
    Add-Content -Value ("<html><body>" + $_.DisplayName + "</body></html>") `