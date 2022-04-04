+++
Title = "Commonly Used Commands in PowerShell"
Slug = "powershell-commands"
Date = "2022-04-04T19:58:00+01:00"
Description = ""
Categories = ["automation", "devops"]
Tags = ["dotNET", "automation", "devops", "powershell", "windows"]
Type = "article"
Toc = true

+++

Commonly used commands in [PowerShell](https://microsoft.com/powershell).

<!--more-->

# Common Commands

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
* *Invoke-WebRequest URL | Select-Object -ExpandProperty Content | Out-File FILE* - Download a file
* *Test-Connection ADDRESS* - ICMP ping to the specified address
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
