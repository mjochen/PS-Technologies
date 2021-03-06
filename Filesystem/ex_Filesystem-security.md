# Filesystem – security
## Setting and changing permissions
* Create with a cmdlet a new folder under the root of the C-drive called Testfolder.
* Cycle through the ACL for this folder, and show every ACE with some details.
* Copy the contents of the temp-folder to this new location.
* Disable the inheritance on the new folder
* Give your own account full management-rights over this folder and his files, but not the subfolders.
* Transfer the accesspermissions from this folder to the folder Tmp.
* Delete all non-inherited permissions on Tmp.

[Solution](Solutions/Setting_and_changing_permissions_1.ps1)
[Solution with module](Solutions/Setting_and_changing_permissions_module.ps1)
## Understanding the inheritance flags

Unfortunately, the GUI on a server will always have its uses. One of these is to understand the propagation flags.

Create, in a testfolder, seven new folders. Add an acl with full control to every one of these folders for the current user.

Then change these permissions manually so they apply to…

![Screenshot](ex-images/image1.png)

Afterwards, show for every folder the inheritance and propagationflags in PowerShell.

[Solution](Solutions/Understanding_the_inheritance_flags_1.ps1)

## Setting the owner

When preparing user-folders in AD it’s sometimes necessary to create a folder (as administrator), and then transfer ownership to another user.

(Unless, of course, you apply the folder redirection policies, in which case the user creates his or her own folder when they log on the first time. That’s actually much easier and fault tolerant.)
* Create a new local user on your computer.
	* https://blogs.technet.microsoft.com/heyscriptingguy/2010/11/23/use-powershell-to-create-local-user-accounts/
* Create a new folder with the same name as the new user.
* Change the permissions of the folder:
	* “Creator Owner” has full control
	* “Users” only have readpermissions
* Transfer the ownership to the new user.

[Solution](Solutions/Setting_the_owner_1.ps1)

## Deleting permissions with a gridview

Allow the user to delete certain permissions on a folder (or file) by showing all ACE’s in a gridview, and removing the ones the user selects.

Note that removing an ACE doesn’t work if inheritance is enabled. Disable inheritance (and copy the existing permissions) first.

[Solution](Solutions/Deleting_permissions_with_a_gridview_1.ps1)

## Fixing dontreadme.txt

In an earlier exercise we created a file that couldn’t be accessed anymore (Common parameters, basic exercises). We did this by disabling inheritance. The code we used was the following:

```PowerShell
New-Item -Path "c:\tmp\dont read me.txt" -ItemType file
Set-Content -Path "c:\tmp\dont read me.txt" -Value "Supersecret"

$acl = Get-Acl -Path "c:\tmp\dont read me.txt"
$acl.SetAccessRuleProtection($true, $false)
$acl | Set-Acl -Path "c:\tmp\dont read me.txt"
```

In explorer this is easy enough to fix, because we didn’t change the owner of the file. This means we don’t have to ‘take ownership’, and are always allowed to change the permissions on the file.

In PowerShell however, simply “enabling inheritance” isn’t an option. First you have to have access to the file, and that means adding the current user to the ACL with enough (or full, to be sure) permissions. Then you can enable inheritance for the file and remove the ACE we added.

[Solution](Solutions/Fixing_dontreadme.txt_1.ps1)

## Creating and formatting a drive

Along with Hyper-V came the new and exiting VHDX-files. VHDX-files are files that can be used as a hard drive for a virtual machine, but also for any operating system. This makes it a great filetype to offload old backups into, as it makes one big file out of a lot of small files. And one big file is easier to move than a lot of small ones.
* Create a new VHDX-file at a predefined location
* Mount the VHDX-file
* Get the mounted disk
* Initialize it
* Create a new partition
* And finally format the new partition

The scripting guy described a way to do all this using one big unwieldy command line. You could also do this somewhat slower but while retaining more of an overview using variables.


[Solution](Solutions/Creating_and_formatting_a_drive_1.ps1)
## Data deduplication

Data deduplication does exactly that: when the same data is stored on a drive twice, it’s only stored once and referenced. It’s a new feature since server 2012. You could install it using the add roles and features wizard.

![Screenshot](ex-images/image2.png)

But what would be the fun in that?

Data deduplication actually works pretty well. When a file in folder A is partially the same as a file in folder B, the similar parts are stored only once, and the changed parts are stored twice. This is especially nice when making, say, a weekly copy of an entire folder by means of backup.

Do the following in PowerShell:
* Find the correct name of the data deduplication-feature
* Install that feature
* Enable data deduplication on a drive
* Check all volumes that have data deduplication set
* Check the deduplication schedule
* As we’re on a test-environment, set the minimum age for files to 0
* Start the deduplication-job on the drive we’ve just setup
* Check the results, until the job is done (which may take a while)
* While the job is running, get the deduplication status (and note the improvement)

[Solution](Solutions/Data_deduplication_1.ps1)
