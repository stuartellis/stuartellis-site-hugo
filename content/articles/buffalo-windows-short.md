+++
Title = "Get Rolling with Buffalo on Windows"
Slug = "buffalo-windows-short"
Date = "2017-08-05T20:19:00+01:00"
Description = "Getting started with Buffalo on Windows"
Categories = ["programming"]
Tags = ["administration", "golang", "javascript", "windows"]
Type = "article"
Draft = true

+++

This is the short summary of how to start developing Web applications on Windows
with [Buffalo](http://gobuffalo.io). The [Go with
Windows](http://www.stuartellis.name/articles/windows-golang-setup) article
provides a more detailed version.

<!--more-->

# Go on Windows #

First, let's install [Scoop](http://scoop.sh/), to manage your tools.

Open a PowerShell window, and enter this command:

    Set-ExecutionPolicy RemoteSigned -scope CurrentUser

Press *A* when prompted. This ensures that PowerShell can run Scoop.

Next, install Scoop:

    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')

Now enter this command:

    scoop install gcc openssh git go nodejs-lts

This installs:

* [Go](https://golang.org/) itself
* The [GCC](http://mingw-w64.org) compiler, so that downloaded C libraries will build on your computer
* [Git](https://git-scm.com/), for version control
* [Node.js](https://nodejs.org/), the run-time for JavaScript

These are all of the things that Buffalo will need.

The Go tool will automatically create a folder called *go* in your user account
when it is needed. This is your [Go
workspace](https://golang.org/doc/code.html#Workspaces). To ensure that Go
applications run, you must add the *bin* folder in your workspace to your PATH:

1. Open *Control Panel*
2. Choose *System and Security* > *System* > *Advanced System Settings*
3. Click *Environment Variables...*
4. Select *Path* from the list of user variables and click *Edit...*
5. Click *New* and enter: *%HOMEPATH%\go\bin*
6. Click *OK* to exit

# Get Buffalo #

To install Buffalo:

    go get -u -v github.com/gobuffalo/buffalo/...
    go install -v github.com/gobuffalo/buffalo/buffalo

# Create your Application #

FIXME
