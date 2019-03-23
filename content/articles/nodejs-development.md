+++
Title = "Starting Node.js Development"
Slug = "nodejs-development"
Date = "2019-03-23T12:56:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["javascript", "node.js"]
Type = "article"

+++

Notes on development with Node.js and JavaScript.

<!--more-->

# Installing Node.js

To install Node.js on Windows, download it from
[the official Website](https://nodejs.org). Choose the 64-bit _Windows installer_
package for the current LTS version, unless you know that you need a different option.

To install Node.js on macOS, use [Homebrew](http://brew.sh/).

To install Node.js on Linux, use the
[recommended installation process for your distribution](https://nodejs.org/en/download/package-manager/),
or a [Docker image](https://hub.docker.com/_/node/). If the Linux distribution supports
snaps, you can also install
[Node.js as a snap](https://nodesource.com/blog/announcing-node-js-snap-linux-users/).
Snaps automatically update, so are not suitable for situations where you need a
reproducible environment. [Nodesource](https://nodesource.com/) maintain the Linux
packages for popular distributions, and The Node.js Foundation maintain the Docker images.

## Post-Installation Check

Once you have installed Node.js, run the _npm doctor_ command in a terminal window:

    npm doctor

This run various checks to verify that Node.js and Git are installed correctly, and tests whether the system can access the package registry for npm. 

## Managing Multiple Versions of Node.js

If you need to have multiple versions of Node.js on the same system, use [nvm](https://github.com/creationix/nvm) on Linux or macOS, and [nvm-windows](https://github.com/coreybutler/nvm-windows) for Microsoft Windows.

# Essential Tools

There are a number of very popular utilities and libraries for JavaScript software
development, but a few tools are so fundamental that you should install them even before
you begin to write JavaScript code.

## npm for Managing Projects

Every Node.js installation includes [npm](https://www.npmjs.com/). This tool helps you manage your project throughout the development process. 

To start a new project, use the _npm init_ command. This creates the _package.json_ file that describes your project.

You then use npm for your tasks, including [installing other packages](https://docs.npmjs.com/cli/install.html), [running the test suite](https://docs.npmjs.com/cli/test.html), [auditing for package dependencies that have known security issues](https://docs.npmjs.com/cli/audit.html), and [setting project version numbers](https://docs.npmjs.com/cli/version.html).

> Use the [run-script](https://docs.npmjs.com/cli/run-script) feature to add appropriate custom npm commands to your project.

You also use npm to [publish to package registries](https://docs.npmjs.com/cli/publish.html). Remember to use the [shrinkwrap](https://docs.npmjs.com/cli/shrinkwrap) command on an  application project before you publish it to a registry.

The npm tool is intended for use by automated systems as well as humans. Use the [ci command](https://docs.npmjs.com/cli/ci.html) to install clean versions of your projects for automated testing and deployment.

## Git for Version Control

Ensure that [Git](http://git-scm.com/) is installed on your system. Git is now effectively the standard version control tool for developers, and npm also uses it for some operations.

Once Git is installed, IDEs and editor like Visual Studio Code will provide you with access to information
and features from Git directly in their user interfaces. If you use Visual Studio Code,
you should also consider installing the
[Git Lens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
extension, which enhances the integration with Git.

## ESLint for Code Quality

Set up [ESLint](http://eslint.org/) in all of your projects to run code quality checks. Add the [ESLint plugin for Node](https://www.npmjs.com/package/eslint-plugin-node) to include specific checks for Node.js code.

Consider using ESLint with [Prettier](https://prettier.io/), a code formatting tool. [Prettier integrates with ESLint](https://prettier.io/docs/en/eslint.html), so that ESLint formats your code with Prettier first to remove style issues, and then checks the reformatted code for errors.

Plugins enable the popular text editors and IDEs to integrate ESLint and Prettier, so
that your code can be formatted and checked as you work. If you use Visual Studio Code, install the [ESLint extension](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint) and the [Prettier extension](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode). The Prettier extension includes a copy of Prettier, so it will work immediately.

## Testing Tools

[Jest](https://facebook.github.io/jest/) provides a comprehensive set of tools for
testing. If you do not already have a preference, add Jest to your project.

Existing JavaScript projects may use a combination of libraries in their test suite. The
most popular solution is to use the [Mocha](https://mochajs.org/) unit testing
framework, in conjunction with [Sinon.js](http://sinonjs.org/) for mocks,
[Chai](http://www.chaijs.com/) for assertions, [Karma](https://karma-runner.github.io)
for running tests, and [Istanbul](https://istanbul.js.org/) to measure test coverage.

## Writing Documentation

Use Markdown for separate documents, such as README files, and the [JSDoc](http://usejsdoc.org/) format for writing documentation in code. Many tools understand these formats.

The [Documentation.js](http://documentation.js.org/) generator builds sets of documentation from JSDoc.

## Other Development Tools

You should probably learn these as you need them.

- [Babel](https://babeljs.io/) - Compiles JavaScript code into alternate versions
- [Concurrently](https://www.npmjs.com/package/concurrently) - Runs multiple commands simultaneously
- [Husky](https://github.com/typicode/husky) - Convenient Git hooks
- [Nodemon](https://nodemon.io/) - Instant code reloading during development
- [PM2](http://pm2.keymetrics.io/) - Process manager for Node.js applications
- [Webpack](https://webpack.js.org/) - Web assets compiler

# Additional Libraries

By design, Node.js only includes a very minimal library of modules. These packages offer
commonly used items:

- [date-fns](https://date-fns.org/) - Date and time library
- [Decimal.js](https://mikemcl.github.io/decimal.js/) - Decimal library
- [dotenv](https://github.com/motdotla/doten) - Loads environment variables from files
- [Format.js](https://formatjs.io/) - String formatting for internationalization
- [Handlebars](http://www.handlebarsjs.com/) - Templating, based on [Mustache](https://mustache.github.io/)
- [Lodash](https://lodash.com/) - Library of common utility functions
- [Math.js](http://mathjs.org/) - Library of standard mathematical functions
- [Nodemailer](https://nodemailer.com) - Email sending
- [Passport](http://www.passportjs.org/) - Authentication
- [Winston](https://github.com/winstonjs/winston) - Logging

# Web Applications

[Express](https://expressjs.com/) is still most popular Web framework for Node.js, but it is arguably not the best option. The [hapi](https://hapijs.com/) framework is the second most popular, has a strong emphasis on quality and security, and it is particularly suited for larger applications. [Fastify](https://www.fastify.io/) is an alternative to Express and hapi that can use Express plugins. Consider using Fastify for smaller Websites and services.

Cloud services such as [Zeit Now](https://zeit.co/now), [Google App Engine](https://cloud.google.com/appengine/), [Heroku](https://www.heroku.com/) and [Red Hat OpenShift](https://www.openshift.com/) provide low-maintenance hosting for Node.js Web applications.

To produce applications for _function as a service_ infrastructure, such as
[AWS Lambda](https://aws.amazon.com/lambda/), use the
[Serverless](https://www.serverless.com) or [Claudia.js](https://claudiajs.com/)
frameworks.

# Web Clients

To connect with APIs, transfer files, and other Web tasks, use either [request](https://github.com/request/request), or the more minimal [axios](https://github.com/axios/axios) library. The HTTP software that is included with Node.js uses callbacks, rather than the newer promises style of API.

[Cheerio](https://cheerio.js.org/) provides an implementation of the jQuery API for
reading and processing HTML documents with Node.js.

[Puppeteer](https://github.com/GoogleChrome/puppeteer) enables you to automate copies of
Google Chrome and Chromium Web browsers.

# Accessing Databases

[Knex](http://knexjs.org/) provides a toolkit for working with SQL databases, including
query building, connection handling, and schema migrations.
[Objection.js](https://vincit.github.io/objection.js) is an Object Relational Mapper
(ORM) that builds on Knex. 

To work with MongoDB, use [Mongoose](http://mongoosejs.com/). Avoid using MongoDB for new projects, because current versions of MongoDB are not Open Source. 

In many cases there is no need to use a specialized document database like MongoDB, because modern SQL databases handle JSON documents. For example, PostgreSQL includes [data types for JSON](https://www.postgresql.org/docs/11/datatype-json.html), which means that it can store and query JSON documents alongside any other data type. 

> _Driver software required:_ To access a database service such as PostgreSQL or 
> MongoDB, you will need to install the appropriate Node.js driver.

# Graphical Desktop Applications

To create desktop applications, use [Electron](https://electronjs.org/). Applications
made with Electron are cross-platform, and can be built for Windows, macOS, and Linux
with [electron-builder](https://www.electron.build/).

# Mobile Applications

To develop mobile applications with JavaScript, use either
[Ionic](https://ionicframework.com/) or [React Native](http://reactnative.com/). Ionic
creates hybrid mobile apps that use HTML, CSS and JavaScript with the
[Angular](https://angular.io/) framework and
[Apache Cordova](https://cordova.apache.org/). React Native translates JavaScript into
instructions to the native APIs of each mobile operating system.

# Developing Command-line Tools

To create command-line tools with Node.js, use either
[yargs](http://yargs.js.org/), or
[the Open CLI Framework](https://oclif.io/). The yargs library provides the necessary features for a command-line tool with very little code. The Open CLI Framework was developed by Heroku for their command-line tools, and is a good choice for larger applications.

To package command-line tools, use [pkg](https://www.npmjs.com/package/pkg). This
creates stand-alone executables that include Node.js itself, your code, and any other
dependencies.

# Robotics and Internet of Things

[Johnny-Five](http://johnny-five.io/) is the main package for working with robotics and
hardware, such as [Arduino](https://www.arduino.cc/) boards.

The [Espruino](https://www.espruino.com/) is a single-chip board with a microcontroller
that is specifically designed to be programmed with JavaScript.

# Resources

[This article](https://www.stuartellis.name/articles/javascript-learning-resources) lists useful learning resources for JavaScript.