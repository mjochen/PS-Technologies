# http://o365info.com/shared-mailbox-powershell-commands/

New-DistributionGroup -DisplayName "UsersA" -Name "UsersA" -type Security
Remove-DistributionGroup "UsersA"

Get-Mailbox | Where-Object DisplayName -like "A*" |
    ForEach-Object {`
        Add-DistributionGroupMember -Identity "UsersA" -Member $_.Identity }


New-Mailbox -Shared -Name "A-users" -DisplayName "A-users" -Alias A-Users
# Remove-Mailbox "A-Users"

$mailbox = Get-Mailbox -Identity "A-Users"
$allUsers = Get-Mailbox | Where-Object DisplayName -like "A*"

foreach($user in $allUsers)
{
    Set-Mailbox -Identity $mailbox.Identity -GrantSendOnBehalfTo $user.Identity -Force
    Add-MailboxPermission -Identity $mailbox.Identity -User $user.Identity -AccessRights FullAccess -InheritanceType All
    Add-RecipientPermission -Identity $mailbox.Identity -Trustee $user.Identity -AccessRights SendAs -Confirm:$false
}

