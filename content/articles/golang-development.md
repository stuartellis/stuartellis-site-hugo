+++
Title = "Notes on Go Development"
Slug = "golang-development"
Date = "2018-05-06T18:32:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["golang"]
Type = "article"
Draft = true

+++

Notes on development with the Go language.

<!--more-->

# Installing Go #

To install Go on Windows, download it from [the official
Website](https://golang.org/). Choose the 64-bit *Windows installer* package for
the current version, unless you know that you need a different option.

To install Go on macOS, use [Homebrew](http://brew.sh/).

To install the current version of Go on Linux, use FIXME, or a [Docker image](https://store.docker.com/images/golang). Docker, Inc. maintain the Docker images. Linux distributions supply older versions of Go.

# Choosing a Code Editor or IDE #

 My preferred text editor is currently [Visual Studio
 Code](https://code.visualstudio.com). You may prefer [Atom](https://atom.io/),
 which is a high-quality and customisable editor that has plugins for Go, or
 [Notepad++](https://notepad-plus-plus.org/), which will be more suitable for
 older computers with limited resources. All of these editors are free.

# Essential Tools #

There are a number of de-facto standard utilities and libraries for Go software
development, but a few tools are so fundamental that you should install them
even before you begin to write Go code.

## Git for Version Control ##

If you do not already use version control, you should install
[Git](http://git-scm.com/) on your system. Git is now effectively the standard
version control tool for developers.

Version control is obviously vital for collaborating with other programmers. It
also enables you to efficiently copy your application to other systems for
testing, deployment and backup.

If Git is installed, Atom and Visual Studio Code provide you with access to
information and features from Git directly in their user interfaces. If you use
Visual Studio Code, you should also consider installing the [Git
Lens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
extension, which enhances the integration with Git.

## Code Quality ##

Set up [FIXME](XXX) in all of your projects to run code quality checks. Plugins
enable the popular text editors and IDEs to integrate this, so that your code
can be formatted and checked as you work.

# Web Applications #

For simple Web applications, use [Echo](https://echo.labstack.com/) or
[Gin](https://github.com/gin-gonic/gin). These frameworks offer the basic
package of features that you need for a small Web application.
[Buffalo](https://gobuffalo.io) provides a full set of features and tools for
larger Web sites and applications. Use [chi](https://github.com/go-chi/chi) for
very lightweight REST API services.

Cloud services such as [Google App Engine](https://cloud.google.com/appengine/)
and [Heroku](https://www.heroku.com/) provide low-maintenance hosting for Go Web
applications.

To produce applications for [AWS Lambda](https://aws.amazon.com/lambda/), use the [Apex](http://apex.run/) or [Sparta](http://gosparta.io/) frameworks.

# Web Clients #

Use the [FIXME]() library for your Web client software, such as downloading files or working with APIs. The HTTP software that is included with Go FIXME.

# Accessing Databases #

FIXME

> *Driver software required:* To access a database service such as PostgreSQL,
> Redis, or MongoDB, you will need to install the appropriate Go driver.

# Developing Command-line Tools #

To create command-line tools with Go, use
[Cobra](https://github.com/spf13/cobra). The Cobra framework is the most popular
choice for building command-line utilities.

# Robotics and Internet of Things #

[Gobot](http://gobot.io/) is the main package for working with robotics and
hardware, such as [Arduino](https://www.arduino.cc/) boards.

# Resources #

## Interactive ##

## Documents ##

## Books ##
