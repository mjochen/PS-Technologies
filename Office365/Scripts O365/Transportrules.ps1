Get-TransportRule

New-TransportRule "Block executable" -AttachmentHasExecutableContent $true `
-RejectMessageReasonText "No executable files allowed."


Remove-TransportRule "Block executable"

New-TransportRule "Block executable 2" -AttachmentHasExecutableContent $true `
    -DeleteMessage $true

$message = 'Je kreeg een bericht, maar krijgt het toch niet:
The sender of the message for which the notification is being generated. 	%%From%%
The recipients listed on the "To" line. 	%%To%%
The recipients listed on the "Cc" line. 	%%Cc%%
The subject of the message for which the notification is being generated. 	%%Subject%%
The headers from the original message. 	%%Headers%%
The sent date of the original message. Time is in UTC. 	%%MessageDate%%'

New-TransportRule -AttachmentSizeOver '512 KB (524,288 bytes)' -GenerateNotification $message  -Name 'regel 3' -StopRuleProcessing:$false -Mode 'Enforce' -Comments '
' -RuleErrorAction 'Ignore' -SenderAddressLocation 'Header' -RejectMessageReasonText "File too large."

Get-TransportRule "regel 3" | Set-TransportRule -GenerateNotification $message 