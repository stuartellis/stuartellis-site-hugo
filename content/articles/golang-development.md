+++
Title = "Notes on Go Development"
Slug = "golang-development"
Date = "2018-06-18T17:40:00+01:00"
Description = "Notes on developing software with Go"
Categories = ["programming"]
Tags = ["golang"]
Type = "article"
+++

Notes on developing software with the [Go](https://golang.org/) language.

<!--more-->

# Installing Go

To install Go on Windows, download it from [the official
Website](https://golang.org/). Choose the 64-bit _Windows installer_ package for
the current version, unless you know that you need a different option.

To install Go on macOS, use [Homebrew](http://brew.sh/).

To install the current version of Go on Linux, use the package from the official Website, or a [Docker image](https://store.docker.com/images/golang). Docker,
Inc. maintain the Docker images. Linux distributions supply versions of Go, but
these will frequently be older than the current release.

# Choosing a Code Editor or IDE

My current text editor is [Oni](https://www.onivim.io/), a desktop version of Vim. You may prefer [Visual Studio Code](https://code.visualstudio.com) or [Atom](https://atom.io/), which are high-quality and
customisable editors that have plugins for Go. All of these editors are free. JetBrains offer the [GoLand](https://www.jetbrains.com/go/) IDE as a commercial product. 

If you currently use Vim, install the [vim-go](https://github.com/fatih/vim-go) package to add support for Go.

# Essential Tools

There are a number of de-facto standard utilities and libraries for Go software
development, but a few tools are so fundamental that you should install them
even before you begin to write Go code.

## Git for Version Control

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

## Code Quality

Use the [Go Meta Linter](https://github.com/alecthomas/gometalinter) to run code
quality checks. Plugins enable some popular text editors and IDEs to integrate
this, so that your code can be formatted and checked as you work. The Go plugin
for Atom automatically installs Go Meta Linter.

The [Go Report Card](https://goreportcard.com/) service will analyse any Go
software in a public Git repository, using some standard tools. You do not need
to do anything to enable the Go Report Card. If you wish, you may add a badge to
the README that links to the Report Card report for your project.

## Dependency Management

Set up [dep](https://golang.github.io/dep/) in your projects to manage the
dependencies. Future versions of Go will include a replacement for _dep_, but it
is the current standard.

# Other Popular Libraries

* [go-cmp](https://github.com/google/go-cmp) - Package for comparing Go values in tests
* [logrus](https://github.com/Sirupsen/logrus) - Structured logging for Go applications
* [Viper](https://github.com/spf13/viper) - Configuration for Go applications

# Other Useful Tools

* [Delve](https://github.com/derekparker/delve) - Debugger
* [GoReleaser](https://goreleaser.com/) - Release automation for Go projects
* [Packr](https://github.com/gobuffalo/packr) - Embeds files into Go binaries

# Error Handling

Go assumes that error objects should be designed to match the needs of the
particular application. The [errors](https://godoc.org/github.com/pkg/errors) package enables you to add stack traces to your errors.

# Web Applications

You can develop Web applications in Go with just the standard library and a few third-party packages, but this requires you to handle every feature and technical decision yourself. These frameworks provide a structure and sets of tested components for your applications:

* [chi](https://github.com/go-chi/chi) offers a minimal but very high-performance framework for Web API services.
* [Buffalo](https://gobuffalo.io) is a full set of integrated tools and components for Web sites and applications.
* [Echo](https://echo.labstack.com/) provides a convenient framework for APIs. 
* [Go kit](https://gokit.io/) is specifically for building individual microservices for enterprise architectures.

Cloud services such as [Google App Engine](https://cloud.google.com/appengine/)
and [Heroku](https://www.heroku.com/) provide low-maintenance hosting for Go Web
applications.

To produce applications for [AWS Lambda](https://aws.amazon.com/lambda/), use the [Apex](http://apex.run/) or [Sparta](http://gosparta.io/) frameworks.

# Web Clients

The standard library for Go includes HTTP server and client software. These
support both the HTTP 1.1 and HTTP/2 protocols. Use
[resty](https://godoc.org/github.com/go-resty/resty) if you would like a more
convenient API for REST client software.

The [goquery](https://github.com/puerkitobio/goquery) library provides an implementation of the jQuery API for HTML parsing. [Colly](http://go-colly.org/) is a complete framework for Web scraping.

# Accessing Databases

Go includes support for SQL in the standard library. You will need to
install drivers for the specific brand of database that your code will access. Add [sqlx](http://jmoiron.github.io/sqlx/) to your project to extend this SQL support with additional features.

If you need an Object Relational Mapper(ORM), consider [GORM](http://gorm.io/),
[pop](https://github.com/gobuffalo/pop) or
[sqlboiler](https://github.com/volatiletech/sqlboiler). GORM and Pop both offer
an ORM that can create and fully manage an application database throughout the
life of the system. SQLBoiler generates Go code from an existing database.

To embed a key-value database within your application, use
[bbolt](https://github.com/coreos/bbolt).

# Developing Command-line Tools

To create command-line tools with Go, use the
[Cobra](https://github.com/spf13/cobra) framework.

# Robotics and Internet of Things

[Gobot](http://gobot.io/) is the main package for working with robotics and
hardware, such as [Arduino](https://www.arduino.cc/) boards.

[EmGo](https://github.com/ziutek/emgo) is an implementation of Go for
programming embedded systems.

# Resources

## Community

* [Gophers Slack](https://gophers.slack.com) - Slack channels for Go programmers

## References

* [Awesome Go](https://awesome-go.com) - List of online resources for Go
* [Go by Example](https://gobyexample.com) - Library of code examples
* [GoDoc](https://godoc.org/) - Online copies of documentation for public Go projects
* [Go Report Card](https://goreportcard.com/) - Quality reports for public Go projects
* [GoSearch](https://go-search.org/) - Search engine for Go packages

## Best Practices

* [Effective Go](https://golang.org/doc/effective_go.html) - Official best practices document
* [Go Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments) - Supplement to Effective Go
* [Idiomatic Go](https://dmitri.shuralyov.com/idiomatic-go) - More tips on code style
* [Standard Package Layout](https://medium.com/@benbjohnson/standard-package-layout-7cdbc8391fc1)
* [Structuring Applications in Go](https://medium.com/@benbjohnson/structuring-applications-in-go-3b04be4ff091)

## Tutorials

* [Golangbot](https://golangbot.com) - Beginner tutorials on aspects of Go
* [Gophercises](https://gophercises.com/) - Programming exercises for learning Go

## Books

* [The Go Programming Language](http://www.gopl.io/)
* [Go in Action](https://www.manning.com/books/go-in-action)

## Videos

* [Gophervids](http://gophervids.appspot.com/) - Index of online videos about Go
* [Go in 5 Minutes](https://www.goin5minutes.com) - Short screencasts
* [Go Programming by Derek Banas](https://youtu.be/CF9S4QZuV30?list=PLKPKsJOCS_IkEu5FX3hzo_A7eMbHXF68L) - One hour rapid introduction to the language
* [Just for Func](https://www.youtube.com/channel/UC_BzFbxG2za3bp5NRRRXJSw) - YouTube show on Go
