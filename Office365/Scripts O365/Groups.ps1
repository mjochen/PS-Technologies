# Creating a security group
New-MsolGroup -DisplayName "Godfather actors" -Description "Actors playing in the Godfather"

# store the group objectId
$objectID = (Get-MsolGroup | Where-Object DisplayName -EQ "Godfather actors").ObjectId

# add users from a csv-file to a group
Import-Csv .\Users.csv -Delimiter ';' |
    ForEach-Object { `    Add-MsolGroupMember `    -GroupObjectId $objectID `    -GroupMemberType User `    -GroupMemberObjectId (Get-MsolUser -UserPrincipalName ( $_.Name.replace(' ','.') + "@" + $domain )  ).ObjectId }

# add all users from New York to a group
New-MsolGroup -DisplayName "New York" -Description "Everybody from New York"

$objectID = (Get-MsolGroup | Where-Object DisplayName -EQ "New York").ObjectId

Get-MsolUser -City 'New York City' |
    ForEach-Object { # neccessary because we need to refer to the ObjectId-property of the users
    Add-MsolGroupMember -GroupObjectId $objectID -GroupMemberType User -GroupMemberObjectId $_.ObjectID }

# Creating a distribution group
New-DistributionGroup -DisplayName "Godfather actors DG" -Name "Godfather actors DG" -PrimarySmtpAddress "godfather@$domain"

# adding users as member
Import-Csv .\Users.csv -Delimiter ';' |
    ForEach-Object { `
    Add-DistributionGroupMember -Identity "Godfather actors DG" `
    -Member ( $_.Name.replace(' ','.') + "@" + $domain )  }

# allow mails from outside the organisation be sent to this group
Get-DistributionGroup "Godfather actors DG" | Set-DistributionGroup -RequireSenderAuthenticationEnabled $false

# Create dynamic distribution group
New-DynamicDistributionGroup -Name "New Yorkers" -RecipientFilter { (RecipientType -eq 'UserMailbox') -and (City -EQ "New York City") }

$newYorkers = Get-DynamicDistributionGroup -Identity "New Yorkers"
Get-Recipient -RecipientPreviewFilter $newYorkers.RecipientFilter

