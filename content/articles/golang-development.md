+++
Title = "Notes on Go Development"
Slug = "golang-development"
Date = "2022-12-23T21:18:00+00:00"
Description = "Notes on developing software with Go"
Categories = ["programming"]
Tags = ["golang"]
Type = "article"
Toc = true

+++

Notes on developing software with the [Go](https://go.dev/) language.

<!--more-->

# Installing Go

To install Go on Windows, download it from [the official Website](https://go.dev/).
Choose the 64-bit _Windows installer_ package for the current version, unless you know
that you need a different option.

To install Go on macOS or Linux, use [Homebrew](http://brew.sh/). Linux distributions supply versions of Go, but these will frequently be older than the current release.

Docker, Inc. maintain [Docker images](https://store.docker.com/images/golang) for Go. These are useful for Continuous Integration, where you need containers that include a Go compiler to build releases of your software.

# Essential Tools

## The Go Plugin for Your Code Editor

The Open Source community around Go provides a range of tools for code quality and
refactoring that are designed to be integrated with both editors and automated build
processes. Every popular editor has a plugin for Go support, which can use these
standard utilities to check and refactor your code as you work.

If you use [Visual Studio Code](https://code.visualstudio.com), install the Microsoft [plugin for Go](https://marketplace.visualstudio.com/items?itemName=ms-vscode.Go). Use the [vim-go](https://github.com/fatih/vim-go) plugin for Vim. If you
would prefer to use an IDE, JetBrains offer [GoLand](https://www.jetbrains.com/go/) as a
commercial product.

## Git for Version Control

[Git](http://git-scm.com/) is effectively the standard version control tool for developers. If you have installed Git, Visual Studio Code and GoLand will provide you with access to
information and features from Git directly in their user interfaces.

## Code Quality

Use [golangci-lint](https://golangci-lint.run/) to run a suite of
quality checks on your code. This tools works with popular code editors and IDEs. You should also add golangci-lint to your Continuous Integration process, to ensure that the code that is submitted passes quality checks.

The [Go Report Card](https://goreportcard.com/) service analyses the Go software in
public Git repositories, using some of the standard quality checks. You do not need to
do anything to enable the service to analyse your project. If you wish, you may add a
badge to the README in your repository that links to the Report Card for your project.

# Other Useful Tools

- [Delve](https://github.com/derekparker/delve) - Debugger
- [goimports](https://godoc.org/golang.org/x/tools/cmd/goimports) - Removes unused import statements from Go code
- [Gomacro](https://github.com/cosmos72/gomacro) - Interactive interpreter for Go
- [GoReleaser](https://goreleaser.com/) - Release automation for Go projects
- [staticcheck](https://staticcheck.io/) - Code linter for Go

# Error Handling

Go assumes that error objects should be designed to match the needs of the particular
application. The [errors](https://godoc.org/github.com/pkg/errors) package provides
error objects that include stack traces.

# Web Applications

You can develop Web applications in Go with just the standard library and a few
third-party packages, but you will need to handle many features and technical decisions
yourself. These frameworks provide conventions and sets of tested components for your
applications:

- [Echo](https://echo.labstack.com) - A small, convenient framework for Web applications
- [chi](https://go-chi.io) - A minimal router and middleware framework for Web API services.
- [Buffalo](https://gobuffalo.io) - A full set of integrated tools and components for Web sites and applications.
- [Go kit](https://gokit.io) - Microservices in enterprise architectures

Go Web applications can be deployed on a very wide variety of infrastructure. Cloud
services such as [Google App Engine](https://cloud.google.com/appengine/),
[Heroku](https://www.heroku.com/) and [Red Hat OpenShift](https://www.openshift.com)
provide low-maintenance hosting, but you can set up any server to run Go applications.

To produce applications for [AWS Lambda](https://aws.amazon.com/lambda/), use the [Serverless Framework](https://serverless.com/) or [AWS SAM](https://aws.amazon.com/serverless/sam/).

# Web Clients

The standard library for Go includes HTTP server and client software. The [goquery](https://github.com/puerkitobio/goquery) library provides an implementation
of the jQuery API for HTML parsing. [Colly](http://go-colly.org/) is a complete
framework for Web scraping.

# Accessing Databases

If you only need to store sets of data on the computer that runs your application,
consider using [Badger](https://dgraph.io/badger) instead of a separate SQL database. The Badger package implements a file-based key-value database system in pure Go.

Go includes support for SQL in the standard library. This package provides the basic
components that are needed for database access, and you can use it in your own
applications, but it is most valuable for the authors of libraries. In most cases, you
should use a third-party database library.

These libraries offer several different approaches:

- [sqlx](http://jmoiron.github.io/sqlx/) - A convenient data access API that follows the conventions of the Go standard library
- [sqlboiler](https://github.com/volatiletech/sqlboiler) - A tool that generates full sets of Go data access code for existing databases
- [Ent](https://entgo.io/) - Object Relational Mapper that supports advanced use cases
- [GORM](http://gorm.io/) - A popular Object Relational Mapper

Whichever option you choose, you will also need a driver for the specific brand of
database that your code will access. The most popular drivers are:

- [Microsoft SQL Server](https://github.com/denisenkom/go-mssqldb)
- [MySQL](https://github.com/go-sql-driver/mysql)
- [PostgreSQL](https://github.com/lib/pq) (also recommended for CockroachDB)
- [SQLite](https://mattn.github.io/go-sqlite3/)

# Developing Command-line Tools

The Go standard library includes the basic elements that you need to build your own command-line tools. Use the [Cobra](https://github.com/spf13/cobra) framework to create command-line tools with features such as sub-commands and autocompletion.

# Developing Desktop Applications

The [Wails](https://wails.io/) and [Fyne](https://fyne.io) projects provide tools for developing desktop applications with Go.

# Internet of Things

Use [TinyGo](https://tinygo.org/) to run Go on microcontrollers, as Arduino boards.

[Gobot](http://gobot.io/) enables you to develop Go applications that work with robotics.

# Other Useful Libraries

- [decimal](https://godoc.org/github.com/ericlagergren/decimal) - Decimal support for Go
- [Fake](https://github.com/icrowley/fake) - Generates fake data
- [go-cmp](https://github.com/google/go-cmp) - Package for comparing Go values in tests
- [Goldmark](https://github.com/yuin/goldmark) - Markdown processor
- [gonum](https://www.gonum.org/) - Packages for numeric and scientific work
- [OpenAPI Toolkit](https://github.com/go-openapi) - Go libraries for [OpenAPI](https://www.openapis.org/)
- [Viper](https://github.com/spf13/viper) - Configuration for Go applications
- [zerolog](https://github.com/rs/zerolog) - Structured logging for Go applications

# Resources

[This article](https://www.stuartellis.name/articles/golang-learning-resources) lists useful learning resources for Go.
