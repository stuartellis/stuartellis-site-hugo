+++
Title = "Setting Up Windows for Software Development with Go"
Slug = "windows-golang-setup"
Date = "2017-08-05T18:10:00+01:00"
Description = "Setting up Windows for development with Go"
Categories = ["administration", "programming"]
Tags = ["administration", "golang", "javascript", "windows"]
Type = "article"

+++


This is a set of notes for setting up a Windows 10 system, specifically as a
development system for the [Go](https://golang.org/) programming language.

<!--more-->

# What You Need #

To work with Go, you only need three things:

* [Go](https://golang.org/) itself
* A text editor that understands Go, such as [Atom](https://atom.io/)
* [Git](https://git-scm.com/), for version control

To develop Web applications, you will also need some other pieces of software:

* [Node.js](https://nodejs.org/), the run-time for JavaScript
* A database, such as [SQLite](https://sqlite.org/) or [PostgreSQL](https://www.postgresql.org/)
* A compiler for C, so that downloaded C libraries will build on your computer

Go, Node.js and many other systems can use libraries that are written in C, so
you should install GCC even if you do not write C code.

Rather installing and updating these tools yourself, use a package manager.
This tutorial explains how to set up the [Scoop](http://scoop.sh/)
package manager and have it install the other software that you need.

> If you download and install software yourself, always choose
the 64-bit version. Only use 32-bit versions of Windows software if you know
that you are using a 32-bit computer.

# Setting Up the Scoop Package Manager #

To install Scoop, run these commands in a PowerShell window:

    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')

# Installing Go #

To install Go using Scoop, enter this command in a PowerShell window:

    scoop install go

If you do not use Scoop, go to the [Go Web site](https://golang.org/) and
follow the [Download Go](https://golang.org/dl/) link to find a Windows
installer.

The Go tool will automatically create a folder called *go* in your user account
when it is needed. This is your [Go
workspace](https://golang.org/doc/code.html#Workspaces).

# Installing the Git Version Control System #

To install Git using Scoop, enter this command in a PowerShell window:

    scoop install openssh git
    [environment]::setenvironmentvariable('GIT_SSH', (resolve-path (scoop which ssh)), 'USER')

If you do not use Scoop, go to the [Git Web site](http://www.git-scm.com/)
and follow the link for *Downloads* to find a Windows installer.

To use Git to access remote code repositories, you should create an SSH key for
yourself, as explained at the end of this document.

## Configuring Git ##

Once you have installed Git on a system, set your details. These are
automatically applied to every commit that you make. This requires two commands:

    git config --global user.name "Your Name"
    git config --global user.email "you@your-domain.com"

The *global* option means that the setting will apply to every
repository that you work with in the current user account.

To enable colors in the output, which can be very helpful, enter this
command:

    git config --global color.ui auto

# Installing a Text Editor #

The Notepad text editor in Windows is designed for light-weight word processing,
and has no support for programming. Unless you already have a preferred editor,
install [Atom](http://www.atom.io), which is a powerful Open Source text editor.

## Atom ##

To install Atom, download the latest version from the project Website.

Current versions of Atom include support for Git. You will massively improve
your experience with your text editor by installing a few more plugins to it.

To install Atom packages, either choose or use the *apm* command in a terminal
window. Run this command to add the [go-plus](https://atom.io/packages/go-plus)
package, which turns Atom into a development environment for Go:

    apm install go-plus

The next time that you open Atom, you will see go-plus automatically download
and configure all of the tools that it needs. go-plus will ask you to restart
Atom once for the changes to take effect.

Run this command to install other useful packages for Atom:

    apm install file-icons linter-csslint linter-eslint linter-js-yaml

The [file-icons](https://atom.io/packages/file-icons) package adds colourful
icons for different types of file. Linter packages automatically check your
files for errors and other potential problems. Each linter works with specific
types of file. For example, the ESLint plugin checks JavaScript files.

## Visual Studio Code ##

To install Visual Studio Code, download the latest version from the project Website.

Be sure to add the [Go
package](https://code.visualstudio.com/docs/languages/go), which turns Visual
Studio Code into a development environment for Go.

# Installing Node.js #

[Node.js](https://nodejs.org/) is the run-time for JavaScript. It also includes
[npm](https://www.npmjs.com/), a package manager for JavaScript.

To install Node.js using Scoop, enter this command in a PowerShell window:

    scoop install nodejs-lts

This installs the current LTS (Long-term Support) version of Node.js. The
Node.js project provides other versions that are specifically for
early-adopters.

If you do not use Scoop, go to the [Node.js Web site](https://nodejs.org/)
and follow the link for *Downloads* to find a Windows installer.

# Databases #

If you are not sure which database product to use, install either
[SQLite](https://sqlite.org/) or [PostgreSQL](https://www.postgresql.org/).

SQLite creates SQL databases on demand, as files. This means that you can
develop applications without running a database service on your computer. SQLite
databases are intended for single-user systems, such as desktops and mobile
devices. Avoid using SQLite for Web applications that will be deployed to
servers. Use SQLite for desktop and command-line applications, or for learning
purposes.

PostgreSQL is a full SQL database product with support for advanced features
such as full-text search and JSON document storage. Use PostgreSQL for Web
applications. The default configuration of PostgreSQL only uses a small amount
of memory and CPU, so you can install it even on computers with limited
resources.

## Installing SQLite ##

To install SQLite using Scoop, enter this command in a PowerShell window:

    scoop install sqlite

## Installing PostgreSQL ##

To install PostgreSQL using Scoop, enter this command in a PowerShell window:

    scoop install postgresql

This does not create databases, or start the PostgreSQL service. Before you
start the service, create the required directories and databases:

    mkdir $env:HOMEPATH\pgsql\databases
    mkdir $env:HOMEPATH\pgsql\logs
    pg_ctl initdb -D $env:HOMEPATH\pgsql\databases

To start PostgreSQL:

    pg_ctl -D $env:HOMEPATH\pgsql\databases -l $env:HOMEPATH\pgsql\logs\server.log

Once PostgreSQL is running, test it by logging in with the *psql* utility:

    psql -d template1

This sets the working database as the standard *template1* database. Once you
have logged in, enter *\q* to exit the console.

Use the *pg_ctl* utility to manage PostgreSQL:

    pg_ctl --help

# Installing a C Compiler #

[GCC](https://gcc.gnu.org/) is the standard compiler and tools for Free and Open
Source libraries that are written in the C programming language. The
[mingw-w64](http://mingw-w64.org) project provide releases of GCC for Windows.

To install GCC using Scoop, enter this command in a PowerShell window:

    scoop install gcc

# Creating SSH Keys #

You will frequently use SSH to access Git repositories or remote UNIX systems.
The Git package includes the standard OpenSSH suite of tools.

To create an SSH key, run the *ssh-keygen* command in a Git terminal window. For
example:

    ssh-keygen -t rsa -b 4096 -C "Me MyName (MyDevice) <me@mydomain.com>"

> Use 4096-bit RSA keys for all systems. The older DSA standard only supports
1024-bit keys, which are now too small to be considered secure.

For more on how to use SSH with GitHub, [see the GitHub setup guide](https://help.github.com/articles/connecting-to-github-with-ssh/). GitHub
also provide [tips for troubleshooting SSH problems](https://help.github.com/articles/troubleshooting-ssh/).

# Updating Your Tools #

Use Scoop to upgrade your software as new versions become available.

To update the index of available packages, run this command in a PowerShell window:

    scoop update

To upgrade a specific application, give the name of the product as an option to
the *scoop update* command. For, example this command upgrades Go:

    scoop update go

To upgrade all of the software that Scoop manages, use an asterisk instead of
the name of an application:

    scoop update *

Atom and Visual Studio Code have their own update systems. They will
automatically display a message when you should update the editor or one of the
packages that you have installed.
