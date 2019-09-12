# GIT & VSCode
## Working with GIT & Branches (Navigational Model Basics)

1. Create a new working directory and initialize a repository in it
2. Create a first small script `Listing.ps1` that does the following:
3. Do the initial commit
4. Edit the script so that it does the following:
	* List all the files in the user’s home directory and show only the name and the length.
5. Commit again
6. Create a branch, so that you can safely develop the next feature
7. Use the branch to edit the script so that it _also_ does the following:
	* The result should be saved in a file called “allfiles.txt”, placed in the same directory of the script
	* Use a variable called `$current` to save this directory, place the line of code where you do this first
8. Commit the changes
9. Check out the master branch to see if your script content changes
10. Merge the branch

## Working with GIT & Branches - My first Remote

1. Create an GitHub account
2. Create a new GitHub repository for your exercise
2. Push your current work to the remote repository
	* If you are promted to enter a username and a password, enter the __exact__ same e-mail address and password you used on GitHub. Double-check!
3. Take a look at your GitHub account
4. Edit the script so that the previous code is contained in a function called `Get-Sysrootfiles` that accepts a parameter named `$OutputType`
	* If `$OutputType` is set to 'File' the output gets put into the file as it did before
	* In all other cases the output is displayed in the terminal
5. Commit
6. Push the changes to the remote
7. Take a look at your GitHub repository again to check if the changes are present

## Working with GIT & VSCode 

1. Make sure you have VSCode installed with the Powershell Extension
2. Open your working directory in VSCode

### Debug
Use breakpoints and the debug function so you are able to check the value of the parameters as the `Get-Sysrootfiles` function gets used.

### Create a new function
1. Create a new branch via VSCode
2. Use the branch
3. Push the changes to the remote
5. Take a look at your GitHub repository again to check if the changes are present
6. Edit the script so that it gets an extra function called `Get-BigSysrootfiles` that does the following:
	* Accepts a parameter named `$OutputType`, with the same functionality as before
	* List all the files from the Windows directory that are larger than 10Kb.
	* The result should be sorted by Length and saved in a file called “username-largefiles.txt”, where username should be replaced by the user’s name. 
	* This file should be saved in the user's Documents directory. The windows directory should not be hardcoded (i.e. installations where Windows is not installed in c:\windows should also be supported). 	
7. Commit
8. Merge the branch via VSCode
9. Push the changes to the remote again

[Solution](Solutions/GIT_and_VSCode.ps1)

