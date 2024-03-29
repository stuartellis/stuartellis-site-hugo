+++
Title = "Notes on Go Development"
Slug = "golang-development"
Date = "2022-12-29T19:45:00+00:00"
Description = "Notes on developing software with Go"
Categories = ["programming"]
Tags = ["golang"]
Type = "article"
Toc = true

+++

Notes on developing software with the [Go](https://go.dev/) language.

<!--more-->

## Installing Go

To install Go on Windows, download it from [the official Website](https://go.dev/).
Choose the 64-bit _Windows installer_ package for the current version, unless you know
that you need a different option.

To install Go on macOS or Linux, use [Homebrew](http://brew.sh/). Linux distributions supply versions of Go, but these will frequently be older than the current release.

Docker, Inc. maintain [Docker images](https://store.docker.com/images/golang) for Go. These are useful for Continuous Integration, where you need containers that include a Go compiler to build releases of your software.

## Essential Tools

### The Go Plugin for Your Code Editor

If you use [Visual Studio Code](https://code.visualstudio.com), install the Microsoft [plugin for Go](https://marketplace.visualstudio.com/items?itemName=ms-vscode.Go). Use the [vim-go](https://github.com/fatih/vim-go) plugin for Vim. If you
would prefer to use an IDE, JetBrains offer [GoLand](https://www.jetbrains.com/go/) as a
commercial product.

### Code Quality

[staticcheck](https://staticcheck.io/) is the most popular code linter for Go. The Visual Studio Code extension for Go will install and use staticcheck.

Use [golangci-lint](https://golangci-lint.run/) to run a suite of
quality checks on your code, including staticcheck rules. This tool works with popular code editors and IDEs. You should also add golangci-lint to your Continuous Integration process, to ensure that the code that is submitted passes quality checks.

The [Go Report Card](https://goreportcard.com/) service analyses the Go software in
public Git repositories, using some of the standard quality checks. You do not need to
do anything to enable the service to analyse your project. If you wish, you may add a
badge to the README in your repository that links to the Report Card for your project.

### Testing

The Go standard library includes tools for testing. You may want to enhance your tests with these libraries:

- [go-cmp](https://github.com/google/go-cmp) - Package for comparing Go values in tests
- [Gofakeit](https://github.com/brianvoe/gofakeit) - Generates fake data
- [go-junit-report](https://github.com/jstemmer/go-junit-report) - Converts Go test output to JUnit XML
- [Testify](https://github.com/stretchr/testify) - Assertions and mocks

### Other Important Tools

- [Delve](https://github.com/go-delve/delve) - Debugger
- [goimports](https://godoc.org/golang.org/x/tools/cmd/goimports) - Removes unused import statements from Go code
- [GoReleaser](https://goreleaser.com/) - Release automation for Go projects

## Web Applications

You can develop Web applications in Go with just the standard library and a few
third-party packages, but you will need to handle many features and technical decisions
yourself. These frameworks provide conventions and sets of tested components for your
applications:

- [Echo](https://echo.labstack.com/) - A small, convenient framework for Web applications
- [chi](https://go-chi.io/) - A minimal router and middleware framework for Web API services.
- [Go kit](https://gokit.io) - Microservices in enterprise architectures

Consider using [oapi-codegen](https://github.com/deepmap/oapi-codegen) to generate Go code from OpenAPI specification files, rather than writing your own server code. This tool works with both Echo and chi.

Go Web applications can be deployed on a very wide variety of infrastructure. Cloud
services such as [Google App Engine](https://cloud.google.com/appengine/),
[Heroku](https://www.heroku.com/) and [Red Hat OpenShift](https://www.openshift.com)
provide low-maintenance hosting, but you can set up any server to run Go applications.

To produce applications for [AWS Lambda](https://aws.amazon.com/lambda/), use the [Serverless Framework](https://serverless.com/) or [AWS SAM](https://aws.amazon.com/serverless/sam/).

## Static Websites

Use [Hugo](https://gohugo.io/) to build static Websites.

## Web Clients

The standard library for Go includes HTTP server and client software. Consider using [oapi-codegen](https://github.com/deepmap/oapi-codegen) to generate Go code from OpenAPI specification files, rather than writing your own code for Web clients.

The [goquery](https://github.com/puerkitobio/goquery) library provides an implementation
of the jQuery API for HTML parsing. [Colly](http://go-colly.org/) is a complete
framework for Web scraping.

## Developing Command-line Tools

The Go standard library includes the basic elements that you need to build your own command-line tools. Use the [Cobra](https://cobra.dev/) framework to create command-line tools with features such as sub-commands and autocompletion.

## Internet of Things

Use [TinyGo](https://tinygo.org/) to run Go on microcontrollers, such as Arduino boards.

[Gobot](http://gobot.io/) enables you to develop Go applications that work with robotics.

## Developing Desktop Applications

The [Wails](https://wails.io/) and [Fyne](https://fyne.io) projects provide tools for developing desktop applications with Go.

## Developing Games

[Ebitengine](https://ebitengine.org/) is a 2D game engine for Go.

## Working with Databases

Go includes support for SQL in the standard library. The [database/sql](https://pkg.go.dev/database/sql) package provides the basic components that are needed for database access. You can use it in your own
applications, but it is most valuable for the authors of libraries. In most cases, you
should use a third-party library to work with SQL databases. In either case, you will need to install the appropriate driver for the database.

### Data Access with SQL

These libraries offer different approaches to SQL data access:

- [sqlx](http://jmoiron.github.io/sqlx/) - A convenient data access API that follows the conventions of the Go standard library
- [sqlboiler](https://github.com/volatiletech/sqlboiler) - A tool that generates full sets of Go data access code for existing databases
- [sqlc](https://sqlc.dev/) - A tool that generates Go data access code from specified SQL queries
- [Ent](https://entgo.io/) - Object Relational Mapper that supports advanced use cases

### Migrations for SQL Databases

These projects manage schema migrations for SQL databases.

[Goose](https://pressly.github.io/goose/) can either be used as separate command-line tool, or integrated into your Go  project.

[Atlas](https://atlasgo.io/) is provided as a command-line tool, but it is also used by the [Ent](https://entgo.io/) ORM.

### Drivers for SQL Databases

The drivers for popular databases are:

- [Microsoft SQL Server](https://github.com/denisenkom/go-mssqldb)
- [MySQL](https://github.com/go-sql-driver/mysql)
- [Oracle](https://github.com/godror/godror)
- [PostgreSQL](https://github.com/lib/pq) (also recommended for CockroachDB)
- [SQLite](github.com/mattn/go-sqlite3)

## Embedding a Database

You can include a database feature in your Go application, rather than relying on a separate service.

[SQLite for Go](https://gitlab.com/cznic/sqlite) provides the equivalent of a current version of SQLite, but it is a pure Go library with no dependencies on C code.

If a SQL database is not appropriate, consider using [bbolt](https://pkg.go.dev/go.etcd.io/bbolt). This package implements a file-based key-value database system in Go.

## Data Types

- [decimal](https://github.com/shopspring/decimal) - Decimal support for Go
- [gonum](https://www.gonum.org/) - Packages for numeric and scientific work
- [uuid](https://github.com/google/uuid)

## Data Formats

- [go-mail](https://go-mail.dev/) - Library for formating and sending emails
- [Goldmark](https://github.com/yuin/goldmark) - Markdown processor
- [xmlwriter](https://github.com/shabbyrobe/xmlwriter) - XML generator
- [xpath](https://github.com/antchfx/xpath) - XPath query library
- [YAML](https://github.com/go-yaml/yaml)

## Other Useful Libraries

- [go-git](https://pkg.go.dev/github.com/go-git/go-git) - Implementation of Git in Go
- [ozzo-validation](https://github.com/go-ozzo/ozzo-validation) - Validations, based on functions
- [validator](https://github.com/go-playground/validator) - Validations, defined using struct tags
- [Viper](https://github.com/spf13/viper) - Configuration for Go applications
- [Watermill](https://watermill.io/) - Library for event-driven applications
- [zerolog](https://github.com/rs/zerolog) - Structured logging for Go applications

## Resources

- [This article](https://www.stuartellis.name/articles/golang-learning-resources) lists useful learning resources for Go.
- [Recommended libraries](https://threedots.tech/post/list-of-recommended-libraries), explained by Three Dots Labs.
