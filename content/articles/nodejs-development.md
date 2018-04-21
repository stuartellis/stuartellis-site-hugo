+++
Title = "Starting Node.js Development"
Slug = "nodejs-development"
Date = "2018-04-21T08:03:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["node.js"]
Type = "article"

+++

Notes on development with Node.js and JavaScript.

<!--more-->

# Installing Node.js #

To install Node.js on Windows, download it from [the official Website](https://nodejs.org). Choose the 64-bit *Windows installer* package for the current LTS version, unless you know that you need a different option.

To install Node.js on macOS, use [Homebrew](http://brew.sh/).

 If you use a Linux system that supports snaps for your development work, such as the Ubuntu desktop, you can install the [Node.js snaps](https://nodesource.com/blog/announcing-node-js-snap-linux-users/) that are maintained by [Nodesource](https://nodesource.com/). Otherwise, use the [Nodesource package repositories](https://github.com/nodesource/distributions).

A standard Node.js installation provides you with:

* Node.js itself
* An *interactive shell* (use the menu icon in Windows, or type _node_ in a
    terminal window)
* The *npm* package manager to install extra software

# Choosing a Code Editor or IDE #

 My preferred text editor is currently [Visual Studio Code](https://code.visualstudio.com). [This tutorial](https://code.visualstudio.com/docs/nodejs/nodejs-tutorial) shows you the features that Visual Studio Code has for JavaScript development, including code quality checks, and support for debugging. You may prefer [Atom](https://atom.io/), which is a high-quality and customisable editor that has plugins for Node.js and JavaScript, or [Notepad++](https://notepad-plus-plus.org/), which will be more suitable for older computers with limited resources. All of these editors are free.

# Essential Tools #

There are a number of de-facto standard utilities and libraries for JavaScript software development, but a few tools are so fundamental that you should install them even before you begin to write JavaScript code.

## Git for Version Control ##

If you do not already use version control, you should install [Git](http://git-scm.com/) on your system. Git is now effectively the standard version control tool for developers.

Version control is obviously vital for collaborating with other programmers. It also enables you to efficiently copy your application to other systems for testing, deployment and backup.

If Git is installed, Atom and Visual Studio Code provide you with access to information and features from Git directly in their user interfaces. If you use Visual Studio Code, you should also consider installing the [Git Lens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens) extension, which enhances the integration with Git.

## Code Quality ##

Set up [ESLint](http://eslint.org/) in all of your projects to run code quality checks. Add [Prettier](https://prettier.io/), which will format your code, removing style issues. [Prettier integrates with ESLint](https://prettier.io/docs/en/eslint.html), so that ESLint formats your code with Prettier, and then checks the reformatted code.

Plugins enable the popular text editors and IDEs to integrate support for  ESLint and Prettier, so that your code can be formatted and checked as you work.

## Testing Tools ##

[Jest](https://facebook.github.io/jest/) provides a comprehensive set of tools for testing. If you do not already have a preference, add Jest to your project.

Existing JavaScript projects may use a combination of libraries in their test suite. The most popular solution is to use the [Mocha](https://mochajs.org/) unit testing framework, in conjunction with [Sinon.js](http://sinonjs.org/) for mocks, [Chai](http://www.chaijs.com/) for assertions, [Karma](https://karma-runner.github.io) for running tests, and [Istanbul](https://istanbul.js.org/) to measure test coverage.

## Other Development Tools ##

You should probably learn these as you need them.

* [Babel](https://babeljs.io/) - Compiles JavaScript code into alternate versions
* [Documentation.js](http://documentation.js.org/) - Documentation generator that uses the standard JSDoc format
* [Nodemon](https://nodemon.io/) - Instant code reloading during development
* [Webpack](https://webpack.js.org/) - Web assets compiler

# Additional Libraries #

By design, Node.js only includes a very minimal library of modules. These packages offer commonly used items:

* [Lodash](https://lodash.com/) - Library of common utility functions
* [Math.js](http://mathjs.org/) - Math library
* [Moment.js](http://momentjs.com/) - Date and time library

# Web Applications #

[Express](https://expressjs.com/) offers the basic elements that you need for a Website or service, along with support for a large range of plug-ins, and is the most popular choice. [Feathers](https://feathersjs.com/) builds on Express to provide support for REST APIs, real-time messaging, database access, and other capabilities. The [hapi](https://hapijs.com/) framework is designed for larger applications. [Fastify](https://www.fastify.io/) is an emerging alternative to Express and Hapi that can use Express middleware.

Cloud services such as [Heroku](https://www.heroku.com/), [Google App Engine](https://cloud.google.com/appengine/) and [Zeit Now](https://zeit.co/now) provide low-maintenance hosting for Node.js Web applications.

To produce applications for function-as-a-service infrastructure, such as [AWS Lambda](https://aws.amazon.com/lambda/), use the [Serverless](https://www.serverless.com) framework.

# Web Clients #

Use the [axios](https://github.com/axios/axios) library for your Web client software, such as downloading files or working with APIs. The HTTP software that is included with Node.js uses callbacks, rather than the newer  promises style of API.

[Cheerio](https://cheerio.js.org/) provides an implementation of the jQuery API for reading and processing HTML documents with Node.js.

[Puppeteer](https://github.com/GoogleChrome/puppeteer) enables you to automate copies of Google Chrome and Chromium Web browsers.

# Accessing Databases #

[Knex](http://knexjs.org/) provides a toolkit for working with SQL databases, including query building, connection handling, and schema migrations. [Objection.js](https://vincit.github.io/objection.js) is an Object Relational Mapper (ORM) that builds on Knex. [TypeORM](http://typeorm.io) is an emerging alternative to Knex and Objection.js, with a broader range of features. To work with MongoDB, use [Mongoose](http://mongoosejs.com/).

> *Driver software required:* To access a database service such as PostgreSQL, Redis, or MongoDB, you will need to install the appropriate Node.js driver.

# Graphical Desktop Applications #

To create desktop applications, use [Electron](https://electronjs.org/). Applications made with Electron are cross-platform, and can be built for Windows, macOS, and Linux.

# Mobile Applications #

To develop mobile applications with JavaScript, use either [Ionic](https://ionicframework.com/) or [React Native](http://reactnative.com/). Ionic creates hybrid mobile apps that use HTML, CSS and JavaScript with the [Angular](https://angular.io/) framework and [Apache Cordova](https://cordova.apache.org/). React Native translates JavaScript into instructions to the native APIs of each mobile operating system.

# Developing Command-line Tools #

To create command-line tools with Node.js, use [Commander](https://github.com/tj/commander.js) or [the Open CLI Framework](https://oclif.io/). Commander is the most popular choice for building command-line utilities. The Open CLI Framework was developed by Heroku for their command-ine tools, and then released as an Open Source project in 2018.

# Robotics and Internet of Things #

[Johnny-Five](http://johnny-five.io/) is the main package for working with robotics and hardware.

# Packaging Applications #

The tools for mobile and desktop application development build installable packages in the appropriate formats. To package other types of application, such as command-line tools, use [pkg](https://www.npmjs.com/package/pkg). This creates stand-alone executables that include Node.js itself, your code, and any other dependencies.

# Resources #

## Interactive ##

* [NodeSchool](http://nodeschool.io/) - Free installable tutorials for Node.js
* [Nodebots](http://nodebots.io/) - The community for JavaScript robotics and IoT

## Documents ##

* [Awesome Node.js](https://node.cool) - A huge list of software and resources for Node.js
* [Idiomatic JavaScript](https://github.com/rwaldron/idiomatic.js)
* [Node.js Best Practices](https://github.com/i0natan/nodebestpractices)
* [Node.js Cheatsheet](https://github.com/LeCoupa/awesome-cheatsheets/blob/master/backend/node.js)

## Books ##

* [Eloquent JavaScript](http://eloquentjavascript.net/) - Introduction to JavaScript and programming, by Marijn Haverbeke
* [You Don't Know JS](https://github.com/getify/You-Dont-Know-JS) - Book series on JavaScript internals, by Kyle Simpson
* [Exploring JS](http://exploringjs.com/) - Book series by Dr. Axel Rauschmayer
