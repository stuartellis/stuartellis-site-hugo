+++
Title = "Get Rolling with Buffalo on Windows"
Slug = "buffalo-windows-short"
Date = "2017-08-05T16:32:00+01:00"
Description = "Getting started with Buffalo on Windows"
Categories = ["programming"]
Tags = ["administration", "golang", "javascript", "windows"]
Type = "article"
Draft = true

+++

This is the short summary of how to start developing Web applications on Windows
with [Buffalo](http://gobuffalo.io). The [Go with
Windows](http://www.stuartellis.name/articles/windows-golang-setup) article provides a
more detailed version.

<!--more-->

# Go on Windows #

First, install [Scoop](http://scoop.sh/) to manage your tools. Open
a PowerShell window, and enter this command:

    Set-ExecutionPolicy RemoteSigned -scope CurrentUser
    iex (new-object net.webclient).downloadstring('https://get.scoop.sh')

Next, enter this command:

    scoop install gcc git go nodejs-lts openssh

This installs:

* [Go](https://golang.org/) itself
* The [GCC](http://mingw-w64.org) compiler, so that downloaded C libraries will build on your computer
* [Git](https://git-scm.com/), for version control
* [Node.js](https://nodejs.org/), the run-time for JavaScript

# Get Buffalo #

To install Buffalo:

    go get -u -v github.com/gobuffalo/buffalo/...
    go install -v github.com/gobuffalo/buffalo/buffalo

# Create your Application #

FIXME
