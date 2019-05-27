+++
Title = "Get Rolling with Buffalo on Windows"
Slug = "buffalo-windows-short"
Date = "2018-06-24T14:58:00+01:00"
Description = "Getting started with Buffalo on Windows"
Categories = ["programming"]
Tags = ["golang", "javascript", "windows"]
Type = "article"
Toc = true

+++

This is the short summary of how to start developing Web applications on Windows with
[Buffalo](http://gobuffalo.io). The
[Go on Windows](http://www.stuartellis.name/articles/windows-golang-setup) article
provides a more detailed version.

<!--more-->

# Go on Windows

First, let's install [Scoop](http://scoop.sh/), to manage your tools.

Open a PowerShell window, and enter this command:

```powershell
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
```

Press _A_ when prompted. This ensures that PowerShell can run Scoop.

Next, install Scoop:

```powershell
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
```

Now enter this command:

    scoop install gcc openssh git go nodejs-lts

This installs:

* [Go](https://golang.org/) itself
* The [GCC](http://mingw-w64.org) compiler, so that downloaded C libraries will build on
  your computer
* [Git](https://git-scm.com/), for version control
* [Node.js](https://nodejs.org/), the run-time for JavaScript

Buffalo will use GCC to compile SQLite, a database that requires no setting up or
administration. SQLite is enough for learning Web development, but you should switch to
PostgreSQL for production applications. The
[Go on Windows](http://www.stuartellis.name/articles/windows-golang-setup) article
explains how to install PostgreSQL.

The Go tool will automatically create a folder called _go_ in your user account when it
is needed. This is your [Go workspace](https://golang.org/doc/code.html#Workspaces). To
ensure that Go applications that you compile in the workspace run correctly, enter this
in a PowerShell window to register the correct folder:

```powershell
[Environment]::SetEnvironmentVariable("Path", $env:Path + ";$($env:HOMEDRIVE)$($env:HOMEPATH)\go\bin", [EnvironmentVariableTarget]::User)
```

# Installing Buffalo

To install Buffalo with SQLite, run this command:

    go get -u -v -tags sqlite github.com/gobuffalo/buffalo/buffalo

Once it is installed, use the _buffalo_ utility to create and manage your Web
applications.
