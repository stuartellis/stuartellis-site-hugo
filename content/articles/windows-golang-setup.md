+++
Title = "Setting Up Windows for Go and Buffalo"
Slug = "windows-golang-setup"
Date = "2018-11-17T20:40:00+01:00"
Description = "Setting up Windows for development with Go and Buffalo"
Categories = ["devops", "programming"]
Tags = ["devops", "golang", "javascript", "windows"]
Type = "article"
Toc = true

+++

This is a set of notes for setting up Windows 10 as a development system for the
[Go](https://golang.org/) programming language, with the [Buffalo](https://gobuffalo.io)
Web framework. It does not use the
[Windows Subsystem for Linux](https://msdn.microsoft.com/en-us/commandline/wsl/about).

<!--more-->

# What You Need

To work with Go, you only need two things:

- [Go](https://golang.org/) itself
- [Git](https://git-scm.com/), for version control

To develop Web applications with Buffalo, you will also need two other pieces of
software:

- [Node.js](https://nodejs.org/), the run-time for JavaScript
- A database, such as [PostgreSQL](https://www.postgresql.org/)

You should also install a C compiler, even if you do not write C code. Go and Node.js
packages can use libraries that are written in C, and these packages will require a C
compiler to install themselves.

Rather installing and updating these tools yourself, use a package manager. This
tutorial explains how to set up the [Scoop](http://scoop.sh/) package manager and have
it install the other software that you need.

> If you download and install software yourself, always choose the 64-bit version. Only
> use 32-bit versions of Windows software if you know that you are using a 32-bit
> computer.

# Setting Up the Scoop Package Manager

First, run this command in a PowerShell window:

```powershell
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
```

Press _A_ when prompted. This ensures that PowerShell can run Scoop.

Enter this command in PowerShell to install Scoop:

```powershell
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
```

# Installing Go

To install Go using Scoop, enter this command in a PowerShell window:

    scoop install go

If you do not use Scoop, go to the [Go Web site](https://golang.org/) and follow the
[Download Go](https://golang.org/dl/) link to find a Windows installer.

The Go tool will automatically create a folder called _go_ in your user account when it
is needed. This is your [Go workspace](https://golang.org/doc/code.html#Workspaces). To
ensure that Go applications run, you must add the _bin_ folder in your workspace to your
PATH. Run this in a PowerShell window to update your PATH:

```powershell
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$($env:HOMEDRIVE)$($env:HOMEPATH)\go\bin", [EnvironmentVariableTarget]::User)
```

# Installing the Git Version Control System

To install Git using Scoop, enter this command in a PowerShell window:

    scoop install openssh git

If you do not use Scoop, go to the [Git Web site](http://www.git-scm.com/) and follow
the link for _Downloads_ to find a Windows installer.

### Configuring Git

Once you have installed Git on a system, set your details. These are automatically
applied to every commit that you make. This requires two commands:

    git config --global user.name "Your Name"
    git config --global user.email "you@your-domain.com"

The _global_ option means that the setting will apply to every repository that you work
with in the current user account.

### Creating SSH Keys

You will frequently use SSH to access Git repositories or remote UNIX systems. The Git
package includes the standard OpenSSH suite of tools.

To create an SSH key, run the _ssh-keygen_ command in a Git terminal window. For
example:

    ssh-keygen -t rsa -b 4096 -C "Me MyName (MyDevice) <me@mydomain.com>"

> Use 4096-bit RSA keys for all systems. The older DSA standard only supports 1024-bit
> keys, which are now too small to be considered secure.

For more on how to use SSH with GitHub,
[see the GitHub setup guide](https://help.github.com/articles/connecting-to-github-with-ssh/).
GitHub also provide
[tips for troubleshooting SSH problems](https://help.github.com/articles/troubleshooting-ssh/).

# Installing a Text Editor

The Notepad text editor in Windows is designed for light-weight word processing, and has
no support for programming, so you will have to install a code editor. If you would like to use an IDE, JetBrains
offer [GoLand](https://www.jetbrains.com/go/) as a commercial product.

# Installing Node.js

[Node.js](https://nodejs.org/) is the run-time for JavaScript. It also includes
[npm](https://www.npmjs.com/), a package manager for JavaScript.

To install Node.js using Scoop, enter this command in a PowerShell window:

    scoop install nodejs-lts

This installs the current LTS (Long-term Support) version of Node.js. The Node.js
project provides other versions that are specifically for early-adopters.

If you do not use Scoop, go to the [Node.js Web site](https://nodejs.org/) and follow
the link for _Downloads_ to find a Windows installer.

# Databases

If you are not sure which database product to use, install
[PostgreSQL](https://www.postgresql.org/). PostgreSQL is a full SQL database product
with support for advanced features such as full-text search and JSON document storage.
Use PostgreSQL for Web applications. The default configuration of PostgreSQL only uses a
small amount of memory and CPU, so you can install it even on computers with limited
resources.

### Installing PostgreSQL

To install PostgreSQL using Scoop, enter this command in a PowerShell window:

    scoop install postgresql

This does not create databases, or start the PostgreSQL service. Before you start the
service, create the required directories and databases:

    mkdir $env:HOMEPATH\pgsql\databases
    mkdir $env:HOMEPATH\pgsql\logs
    pg_ctl initdb -D $env:HOMEPATH\pgsql\databases

To start PostgreSQL:

    pg_ctl -D $env:HOMEPATH\pgsql\databases -l $env:HOMEPATH\pgsql\logs\server.log

Once PostgreSQL is running, test it by logging in with the _psql_ utility:

    psql -d template1

This sets the working database as the standard _template1_ database. Once you have
logged in, enter _\q_ to exit the console.

Use the _pg_ctl_ utility to manage PostgreSQL:

    pg_ctl --help

# Installing a C Compiler

[GCC](https://gcc.gnu.org/) is the standard compiler and tools for Free and Open Source
libraries that are written in the C programming language. The
[mingw-w64](http://mingw-w64.org) project provide releases of GCC for Windows.

To install GCC using Scoop, enter this command in a PowerShell window:

    scoop install gcc

# Installing Buffalo

To install Buffalo, enter this command in a PowerShell window:

    go get -u -v github.com/gobuffalo/buffalo/buffalo

Once it is installed, use the _buffalo_ utility to create and manage your Web
applications.

# Updating Your Tools

Use Scoop to upgrade your software as new versions become available.

To update the index of available packages, run this command in a PowerShell window:

    scoop update

To upgrade a specific application, give the name of the product as an option to the
_scoop update_ command. For, example this command upgrades Go:

    scoop update go

To upgrade all of the software that Scoop manages, use an asterisk instead of the name
of an application:

    scoop update *

Atom has a built-in update system. It will automatically display a message when you
should update either the editor, or one of the packages that you have installed.

To upgrade Buffalo, enter this command in a PowerShell window:

    go get -u -v github.com/gobuffalo/buffalo/buffalo

The _-u_ option means that if you already have a copy of Buffalo, it will be upgraded.
