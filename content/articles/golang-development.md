+++
Title = "Notes on Go Development"
Slug = "golang-development"
Date = "2018-07-02T22:05:00+01:00"
Description = "Notes on developing software with Go"
Categories = ["programming"]
Tags = ["golang"]
Type = "article"
+++

Notes on developing software with the [Go](https://golang.org/) language.

<!--more-->

# Installing Go

To install Go on Windows, download it from [the official Website](https://golang.org/).
Choose the 64-bit _Windows installer_ package for the current version, unless you know
that you need a different option.

To install Go on macOS, use [Homebrew](http://brew.sh/).

To install the current version of Go on Linux, use the package from the official
Website, or a [Docker image](https://store.docker.com/images/golang). Docker, Inc.
maintain the Docker images. Linux distributions supply versions of Go, but these will
frequently be older than the current release.

# Essential Tools

## The Go Plugin for Your Code Editor

The Open Source community around Go provides a range of tools for code quality and
refactoring that are designed to be integrated with both editors and automated build
processes. Every popular editor has a plugin for Go support, which can use these
standard utilities to check and refactor your code as you work.

I currently use [Oni](https://www.onivim.io/), a version of Vim for graphical desktops,
with the [vim-go](https://github.com/fatih/vim-go) plugin. If you do not have a
favourite text editor, [Visual Studio Code](https://code.visualstudio.com) and
[Atom](https://atom.io/) are high-quality and customisable editors that have
well-maintained plugins for Go. All of these editors are provided free of charge. If you
would prefer to use an IDE, JetBrains offer [GoLand](https://www.jetbrains.com/go/) as a
commercial product.

## Git for Version Control

If you do not already use version control, you should install [Git](http://git-scm.com/)
on your system. Git is now effectively the standard version control tool for developers.

Version control is obviously vital for collaborating with other programmers. It also
enables you to efficiently copy your application to other systems for testing,
deployment and backup.

If you have installed Git, Atom and Visual Studio Code will provide you with access to
information and features from Git directly in their user interfaces. If you use Visual
Studio Code, you should also consider adding the
[Git Lens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
extension, which enhances the integration with Git.

## Code Quality

Use the [Go Meta Linter](https://github.com/alecthomas/gometalinter) to run a suite of
quality checks on your code, including the official
[linter](https://github.com/golang/lint). The Go plugins for text editors and IDEs often
support the Go Meta Linter. The Go plugins for Atom and Visual Studio Code both
automatically install it as part of their setup process. You should also add the Meta
Linter to your Continuous Integration process, to ensure that the code that is submitted
passes quality checks.

The [Go Report Card](https://goreportcard.com/) service analyses the Go software in
public Git repositories, using some of the standard quality checks. You do not need to
do anything to enable the service to analyse your project. If you wish, you may add a
badge to the README in your repository that links to the Report Card for your project.

## Dependency Management

Set up [dep](https://golang.github.io/dep/) in your projects to manage the dependencies.
Future versions of Go will include a replacement for dep, but it is the current
standard.

# Other Useful Tools

- [Delve](https://github.com/derekparker/delve) - Debugger
- [goimports](https://godoc.org/golang.org/x/tools/cmd/goimports) - Removes ununsed
  import statements from Go code
- [GoReleaser](https://goreleaser.com/) - Release automation for Go projects
- [Packr](https://github.com/gobuffalo/packr) - Embeds files into Go binaries

Code editors with a Go plugin will integrate with Delve and goimports.

# Error Handling

Go assumes that error objects should be designed to match the needs of the particular
application. The [errors](https://godoc.org/github.com/pkg/errors) package provides
error objects that include stack traces.

# Web Applications

You can develop Web applications in Go with just the standard library and a few
third-party packages, but you will need to handle many features and technical decisions
yourself. These frameworks provide a structure and sets of tested components for your
applications:

- [chi](https://github.com/go-chi/chi) - A minimal router and middleware framework for
  Web API services.
- [Buffalo](https://gobuffalo.io) - A full set of integrated tools and components for
  Web sites and applications.
- [Echo](https://echo.labstack.com/) - A convenient framework for APIs
- [Go kit](https://gokit.io/) - For microservices in enterprise architectures

The [Gorilla toolkit](http://www.gorillatoolkit.org/) is a popular collection of
packages for developers who prefer to assemble their applications from individual
components, rather than use a framework. The _mux_ package from the Gorilla toolkit is
often used as a direct replacement for the router that is provided by the Go standard
library, because it is more flexible.

Cloud services such as [Google App Engine](https://cloud.google.com/appengine/),
[Heroku](https://www.heroku.com/) and [Red Hat OpenShift](https://www.openshift.com)
provide low-maintenance hosting for Go Web applications.

To produce applications for [AWS Lambda](https://aws.amazon.com/lambda/), use the
[Serverless](https://serverless.com/), [Sparta](http://gosparta.io/) or
[Apex](http://apex.run/) frameworks.

# Web Clients

The standard library for Go includes HTTP server and client software. These support both
the HTTP 1.1 and HTTP/2 protocols. Use
[resty](https://godoc.org/github.com/go-resty/resty) if you would like a more convenient
API for REST client software.

The [goquery](https://github.com/puerkitobio/goquery) library provides an implementation
of the jQuery API for HTML parsing. [Colly](http://go-colly.org/) is a complete
framework for Web scraping.

# Accessing Databases

Go includes support for SQL in the standard library. This package provides the basic
components that are needed for database access, so you can use it in your own
applications, but it is most valuable for the authors of libraries. In most cases, you
should use a third-party database library, such as:

- [sqlx](http://jmoiron.github.io/sqlx/) - Extends the standard library support for SQL
  with additional features
- [sqlboiler](https://github.com/volatiletech/sqlboiler) - A tool that generates full
  sets of Go data access code for existing databases
- [GORM](http://gorm.io/) - The most popular Object Relational Mapper (ORM) for Go
- [pop](https://github.com/gobuffalo/pop) - An Object Relational Mapper (ORM) inspired
  by ActiveRecord

Whichever package you choose, you will also need a driver for the specific brand of
database that your code will access. The most popular drivers are:

- [Microsoft SQL Server](https://github.com/denisenkom/go-mssqldb)
- [MySQL](https://github.com/go-sql-driver/mysql)
- [PostgreSQL](https://github.com/lib/pq) (also recommended for CockroachDB)
- [SQLite](https://mattn.github.io/go-sqlite3/)

If you only need to store sets of data on the computer that runs your application,
consider using the [bbolt](https://github.com/coreos/bbolt) package, which implements a
file-based key-value database system in pure Go.

# Developing Command-line Tools

To create command-line tools with Go, use the [Cobra](https://github.com/spf13/cobra)
framework.

# Robotics and Internet of Things

[Gobot](http://gobot.io/) is the main package for working with robotics and hardware,
such as [Arduino](https://www.arduino.cc/) boards.

# Other Useful Libraries

- [Blackfriday](https://github.com/russross/blackfriday) - Markdown processor
- [decimal](https://godoc.org/github.com/ericlagergren/decimal) - Decimal support for Go
- [etree](https://github.com/beevik/etree) - Parses and generates XML
- [Fake](https://github.com/icrowley/fake) - Generates fake data
- [go-cmp](https://github.com/google/go-cmp) - Package for comparing Go values in tests
- [gonum](https://www.gonum.org/) - Packages for numeric and scientific work
- [logrus](https://github.com/Sirupsen/logrus) - Structured logging for Go applications
- [Plush](https://github.com/gobuffalo/plush) - Powerful templating system
- [Viper](https://github.com/spf13/viper) - Configuration for Go applications

# Resources

## Community

- [Go Nuts mailing list](https://groups.google.com/forum/#%21forum/golang-nuts) -
  Official mailing list for Go users
- [Gophers Slack](https://gophers.slack.com) - Slack channels for Go programmers
- [GoBridge Forum](https://forum.golangbridge.org/)

## References

- [Awesome Go](https://awesome-go.com) - List of online resources for Go
- [Go 101](https://go101.org) - Online book for learning Go
- [Go by Example](https://gobyexample.com) - Library of code examples
- [GoDoc](https://godoc.org/) - Online copies of documentation for public Go projects
- [Go Report Card](https://goreportcard.com/) - Quality reports for public Go projects
- [GoSearch](https://go-search.org/) - Search engine for Go packages

## Best Practices

- [Effective Go](https://golang.org/doc/effective_go.html) - Official best practices
  document
- [Go Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments) -
  Supplement to Effective Go
- [Idiomatic Go](https://dmitri.shuralyov.com/idiomatic-go) - More tips on code style
- [Standard Package Layout](https://medium.com/@benbjohnson/standard-package-layout-7cdbc8391fc1)
- [Structuring Applications in Go](https://medium.com/@benbjohnson/structuring-applications-in-go-3b04be4ff091)
- [Industrial Programming in Go](https://peter.bourgon.org/go-for-industrial-programming/) -
  Summarises current best practices in the design of Go applications

## Tutorials

- [Golangbot](https://golangbot.com) - Beginner tutorials on aspects of Go
- [Gophercises](https://gophercises.com/) - Programming exercises for learning Go

## Books

- [The Go Programming Language](http://www.gopl.io/)
- [Go in Action](https://www.manning.com/books/go-in-action)
- [Go Programming Blueprints](https://www.packtpub.com/application-development/go-programming-blueprints-second-edition)

## Videos

- [Gophervids](http://gophervids.appspot.com/) - Index of online videos about Go
- [Go in 5 Minutes](https://www.goin5minutes.com) - Short screencasts
- [Go Programming by Derek Banas](https://youtu.be/CF9S4QZuV30?list=PLKPKsJOCS_IkEu5FX3hzo_A7eMbHXF68L) -
  One hour rapid introduction to the language
- [Just for Func](https://www.youtube.com/channel/UC_BzFbxG2za3bp5NRRRXJSw) - YouTube
  show about Go
