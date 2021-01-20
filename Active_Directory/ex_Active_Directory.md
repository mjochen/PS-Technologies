# Active Directory
## Installing a domain

You shouldn’t automate tasks that you only do very occasionally. But just in case you would want to automate installing a domain: it’s done like this.
* Get all available windows features. Select the one that refers to AD Domain Services.
* Install that feature with all sub features and management tools.
* Wait for the installation to finish. Rebooting isn’t required.
* List all available modules. Two new ones should show up.
* Check all cmdlets that are present in the ADDSDeployment-module.
* Load that module, and perform Install-ADDSForest. Don’t use any parameters, and check what a minimum install for a domain would look like.


[Solution](Solutions/Installing_a_domain_1.ps1)

... or install DHCP and DNS first, then install the domain!

[Solution](Solutions/Installing_a_domain_2.ps1)

## Creating an OU, users and copying users
* Create an OU with your name under “Acme”
* Create ten users, called “your first name 1..10”
* Copy all users whose name starts with the same letter as yours
* Create a new global group
* Try to find as many ways as possible to add all your users to this global group
* Set the profilepath for all you users:
	* Set it to the same path for all users (“c:\temp”)
	* Give one user a different path (“c:\otherTemp”)
* Use the “-remove” parameter with Set-ADUser to remove this profilepath
* Use the “-clear” parameter with Set-ADUser to remove this profilepath

[Solution](Solutions/Creating_an_OU,_users_and_copying_users_1.ps1)

## Group membership
* Create groups
	* Three Domain Local groups
	* Another global group (next to the one you created earlier)
* Adjust the membership
	* Make sure some users are member of the second Global group
	* Make sure the Global groups are members of some Domain Local groups
* Show the memberOf-property for all your users
* Get the “distinguished name” for one of your groups
* Show all users that are a member of this group using the –RecursiveMatch comparison operator
* Now show all users that are a member of one a Domain Local-group you select
* And finally, show all groups a user is member of, even if this is through membership of another group


[Solution](Solutions/Group_membership_1.ps1)
## Fine Grained Password Policies

Create three new fine grained password polices. Apply them to the groups shown in the table:

|Name |	Precedence|	Min nr of chars|	Complexity|	Applies to|
|:---|:---:|:---:|:---:|:---|
|Difficult|	10|	6|	FALSE|	Domain Admins|
|Medium|	50|	5|	FALSE|	 |
|Simple|	100|	4|	FALSE|	Domain Users|

Show name, minimum nr of characters and applies-to for all FGPP’s in a table, ordered by the precedence.


[Solution](Solutions/Fine_Grained_Password_Policies_1.ps1)

## Different connections

The use case for this exercises is that you have to manage two different domains, with different credentials. You are given a list of users that need their passwords reset (or, as in this case, their City-attribute set), and an indication of which domain they belong to.

Use the following code to create the CSV that you are given:

```PowerShell
$csv = "c:\tmp\users.csv"

#region Create CSV

$acme = Get-ADOrganizationalUnit -Filter { Name -like "Acme" }

$users = Get-ADUser -Filter { Name -like "A*" } -SearchBase $acme.DistinguishedName |
    Select-Object DistinguishedName
    
$users | ForEach-Object { $_ | Add-Member -MemberType NoteProperty -Name "Server" -Value (Get-Random -Minimum 1 -Maximum 3 ) }
    
$users | Export-Csv $csv -Delimiter ";"

#endregion
```

Now create two PSDrives (to the same domain), and make sure all users with server-attribute "1" in the CSV are moved to Madrid, and all users with attribute 2 are moved to Berlin.

[Solution](Solutions/Different_connections.ps1)

Felt bad about the copying of code as well? Rewrite using a function!

[Solution](Solutions/Different_connections_function.ps1)

But what if you weren't sure there were only 2 connections? What if there were 3, of 4, or maybe sometimes even 17? Could you make the entire program generic, where the server-name is stored in the CSV, and used to create (and, when no longer neccessary destroy) a connection to an AD?

[Solution](Solutions/Different_connections_generic.ps1)

## _User properties

Pager property

## _Enable recycle bin
