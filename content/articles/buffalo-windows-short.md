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
with [Buffalo](). The [Go with
Windows](http://www.stuartellis.name/articles/windows-golang-setup) article provides a
more detailed version.

<!--more-->

# Go on Windows #

First, install [Chocolatey](https://chocolatey.org/) to manage your tools. Open
an Administrator window for PowerShell, and enter this command:

    Set-ExecutionPolicy AllSigned
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

You need to close all PowerShell windows for the changes to take effect.

Next, open an Administrator window for PowerShell, and enter this command:

    choco install git golang nodejs-lts sqlite

This installs:

* [Go](https://golang.org/) itself
* [Git](https://git-scm.com/), for version control
* [Node.js](https://nodejs.org/), the run-time for JavaScript
* [SQLite](https://sqlite.org/), for small databases

# Get Buffalo #

To install Buffalo:

    go get -u -v github.com/gobuffalo/buffalo/...
    go install -v github.com/gobuffalo/buffalo/buffalo

# Create your Application #

FIXME
