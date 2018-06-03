+++
Title = "Notes on Go Development"
Slug = "golang-development"
Date = "2018-06-03T09:49:00+01:00"
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

To install the current version of Go on Linux, use the package from the official
Website, or a [Docker image](https://store.docker.com/images/golang). Docker,
Inc. maintain the Docker images. Linux distributions supply versions of Go, but
these will frequently be older than the current release.

# Choosing a Code Editor or IDE #

My current text editor is [Visual Studio Code](https://code.visualstudio.com).
You may prefer [Atom](https://atom.io/), which is a high-quality and
customisable editor that has plugins for Go. Both of these editors are free.

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

Use the [Go Meta Linter](https://github.com/alecthomas/gometalinter) to run code
quality checks. Plugins enable some popular text editors and IDEs to integrate
this, so that your code can be formatted and checked as you work. The Go plugin
for Atom automatically installs Go Meta Linter.

The [Go Report Card](https://goreportcard.com/) service will analyse any Go
software in a public Git repository, using some standard tools. You do not need
to do anything to enable the Go Report Card. If you wish, you may add a badge to
the README that links to the Report Card report for your project.

## Dependency Management ##

Set up [dep](https://golang.github.io/dep/) in your projects to manage the
dependencies. Future versions of Go will include a replacement for *dep*, but it
is the current standard.

# Other Popular Tools and Libraries #

* [Delve](https://github.com/derekparker/delve) - Debugger
* [GoReleaser](https://goreleaser.com/) - Release automation for Go projects
* [go-cmp](https://github.com/google/go-cmp) - Package for comparing Go values in tests
* [Packr](https://github.com/gobuffalo/packr) - Embeds files into Go binaries
* [Viper](https://github.com/spf13/viper) - Configuration for Go applications

# Error Handling #

Go assumes that error objects should be designed to match the needs of the
particular application. If you would like a simple implementation of these, use
the [errors](https://godoc.org/github.com/pkg/errors) package.

# Web Applications #

The [chi](https://github.com/go-chi/chi) router offers a minimal framework for
Web API services. [Buffalo](https://gobuffalo.io) provides a full set of
features and tools for larger Web sites and applications. [Go
kit](https://gokit.io/) is a toolkit for building microservices in Go.

Cloud services such as [Google App Engine](https://cloud.google.com/appengine/)
and [Heroku](https://www.heroku.com/) provide low-maintenance hosting for Go Web
applications.

To produce applications for [AWS Lambda](https://aws.amazon.com/lambda/), use the [Apex](http://apex.run/) or [Sparta](http://gosparta.io/) frameworks.

# Web Clients #

The standard library for Go includes HTTP server and client software. These
support both HTTP 1.1 and HTTP/2. Use
[resty](https://godoc.org/github.com/go-resty/resty) if you would like a more
convenient API for REST client software.

[Colly](http://go-colly.org/) provides a framework for Web scraping.

# Accessing Databases #

Go includes support for SQL in the standard library. Add
[sqlx](http://jmoiron.github.io/sqlx/) to your project to extend this
SQL support with additional features. You will need to
install drivers for the specific brand of database that your code will access.

If you need an Object Relational Mapper(ORM), consider [GORM](http://gorm.io/),
[pop](https://github.com/gobuffalo/pop) or
[sqlboiler](https://github.com/volatiletech/sqlboiler). GORM and Pop both offer
an ORM that can create and fully manage an application database throughout the
life of the system. SQLBoiler generates Go code from an existing database.

To embed a key-value database within your application, use
[bbolt](https://github.com/coreos/bbolt).

# Developing Command-line Tools #

To create command-line tools with Go, use the
[Cobra](https://github.com/spf13/cobra) framework.

# Robotics and Internet of Things #

[Gobot](http://gobot.io/) is the main package for working with robotics and
hardware, such as [Arduino](https://www.arduino.cc/) boards.

[EmGo](https://github.com/ziutek/emgo) is an implementation of Go for
programming embedded systems.

# Resources #

## Interactive ##

* [GoDoc](https://godoc.org/) - Online copies of documentation for public Go projects
* [GoSearch](https://go-search.org/) - Search engine for Go packages

## Documents ##

* [Gophercises](https://gophercises.com/) - Programming exercises for learning Go

## Books ##
