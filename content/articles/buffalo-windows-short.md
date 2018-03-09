+++
Title = "Get Rolling with Buffalo on Windows"
Slug = "buffalo-windows-short"
Date = "2017-08-25T19:04:00+01:00"
Description = "Getting started with Buffalo on Windows"
Categories = ["programming"]
Tags = ["administration", "golang", "javascript", "windows"]
Type = "article"
Draft = true

+++

This is the short summary of how to start developing Web applications on Windows
with [Buffalo](http://gobuffalo.io). The [Go on 
Windows](http://www.stuartellis.name/articles/windows-golang-setup) article
provides a more detailed version.

<!--more-->

# Go on Windows #

First, let's install [Scoop](http://scoop.sh/), to manage your tools.

Open a PowerShell window, and enter this command:

~~~powershell
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
~~~

Press *A* when prompted. This ensures that PowerShell can run Scoop.

Next, install Scoop:

~~~powershell
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
~~~

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
applications that you compile in the workspace run correctly, enter this in a PowerShell window to register the correct folder:

~~~powershell
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$($env:HOMEDRIVE)$($env:HOMEPATH)\go\bin", [EnvironmentVariableTarget]::User)
~~~

# Get Buffalo #

To install Buffalo:

    go get -u -v github.com/gobuffalo/buffalo/...

Once it is installed, use the *buffalo* utility to create and manage your Web applications.