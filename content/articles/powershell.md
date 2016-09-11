+++
Title = "Notes on PowerShell"
Slug = "powershell"
Date = "2016-07-01T01:00:00+01:00"
Description = ""
Categories = ["administration", "tools"]
Tags = ["administration", "dotnet", "powershell", "windows"]
Type = "article"

+++


[PowerShell](https://msdn.microsoft.com/en-us/powershell) is an
object-oriented shell that is built on .NET, and the custom programming
language that runs within that shell. Third-parties such as VMWare and Amazon Web Services provide modules to enable users to work with their products through PowerShell. You can also supplement the capabilities of
PowerShell modules by directly accessing classes from the underlying
installation of .NET, and by running standard commands and scripts from the host operating system.

<!--more-->

# Installing PowerShell #

To use PowerShell on Linux and MacOS systems, install .NET Core and PowerShell Core. To write and debug PowerShell scripts, install the [Visual Studio Code](https://code.visualstudio.com) editor and add the [PowerShell Language Support](https://marketplace.visualstudio.com/items?itemname=ms-vscode.powershell).

All of the recent versions of Windows desktop and server operating systems
include versions of PowerShell and the [Integrated Script
Environment](https://technet.microsoft.com/en-us/library/dd315244.aspx) (ISE)
for editing PowerShell scripts.

To install the latest version of PowerShell on older Windows systems, install
the Windows Management Framework (WMF). WMF is a package of the latest version
of PowerShell, along with PowerShell Desired State Configuration (DSC).

Current versions of PowerShell include features to install extra modules from remote repositories. By default, the public [PowerShell Gallery](http://www.powershellgallery.com) is configured as a repository.

# Running Scripts #

PowerShell files have the file extension of *.ps1*, regardless of the version of
PowerShell.

The current directory is not on the PATH by default. This means that you must
use relative or absolute paths when specifying a script to run, or when sourcing
one script from within another.

The *$args* collection contains the input parameters from the script file.

By default, PowerShell on older versions of Windows would only run interactive commands at the shell prompt. To
run local unsigned scripts, but still require scripts from the Internet to be
signed, set the policy to *RemoteSigned*:

~~~powershell
Set-ExecutionPolicy RemoteSigned
~~~

# Automating Windows Management with Ansible or Windows PowerShell DSC #

The [Ansible](https://www.ansible.com) automation tool uses PowerShell to
execute tasks on the Windows systems that it manages, with PowerShell Remoting and  [WinRM](https://msdn.microsoft.com/en-us/library/aa384426%28v=vs.85%29.aspx)
(Windows Remote Management) to communicate between the controller and the
targets.

[Windows PowerShell Desired State
Configuration](https://msdn.microsoft.com/en-us/PowerShell/DSC/overview) (DSC)
provides extensions for managing multiple remote Windows systems using
PowerShell, and also uses WinRM for communications. DSC does not need PowerShell
Remoting to be enabled on the target systems, only WinRM.

# Syntax #

In PowerShell, the operations are abstract. The same syntax works
on all of the types of *items*, which are .NET objects. Each abstract *drive*
object provides particular types of item. Each command is a *cmdlet* that
accepts items as inputs, and returns items as output.

This means that you construct pipelines by chaining PowerShell cmdlets together,
and the items are sent from one cmdlet to another. The experience appears
similar to UNIX shells, but is more flexible and consistent. For example, this
code gets a list of the name of all of the services on the system that have the
*Status* property with a value of *Stopped*:

~~~powershell
Get-Service | Where-Object { $_.Status -like 'Stopped'} | Select-Object Name
~~~

To specify a positional parameter, use space-separated values after the function
name. To set named parameters, specify them as switches.

PowerShell provides direct access to .NET classes. For example, this calls *DateTime.Today()*:

~~~powershell
$today = [datetime]::Today
~~~

The PowerShell language also supports the usual programming constructs, such as
variables and loops. Exception handlers are known as *traps* in PowerShell.

Within PowerShell files, you can enclose code in functions, or *script blocks*.
Functions are always named. Script blocks can be anonymous, or be assigned to
variables, and can optionally return a value.

## Variables and Collections ##

In PowerShell, variables are prefixed by a *$* character:

~~~powershell
$name = "Your Name"
~~~

Arrays are defined with round brackets:

~~~powershell
@('First', 'Second')
~~~

Hash tables are defined with curly braces:

~~~powershell
@{1='First', 2='Second'}
~~~

## Conditionals #

PowerShell supports the standard *if/else* syntax. Write the condition within
round brackets, and follow it with a script block:

~~~powershell
if ($file.Name -like "*.log"){
  Write-Host "Log: " $file.Name
}
elseif ($file.Name -like "*.txt") {
  Write-Host "Plain-Text: " $file.Name
}
else {
  Write-Host "Might Be a Binary: " $file.Name
}
~~~

PowerShell also supports switch/case statements:

~~~powershell
switch (<variable>) {
value1 { <action1> } value2 { <action2> }
...
default { <default action}
}
~~~

## Loops ##

The basic loop statement is *foreach*:

~~~powershell
foreach ($file in $dir){
  Write-Host $file;
}
~~~

This is actually a shortcut for *ForEach-Object*. You can use *ForEach-Object* in pipelines:

~~~powershell
Get-Service | Where-Object { $_.Name -ilike '*Web*' } | ForEach-Object { $_.Name + ' - ' + $.Status }
~~~

# Functions #

Functions are named script blocks. Use this syntax to declare a function:

~~~powershell
function <name>(<parameter list>)
{
    #function body
}
~~~

Use the standard verb-noun format for function names, e.g. *Get-Service*.

PowerShell supports *implicit return*, but you may also include a *return*
statement to have the function immediately end and return a value.

You may set the types and default values for parameters in the function definition:

~~~powershell
function Some-Task($a = "bar", $b = "foo") {
    #function body
}

function Get-RandomNumber([int] $quantity) {
    #function body
}
~~~

Remember that you specify parameters by either position or name when you call a function:

~~~powershell
Some-Task "this" -b "that"
~~~

To enable your function to work as part of a pipeline, define a *process*
section inside the function, and optionally *begin* and *end* sections.

To declare a *filter*, use the keyword *filter*, rather than *function*.

Internally, each function is actually an instance of the .NET class
*System.Management.Automation.FunctionInfo*, and filters are instances of
*System.Management.Automation.FilterInfo*.

## Error Handling ##

Every cmdlet must support the parameters *ErrorAction*, *ErrorVariable*, *Debug*, and *Verbose*. This means that you can specify the error handling behaviour for each command that you run by setting these parameters.

The *ErrorVariable* is a variable that will hold any error message that is generated. If more than one error is produced, the variable will be a collection.

The *ErrorAction* parameter accepts one of these options:

* *Continue* - The default, where the error is printed but the operation continues
* *Stop* - Raise an error, which will cause the operation to exit unless there is an error trap in place
* *SilentlyContinue* - Continue without printing an error message
* *Inquire* - Pause and prompt the user

For example:

~~~powershell
del *.log -ErrorAction Inquire
~~~

To handle particular types of errors in your code, use *error traps*. These are the equivalent of exceptions in PowerShell.

~~~powershell
trap [System.Management.Automation.PSInvalidCastException] {
  # code
}
~~~

# Resources #

* [Microsoft introductory video tutorial ](http://www.microsoftvirtualacademy.com/training-courses/advanced-tools-scripting-with-powershell-3-0-jump-start)
* [PowerShell Magazine](http://www.powershellmagazine.com/)
* [AWS Tools for Windows PowerShell](https://aws.amazon.com/powershell/) - Modules for managing the Amazon Web Services.
* [Azure PowerShell](https://azure.microsoft.com/en-us/documentation/articles/powershell-install-configure/) - Modules for managing the Microsoft cloud services.

# Common Commands #

Unless otherwise noted, these are all valid for PowerShell for Windows 4.0 and above, and PowerShell Core.

Run *Get-Alias* to see a list of the PowerShell commands that have shortcuts.
The [Wikipedia page](https://en.wikipedia.org/wiki/Windows_PowerShell) also
lists common commands.

## Integrated Help System ##

* *Update-Help* - Update the help for installed PowerShell modules
* *Get-Help ITEM* - View the help for the ITEM

## PowerShell Modules ##

* *Find-Module NAME* - Search the repositories for installable modules
* *Install-Module NAME* - Install the specified module from an available repository
* *Uninstall-Module NAME* - Delete the specified module from the system
* *Remove-Module NAME* - Removes a module from the current session only

## Network Interfaces ##

* *Get-NetAdapter* - List network interfaces (Windows-only)
* *Get-NetAdapter ADAPTER* - Show settings for network interface (Windows-only)
* *Set-NetAdapter INTERFACE* - Set settings for network interface (Windows-only)

## Network Clients ##

* *Resolve-DnsName NAME* - Gets the DNS records for the specified NAME (Windows-only)
* *Invoke-Webrequest URL* - HTTP request to URL
* *Test-Connection ADDRESS* - ICMP ping to the specified address (Windows-only)
* *Send-MailMessage* - Send an email (requires PowerShell for Windows 5.0 or above)

## Services ##

* *Get-Process* - List the running processes
* *Stop-Process PROCESS_ID* - Stop a running process
* *Get-Service* - List the registered services (Windows-only)
* *Restart-Service SERVICE-NAME* - Restart the service SERVICE-NAME (Windows-only)
* *Start-Service SERVICE-NAME* - Start the service SERVICE-NAME (Windows-only)
* *Stop-Service SERVICE-NAME* - Stop the service SERVICE-NAME (Windows-only)
* *Get-EventLog LOG-NAME* - Fetch the specified log (Windows-only)

## System ##

* *$env:COMPUTERNAME* - Gets the current system DNS hostname (Windows-only)
* *Rename-Computer -NewName NAME* - Sets the system DNS hostname (Windows-only)
* *Get-Date* - Gets the current system date and time
* *Set-Date DATE* - Sets the system date and time
* *Get-WinSystemLocale* - Gets the current system locale (Windows-only)
* *Set-WinSystemLocale NAME* - Sets the system locale, e.g. *en-GB* (Windows-only)
* *Restart-Computer* - Reboot the system (Windows-only)
* *Stop-Computer* - Shutdown the system (Windows-only)
* *$PSVersionTable* - Get PowerShell version
* *[System.Environment]::OSVersion.Version* - Get operating system version (Windows-only)

## Objects ##

* *Get-ChildItem OBJECT* - List the child objects of an object
* *Get-Member OBJECT* - List the members of an object
* *Select-Object PROPERTY1,PROPERTY2* - Shows the specified properties for a collection of objects
* *Where-Object { CODE }* - Filters a collection of objects
* *Measure-Object -property* - Show aggregate statistics for *property*
* *Sort-Object PROPERTY1 -descending* - Sorts a collection of objects by the given property

## Input and Output ##

* *Get-Content FILE* - Output the contents of the file
* *Set-Content FILE TEXT* - Write the text to the file
* *Add-Content FILE TEXT* - Append the text to the file
* *Remove-Item ITEM* - Delete the specified item (file or directory)
* *Compress-Archive -LiteralPath ITEM -DestPath ARCHIVE* - Packs the specified item into a ZIP archive file
* *Expand-Archive ITEM* - Unpacks the specified ZIP archive file
