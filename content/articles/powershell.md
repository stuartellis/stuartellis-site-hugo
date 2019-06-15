+++
Title = "Notes on PowerShell"
Slug = "powershell"
Date = "2019-04-03T18:39:00+01:00"
Description = ""
Categories = ["automation", "devops"]
Tags = [".NET", "automation", "devops", "powershell", "windows"]
Type = "article"
Toc = true

+++

The least that you need to know about [PowerShell](https://microsoft.com/powershell).

<!--more-->

# Why PowerShell Matters

PowerShell is both an object-oriented shell that is built on .NET, and a custom programming language that runs
within that shell. Third-parties such as VMWare and Amazon Web Services provide
modules to enable users to work with their products through PowerShell.

You can
also supplement the capabilities of PowerShell modules by directly accessing
classes from the underlying installation of .NET, and by running standard
commands and scripts from the host operating system.

# PowerShell Editions #

Windows PowerShell is the older, proprietary implementation of PowerShell that is
shipped with most versions of Windows. It is sometimes referred to as the
*Desktop* edition. Windows PowerShell is still maintained, but will receive no new features. The intention is to replace it with PowerShell Core.

PowerShell Core is the latest implementation of PowerShell. It is built with .NET Core to be cross-platform and Open Source. For consistency with the version numbers of Windows PowerShell, the first full release of PowerShell Core has 6.0 as the version number.

# Installing PowerShell #

### Windows ###

All of the recent versions of Windows desktop and server operating systems
include versions of Windows PowerShell and the [Integrated Script
Environment](https://technet.microsoft.com/en-us/library/dd315244.aspx) (ISE)
for editing PowerShell scripts. Windows 10 and Windows Server 2016 provide Windows
PowerShell 5.1. Microsoft now recommend that you use Visual Studio Code for writing PowerShell code, rather than ISE.

To install the latest version of PowerShell 5 on older Windows systems, install
the Windows Management Framework (WMF). WMF is a package of the latest version
of PowerShell, along with PowerShell Desired State Configuration (DSC).

You may install PowerShell Core on Windows systems. If you install PowerShell Core on Windows it does not replace the version of Windows PowerShell that is already provided by the operating system.

### macOS and Linux ###

To use PowerShell on Linux and macOS systems, install [PowerShell Core](https://github.com/powershell/powershell).

Follow [these instructions](https://github.com/powershell/powershell#telemetry) to disable the telemetry in PowerShell Core. The PowerShell Core installer creates a directory called `/usr/local/microsoft/`, with one subdirectory per PowerShell installation.

### Tools ###

The current versions of PowerShell include features to install extra modules from
remote repositories. By default, the public [PowerShell Gallery](http://www.powershellgallery.com) is configured as a repository.

To write and debug PowerShell scripts, install the [Visual Studio Code](https://code.visualstudio.com) editor and add the [PowerShell Language Support](https://marketplace.visualstudio.com/items?itemname=ms-vscode.powershell) extension. This extension includes support for the [Pester](https://github.com/pester/Pester) testing framework, and [PSScriptAnalyzer](https://www.powershellgallery.com/packages/PSScriptAnalyzer), which is the recommended static code analyzer for PowerShell. Use [Plaster](https://github.com/PowerShell/Plaster) to generate new projects from standard templates.

# Running PowerShell #

### Running an Interactive Session ###

All current editions of Windows include a version of PowerShell, and display icons for it. PowerShell Core does not replace Windows PowerShell or other existing shells on your computer. You must specifically choose to run it.

Type *pwsh* in a Terminal window to start a PowerShell Core session:

    pwsh

### Running Scripts ###

PowerShell files have the file extension of *.ps1*, regardless of the version of
PowerShell.

The current directory is not on the PATH by default. This means that you must
use relative or absolute paths when specifying a script to run, or when sourcing
one script from within another.

The *$args* collection contains the input parameters from the script file.

By default, Windows PowerShell only runs interactive commands at the shell
prompt. To run local unsigned scripts, but still require scripts from the
Internet to be signed, set the policy to *RemoteSigned*:

~~~powershell
Set-ExecutionPolicy RemoteSigned
~~~

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

PowerShell provides direct access to .NET classes. For example, this calls
*DateTime.Today()*:

~~~powershell
$today = [datetime]::Today
~~~

The PowerShell language also supports the usual programming constructs, such as
variables and loops. Exception handlers are known as *traps* in PowerShell.

Within PowerShell files, you can enclose code in functions, or *script blocks*.
Functions are always named. Script blocks can be anonymous, or be assigned to
variables, and can optionally return a value.

### Variables and Collections ###

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

To access an environment variable, use *$env*. For example, to read the *PATH* environment variable:

~~~powershell
$env:PATH
~~~

### Conditionals #

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

### Loops ###

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

Remember that you specify parameters by either position or name when you call a
function:

~~~powershell
Some-Task "this" -b "that"
~~~

To enable your function to work as part of a pipeline, define a *process*
section inside the function, and optionally *begin* and *end* sections.

To declare a *filter*, use the keyword *filter*, rather than *function*.

Internally, each function is actually an instance of the .NET class
*System.Management.Automation.FunctionInfo*, and filters are instances of
*System.Management.Automation.FilterInfo*.

### Error Handling ###

Every cmdlet must support the parameters *ErrorAction*, *ErrorVariable*,
*Debug*, and *Verbose*. This means that you can specify the error handling
behaviour for each command that you run by setting these parameters.

The *ErrorVariable* is a variable that will hold any error message that is
generated. If more than one error is produced, the variable will be a
collection.

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

# The Shell Profile #

Your PowerShell profile is a PowerShell script that runs each time that you start a PowerShell session. Use your profile to import modules that you use very frequently, or set useful variables. By default, your profile is empty.

The $PROFILE variable stores the path to the profile for the current user. To edit your profile, start your editor from PowerShell and specify $PROFILE as the file to edit. For example, to edit your PowerShell profile with Visual Studio Code, start *code*:

    code $PROFILE

# Accessing Remote Systems #

By default, PowerShell accesses remote systems by connecting to the Windows Remote Management (WinRM) service on those systems, using the WS-MAN protocol. Microsoft are adding SSH support to Windows and PowerShell as an alternative to WinRM and WS-MAN.

Current versions of Windows Server enable WinRM, and allow users with administrative rights to log in. For other versions of Windows, you must first run the *Enable-PSRemoting* cmdlet to set up remote access.

By default, PowerShell uses the credentials of the logged in user.

### Moving Between Local and Remote Systems ###

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

### Running Commands and Scripts on Remote Systems ###

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

### Automating Management with Ansible or Windows PowerShell DSC ###

The [Ansible](https://www.ansible.com) automation tool uses PowerShell to
execute tasks on the Windows systems that it manages, with PowerShell Remoting and [WinRM](https://msdn.microsoft.com/en-us/library/aa384426%28v=vs.85%29.aspx)
(Windows Remote Management) to communicate between the controller and the
targets. This means that PowerShell Remoting must be enabled on all of the Windows systems that you woul like to manage with Ansible.

[Windows PowerShell Desired State
Configuration](https://msdn.microsoft.com/en-us/PowerShell/DSC/overview) (DSC)
provides extensions for managing multiple remote Windows systems using
PowerShell, and also uses WinRM for communications. DSC does not need PowerShell
Remoting to be enabled on the target systems, only WinRM.

# Managing Cloud Infrastructure with PowerShell #

Amazon Web Services, Google Cloud Platform and Microsoft Azure all provide PowerShell modules for working with their infrastructure. You will need to install the modules for the platforms that you use.

To install the AWS Tools for PowerShell Core:

~~~powershell
Install-Module -Scope CurrentUser -Name AWSPowerShell.NetCore -Force
~~~

Once you have installed the module, you will need to import it into your session, and set the necessary credentials. For AWS, this means that you must set an AWS profile, and specify the default AWS region for your operations.

By default, PowerShell Core reads and writes credentials into an encrypted store. If you have already created AWS profiles in plain-text files with the AWS CLI or libraries, it will also read those files.

~~~powershell
# Import the module
Import-Module AWSPowerShell.NetCore
# Use the AWS profile named "default"
Set-AWSCredential -ProfileName default
# Set the default AWS region
Set-DefaultAWSRegion -Region us-west-1
~~~

Once the module and credentials are in your session, you may use AWS cmdlets to manage your infrastructure. The module also defines [aliases for the cmdlets](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-discovery-aliases.html), and a special [$AWSHistory variable](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-pipelines.html).

If you do not import the AWS module, it will automatically be loaded the first time that you use an AWS cmdlet.

To upgrade the PowerShell module for AWS, you must uninstall the existing version, and then install the latest version:

~~~powershell
Uninstall-Module -Name AWSPowerShell.NetCore -AllVersions
PS> Install-Module -Name AWSPowerShell.NetCore
~~~

# Resources #

### Videos ###

* [Microsoft introductory video course](https://mva.microsoft.com/en-US/training-courses/getting-started-with-microsoft-powershell-8276)
* [Microsoft video course on using PowerShell with SQL Server](https://mva.microsoft.com/en-US/training-courses/powershell-for-sql-data-professionals-16532?l=XgA5w0PgC_8805121157)
* [Microsoft video tutorial on testing with Pester](https://mva.microsoft.com/en-US/training-courses/testing-powershell-with-pester-17650?l=mg8oBM9vD_8811787177)

### Websites ###

* [Awesome PowerShell](https://github.com/janikvonrotz/awesome-powershell) - Curated list of resources and modules for PowerShell
* [Planet PowerShell](https://www.planetpowershell.com/) - Blog aggregator for the PowerShell community
* [PowerShell.org](https://powershell.org/) - Community forums for PowerShell users
* [PowerShell Magazine](http://www.powershellmagazine.com/)

### Books ###

* [PowerShell Notes for Professionals book](http://goalkicker.com/PowerShellBook/) - Free ebook
* [Secrets of PowerShell](https://www.penflip.com/powershellorg/) - A series of free short e-books from PowerShell.org

# Extra Modules #

* [AWS Tools for Windows PowerShell](https://aws.amazon.com/powershell/) - Modules for managing Amazon Web Services
* [Azure PowerShell](https://azure.microsoft.com/en-us/documentation/articles/powershell-install-configure/) - Modules for managing Microsoft Azure cloud services
* Google's [Cloud Tools for PowerShell](https://cloud.google.com/powershell/) - Modules for managing Google Cloud Platform services
* [dbachecks](https://github.com/sqlcollaborative/dbachecks) - Microsoft SQL Server Environmental Validation
* [dbatools](https://dbatools.io/) - Community module of tools for Microsoft SQL Server
* [posh-git](https://dahlbyk.github.io/posh-git/) - Git integration for PowerShell
* [psake](https://github.com/psake/psake) - Build tool
* [Pscx](https://github.com/Pscx/Pscx) - PowerShell Community Extensions module repository
* [PSSlack](https://github.com/RamblingCookieMonster/PSSlack/) - Third-party module for Slack
* [PSWindowsUpdate](https://gallery.technet.microsoft.com/scriptcenter/2d191bcd-3308-4edd-9de2-88dff796b0bc) - Third-party module to manage and run Microsoft Updates on Windows systems, as explained in [this tutorial](https://www.petri.com/manage-windows-updates-with-powershell-module)
* [SqlServer](https://www.powershellgallery.com/packages/Sqlserver/21.0.17224) - Current official module for Microsoft SQL Server, which replaces SQLPS
* [VMWare PowerCLI](https://www.vmware.com/support/developer/PowerCLI/index.html) - PowerShell modules for managing VMware products

# Common Commands #

Unless otherwise noted, these are all valid for PowerShell for Windows 4.0 and
above, and PowerShell Core.

Run *Get-Alias* to see a list of the PowerShell commands that have shortcuts.
The [Wikipedia page](https://en.wikipedia.org/wiki/Windows_PowerShell) also
lists common commands.

### Integrated Help System ###

* *Update-Help* - Update the help for installed PowerShell modules
* *Get-Help ITEM* - View the help for the ITEM

### PowerShell Modules ###

* *Find-Module NAME* - Search the repositories for installable modules
* *Install-Module NAME* - Install the specified module from an available repository
* *Uninstall-Module NAME* - Delete the specified module from the system
* *Remove-Module NAME* - Removes a module from the current session only
* *$PSVersionTable* - Display the table of components versions for PowerShell itself

### Network Interfaces ###

* *Get-NetAdapter* - List network interfaces (Windows-only)
* *Get-NetAdapter ADAPTER* - Show settings for network interface (Windows-only)
* *Set-NetAdapter INTERFACE* - Set settings for network interface (Windows-only)

### Network Clients ###

* *Resolve-DnsName NAME* - Gets the DNS records for the specified NAME (Windows-only)
* *Invoke-Webrequest URL* - HTTP request to URL
* *Test-Connection ADDRESS* - ICMP ping to the specified address (Windows-only)
* *Send-MailMessage* - Send an email (requires PowerShell for Windows 5.0 or above)

Use *Copy-Item* to transfer files over Windows file-sharing or PowerShell Remoting.

### Services ###

* *Get-Process* - List the running processes
* *Stop-Process PROCESS_ID* - Stop a running process
* *Get-Service* - List the registered services (Windows-only)
* *Restart-Service SERVICE-NAME* - Restart the service SERVICE-NAME (Windows-only)
* *Start-Service SERVICE-NAME* - Start the service SERVICE-NAME (Windows-only)
* *Stop-Service SERVICE-NAME* - Stop the service SERVICE-NAME (Windows-only)
* *Get-EventLog LOG-NAME* - Fetch the specified log (Windows-only)

### System ###

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

### Objects ###

* *Get-ChildItem OBJECT* - List the child objects of an object
* *Get-Member OBJECT* - List the members of an object
* *Select-Object PROPERTY1,PROPERTY2* - Shows the specified properties for a collection of objects
* *Select-String STRING* - Finds text in strings and files
* *Where-Object { CODE }* - Filters a collection of objects
* *Measure-Object -property* - Show aggregate statistics for *property*
* *Sort-Object PROPERTY1 -descending* - Sorts a collection of objects by the given property

### Input and Output ###

* *Get-Content FILE* - Output the contents of the file
* *Set-Content FILE TEXT* - Write the text to the file
* *Add-Content FILE TEXT* - Append the text to the file
* *Copy-Item SOURCE DESTINATION* - Copies the specified item (file or directory)
* *Remove-Item ITEM* - Delete the specified item (file or directory)
* *Compress-Archive -LiteralPath ITEM -DestPath ARCHIVE* - Packs the specified item into a ZIP archive file
* *Expand-Archive ITEM* - Unpacks the specified ZIP archive file
