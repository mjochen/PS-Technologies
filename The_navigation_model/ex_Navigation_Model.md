# Navigation Model
## Creating PSDrives
* Create a new PSDrive to the folder you use most.
* Check which PSDrives exist. Close the PowerShell session and open a new session to check whether the PSDrive remains.
* Save the creation of the PSDrive to your profilescript.
* Close the PowerShell session and open a new session to check whether the PSDrive remains.
* Get the folder where the profilescript is stored.
* Remove that folder. (Unless you like the new PSDrive. In that case, leave the profilescript as it is.)

[Solution](Solutions/Creating_PSDrives_1.ps1)

## Environment variables
* Set the current location to the environment variables
* Show all environment variables.
* Show the content of Path, SystemDrive, ComputerName and LogonServer.
    * (You can approach them through Get-Item, Get-Childitem or $env:NameVariable. Try them out and check the differences.)


[Solution](Solutions/Environment_variables_1.ps1)
## Showing folder sizes

Show for a folder (store the name in a variable) the name and total size (of the folder and all subfolders) in MB. Make sure the output looks like this:

> C:\Users\Karin 		 100,84 MB

You can do this using variables, or using one long pipe ending in a format-table…


[Solution](Solutions/Showing_folder_sizes_1.ps1)
## Add item to path

The path-variable is stored in the environment-model. It’s stored as a semicolon-separated string, so the method “split” would change it into a list.

To this list you can add additional items. After doing so, rejoin the list (using the statical ‘Join’-method from the [String]-class) and store it in the path variable.


[Solution](Solutions/Add_item_to_path_1.ps1)

There is of course an alternative. You could simply add “;newlocation” to the path. In that case, you don’t have to split up all items and join them again.


[Solution](Solutions/Add_item_to_path_2.ps1)
