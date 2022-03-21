# 'normal' ssh to install powershell
ssh 172.18.128.171 -l jm

# do https://docs.microsoft.com/en-us/powershell/scripting/install/install-ubuntu?view=powershell-7.2
# also do https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core?view=powershell-7.2

# exit ssh-session
exit


Enter-PSSession -HostName 172.18.128.171 -UserName "jm"

