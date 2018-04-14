+++
Title = "Starting Node.js Development"
Slug = "nodejs-development"
Date = "2018-04-14T10:58:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["node.js"]
Type = "article"
Draft = true

+++

Notes on starting Node.js development.

<!--more-->

# Installing Node.js on Windows #

First, download the latest version of Node.js from [the official
Website](https://nodejs.org). Choose the LTS version and *Windows installer* (64-bit), unless you know that you need a different option.

A standard Node.js installation provides you with:

* The Node.js runtime
* An *interactive shell* (use the menu icon, or type _node_ in a
    command prompt window)
* A small *standard library*, along with documentation
* The *npm* package manager to install extra software

# Choosing a Code Editor or IDE #

 My preferred text editor is currently [Visual Studio Code](https://code.visualstudio.com). [This tutorial](https://code.visualstudio.com/docs/nodejs/nodejs-tutorial) shows you the features that Visual Studio Code has for JavaScript development, including code quality checks, and support for debugging. You may prefer [Atom](https://atom.io/), which is a high-quality and customisable editor that has plugisn for Node.js and JavaScript, or [Notepad++](https://notepad-plus-plus.org/), which will be more suitable for older computers with limited resources. All of these editors are free.

# Essential Tools #

There are a number of de-facto standard utilities and libraries for
JavaScript software development, but a few tools are so fundamental that you should install them even before you begin to write JavaScript code.

## Git for Version Control ##

If you do not already use version control, you should also install [Git](http://git-scm.com/) on your system. Git is now effectively the standard version control tool for developers.

Version control is obviously vital for collaborating with other programmers. It also enables you to efficiently copy your application to other systems for testing, deployment and backup.

If Git is installed, Atom and Visual Studio Code provide you with access to information and features from Git directly in their user interfaces. If you use Visual Studio Code, you should also consider installing the [Git Lens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens) extension, which enhances the integration with Git.

## Other Popular Tools ##

A number of other tools are commonly used in JavaScript development. You should probably learn these as you need them.

* [ESLint](http://eslint.org/) - Code quality checks
* [Prettier](https://github.com/prettier/prettier) - Code formatter for JavaScript and TypeScript

# Web Applications #

[Express](https://expressjs.com/) is the most popular choice for very simple Websites and services. The Express framework provides the basic package of features that you need for a small Web application.

Cloud services such as [Heroku](https://www.heroku.com/) and [Google App Engine](https://cloud.google.com/appengine/) also provide hosting for Node.js Web applications.

For function-as-a-service applications, such as AWS Lambda, use the [Serverless](https://www.serverless.com) framework.

# Web Clients #

Use the [axios](https://github.com/axios/axios) library for your Web client software, such as downloading files or working with APIs. The HTTP software included with Node.js does not use Promises.

# Accessing Databases #

To access a SQL database service such
as PostgreSQL, MySQL, or Oracle you will need to install the client software for that product, along with a separate Node.js adapter.

> *Connecting to Microsoft SQL Server*: [Microsoft recommend that you use the Node.js Driver for SQL Server](https://docs.microsoft.com/en-us/sql/connect/node-js/node-js-driver-for-sql-server).

[TypeORM](http://typeorm.io) provides a Object Relational Mapper.

# Graphical Desktop Applications #

If you are interested in developing desktop applications, use [Electron](https://electronjs.org/).

# Packaging Applications #

To build packaged applications, use [pkg](https://www.npmjs.com/package/pkg). This creates stand-alone executables that include Node.js itself, your code, and any other dependencies.
