+++
Title = "Get Rolling with Buffalo on Windows"
Slug = "buffalo-windows-short"
Date = "2017-08-03T06:30:00+01:00"
Description = "Getting started with Buffalo on Windows"
Categories = ["programming"]
Tags = ["administration", "golang", "javascript", "windows"]
Type = "article"
Draft = true

+++

This is the short summary of how to start developing Web applications on Windows
with Buffalo. The [Go with
Windows](http://www.stuartellis.name/articles/windows-golang-setup) article provides a
more detailed version.

<!--more-->

# Go on Windows #

First, install [Chocolatey](https://chocolatey.org/) to manage your tools. Open
an Administrator window for PowerShell, and enter this command:

    Set-ExecutionPolicy AllSigned
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

You need to close all PowerShell windows for the changes to take effect.

    choco install gcc git golang nodejs postgresql

Next, open an Administrator window for PowerShell, and enter this command:

This installs:

* [Git](https://git-scm.com/), for version control
* [Node.js](https://nodejs.org/), the run-time for JavaScript
* [PostgreSQL](https://www.postgresql.org/), the database
* GCC compiler for C, so that downloaded C libraries will build on your computer

Lastly, if you do not have a text editor, install [Atom](http://www.atom.io) and
be sure to add the [go-plus](https://atom.io/packages/go-plus) package, which
turns Atom into a development environment for Go.

Enter this command in an Administrator window for PowerShell to install Atom:

    choco install atom

# Get Buffalo #

FIXME

# Create your Application #

FIXME
