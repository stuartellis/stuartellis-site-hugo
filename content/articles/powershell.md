+++
Title = "Notes on PowerShell"
Slug = "powershell"
Date = "2021-02-14T21:25:00+00:00"
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
within that shell. Third-parties such as [VMWare](https://developer.vmware.com/powercli) and [Amazon Web Services](https://aws.amazon.com/powershell/) provide
modules to enable users to work with their products through PowerShell.

You can
also supplement the capabilities of PowerShell modules by directly accessing
classes from the underlying installation of .NET, and by running standard
commands and scripts from the host operating system.

# PowerShell Versions #

PowerShell 7 is the current version of PowerShell. It is built with .NET Core to be cross-platform and Open Source. It replaces Windows PowerShell and PowerShell Core.

Windows PowerShell is the older, proprietary implementation of PowerShell that is
shipped with most versions of Microsoft Windows. It is sometimes referred to as the
*Desktop* edition. Windows PowerShell is still maintained, but will receive no new features. The intention is to replace it with PowerShell 7.

PowerShell Core was the first Open Source version of PowerShell. Releases of PowerShell Core were designated as PowerShell version 6.

# Installing PowerShell #

### Windows ###

All of the supported versions of Windows desktop and server operating systems
include Windows PowerShell and the [Integrated Script
Environment](https://docs.microsoft.com/en-us/powershell/scripting/windows-powershell/ise/introducing-the-windows-powershell-ise) (ISE)
for editing PowerShell scripts. Windows 10 and Windows Server 2016 provide Windows
PowerShell 5.1. 

> ISE is no longer developed. Microsoft now recommend that you use Visual Studio Code for writing PowerShell code, rather than ISE.

Install PowerShell 7 on Windows systems to get the current version of PowerShell. PowerShell 7 does not replace the version of Windows PowerShell that is already provided by the operating system. Instead, it is installed as a completely separate application.

To install Windows PowerShell 5 on older Windows systems, you must install
the Windows Management Framework (WMF). WMF is a package of the latest version
of PowerShell, along with PowerShell Desired State Configuration (DSC).

### macOS and Linux ###

To use PowerShell on Linux and macOS systems, install [PowerShell 7](https://github.com/powershell/powershell).

Follow [these instructions](https://github.com/powershell/powershell#telemetry) to disable the telemetry in PowerShell. The PowerShell installer creates a directory called `/usr/local/microsoft/`, with one subdirectory per PowerShell installation.

### Tools ###

PowerShell 7 includes features to install extra modules from
remote repositories. By default, the public [PowerShell Gallery](http://www.powershellgallery.com) is configured as a repository.

To write and debug PowerShell scripts, install the [Visual Studio Code](https://code.visualstudio.com) editor and add the [PowerShell Language Support](https://marketplace.visualstudio.com/items?itemname=ms-vscode.powershell) extension. This extension includes support for the [Pester](https://github.com/pester/Pester) testing framework, and [PSScriptAnalyzer](https://www.powershellgallery.com/packages/PSScriptAnalyzer), which is the recommended static code analyzer for PowerShell. Use [Plaster](https://github.com/PowerShell/Plaster) to generate new projects from standard templates.

# Running PowerShell #

### Running an Interactive Session ###

All of the current editions of Windows include a version of Windows PowerShell, and display icons for it. PowerShell 7 does not replace Windows PowerShell or other existing shells on your computer. You must specifically choose to run it.

Type *pwsh* in a Terminal window to start a PowerShell 7 session:

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
similar to UNIX shells, but it is more flexible and consistent. For example, this
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

> *ForEach-Object* supports parallel execution of iterations in PowerShell 7 and above.

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

# Formatting Output #

Use *Out-Host* to print to the console. Add *-Paging* to paginate the output:

~~~powershell
Get-ChildItem . | Out-Host -Paging
~~~

To convert PowerShell objects to or from a known data format, use the *ConvertTo* and *ConvertFrom* cmdlets.

~~~powershell
Get-ChildItem . | ConvertTo-Csv
~~~

PowerShell includes full support for these formats:

- CSV
- HTML
- JSON
- XML

In addition, it can convert from Markdown and strings (*StringData*).

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

* [dbachecks](https://github.com/sqlcollaborative/dbachecks) - Microsoft SQL Server Environmental Validation
* [dbatools](https://dbatools.io/) - Community module of tools for Microsoft SQL Server
* [posh-git](https://dahlbyk.github.io/posh-git/) - Git integration for PowerShell
* [psake](https://github.com/psake/psake) - Build tool
* [Pscx](https://github.com/Pscx/Pscx) - PowerShell Community Extensions module repository
* [PSSlack](https://github.com/RamblingCookieMonster/PSSlack/) - Third-party module for Slack
* [PSWindowsUpdate](https://www.powershellgallery.com/packages/PSWindowsUpdate) - Third-party module to manage and run Microsoft Updates on Windows systems, as explained in [this tutorial](https://www.petri.com/manage-windows-updates-with-powershell-module)
* [SqlServer](https://www.powershellgallery.com/packages/Sqlserver/21.0.17224) - Current official module for Microsoft SQL Server, which replaces SQLPS


