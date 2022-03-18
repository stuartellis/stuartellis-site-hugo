+++
Title = "Accessing Remote Systems with PowerShell"
Slug = "powershell-remoting"
Date = "2022-03-18T06:50:00+00:00"
Description = ""
Categories = ["automation", "devops"]
Tags = [".NET", "automation", "devops", "powershell", "windows"]
Type = "article"
Toc = true

+++

Accessing remote systems with [PowerShell](https://microsoft.com/powershell).

<!--more-->

## Accessing Remote Systems

By default, PowerShell accesses remote systems by connecting to the Windows Remote Management (WinRM) service on those systems, using the WS-MAN protocol. Microsoft have added [SSH support](https://docs.microsoft.com/en-us/powershell/scripting/learn/remoting/ssh-remoting-in-powershell-core) as an alternative to WinRM and WS-MAN.

Current versions of Windows Server enable WinRM, and allow users with administrative rights to log in. For other versions of Windows, you must first run the *Enable-PSRemoting* cmdlet to set up remote access.

By default, PowerShell uses the credentials of the logged in user.

## Moving Between Local and Remote Systems

First, create a *persistent session* on the remote system. You then either pass the session object to other commands as an option, or use *Enter-PSSession* to run an interactive session on the remote system.

~~~powershell
$session1 = New-PSSession -ComputerName server1
Copy-Item '.\my-file.txt' 'C:\' -ToSession $session1
~~~

~~~powershell
$session1 = New-PSSession -ComputerName server1
Enter-PSSession $session1
~~~

This session remains active until you close it, which means that you can enter and exit the session as you wish. To close a session, use the *Remove-PSSession* cmdlet:

~~~powershell
$session1 = New-PSSession -ComputerName server1
Remove-PSSession $session1
~~~

Some PowerShell commandlets include specific options for remote systems. These create temporary connections that are automatically closed once the command is completed on the remote system.

## Running Commands and Scripts on Remote Systems

Use the *Invoke-Command* cmdlet to run PowerShell commands on remote systems:

~~~powershell
Invoke-Command -ComputerName server1,server2,server3 -ScriptBlock { Get-Service }
~~~

To run a script, specify the name of the script with the *FilePath* option:

~~~powershell
Invoke-Command -ComputerName server1,server2,server3 -FilePath '.\my-script.ps1'
~~~

The results of scripts and commands are returned to the PowerShell session as XML data objects. This means that results can be piped into other commandlets, but the result objects only have data properties.

By default, *Invoke-Command* creates new temporary connections to run the command or script on each system. You may re-use persistent sessions if you wish.

## Automating Management with Ansible or Windows PowerShell DSC

The [Ansible](https://www.ansible.com) automation tool uses PowerShell to
execute tasks on the Windows systems that it manages, with PowerShell Remoting and [WinRM](https://msdn.microsoft.com/en-us/library/aa384426%28v=vs.85%29.aspx)
(Windows Remote Management) to communicate between the controller and the
targets. This means that PowerShell Remoting must be enabled on all of the Windows systems that you would like to manage with Ansible.

[Desired State Configuration](https://docs.microsoft.com/en-us/powershell/scripting/dsc/) (DSC) provides extensions for managing multiple remote systems using
PowerShell, and also uses WinRM for communications. DSC does not need PowerShell
Remoting to be enabled on the target systems, only WinRM.
