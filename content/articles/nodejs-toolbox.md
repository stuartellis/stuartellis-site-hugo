+++
Title = "Useful Node.js Tools and Libraries"
Slug = "nodejs-toolbox"
Date = "2019-06-15T12:08:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["javascript", "node.js"]
Type = "article"
Toc = true

+++

Notes on useful tools and libraries for [Node.js](https://nodejs.org).

<!--more-->

# Developing Web Applications

[Express](https://expressjs.com/) is still most popular Web framework for Node.js, but it is arguably not the best option. The [hapi](https://hapijs.com/) framework is the second most popular in the community, has a strong emphasis on quality and security, and it is particularly suited for larger applications. The [hapi pal](https://hapipal.com/) provides a command-line tool for setting and managing hapi projects.

[Fastify](https://www.fastify.io/) is an alternative to Express and hapi that can use Express plugins. Consider using Fastify for smaller Websites and services.

Cloud services such as [Zeit Now](https://zeit.co/now), [Google App Engine](https://cloud.google.com/appengine/), [Heroku](https://www.heroku.com/) and [Red Hat OpenShift](https://www.openshift.com/) provide low-maintenance hosting for Node.js Web applications.

To produce applications for _function as a service_ infrastructure, such as
[AWS Lambda](https://aws.amazon.com/lambda/), use the
[Serverless](https://www.serverless.com) or [Claudia.js](https://claudiajs.com/)
frameworks.

# Developing Web Clients

To connect with APIs, transfer files, and other Web tasks, use either [got](https://github.com/sindresorhus/got), which provides a lightweight interface over the Node.js HTTP client library, or the larger [axios](https://github.com/axios/axios) library. You can use the HTTP client library that is included with Node.js without any third-party modules, although it uses an API that is based on callbacks, rather than promises.

[Cheerio](https://cheerio.js.org/) provides an implementation of the jQuery API for reading and processing HTML documents with Node.js.

[Puppeteer](https://github.com/GoogleChrome/puppeteer) enables you to automate copies of Google Chrome and Chromium Web browsers.

# Accessing Databases

[Knex](http://knexjs.org/) provides a toolkit for working with SQL databases, including
query building, connection handling, and schema migrations.
[Objection.js](https://vincit.github.io/objection.js) is an Object Relational Mapper
(ORM) that builds on Knex.

Modern SQL databases support JSON documents. For example, PostgreSQL includes [data types for JSON](https://www.postgresql.org/docs/11/datatype-json.html), which means that it can store and query JSON documents alongside any other data type. For most projects, a SQL database with JSON support may be more appropriate than a document database.

To access existing MongoDB services, use [Mongoose](http://mongoosejs.com/).
Avoid using MongoDB for new projects, because current versions of MongoDB are not Open Source.

> _Driver software required:_ To access a database service such as PostgreSQL or
> MongoDB, you will need to install the appropriate Node.js driver.

# Creating Graphical Desktop Applications

To create desktop applications, use [Electron](https://electronjs.org/). The [Electron Forge](https://electronforge.io/) utility provides a complete set of features for developing and testing your application, including support for building installation packages.

# Developing Mobile Applications

To develop mobile applications with JavaScript, use either
[Ionic](https://ionicframework.com/) or [React Native](http://reactnative.com/). Ionic
creates mobile apps that use HTML, CSS and JavaScript. React Native translates JavaScript into
instructions to the native APIs of each mobile operating system.

# Developing Command-line Tools

To create command-line tools with Node.js, use either
[yargs](http://yargs.js.org/), or
[the Open CLI Framework](https://oclif.io/). The yargs library provides the necessary features for a command-line tool with very little code. The Open CLI Framework was developed by Heroku for their command-line tools, and is a good choice for larger applications.

To package command-line tools, use [pkg](https://www.npmjs.com/package/pkg). This
creates stand-alone executables that include Node.js itself, your code, and any other
dependencies.

# Robotics and Internet of Things

[Johnny-Five](http://johnny-five.io/) is the main platform for working with robotics and hardware, such as [Arduino](https://www.arduino.cc/) boards.

Use the [Node SerialPort](https://serialport.io/) packages to communicate with devices over serial connections.

[Espruino](https://www.espruino.com/) provide single-chip boards and devices that are specifically designed to be programmed with JavaScript.

# Popular Development Tools

You should probably learn these as you need them.

- [Babel](https://babeljs.io/) - Compiles JavaScript code into alternate versions
- [Concurrently](https://www.npmjs.com/package/concurrently) - Runs multiple commands simultaneously
- [Faker.js](https://github.com/Marak/faker.js) - Generates fake data
- [Husky](https://github.com/typicode/husky) - Convenient Git hooks
- [Nodemon](https://nodemon.io/) - Instant code reloading during development
- [PM2](http://pm2.keymetrics.io/) - Process manager for Node.js applications
- [Swagger](https://swagger.io/tools/open-source/) - [OpenAPI](https://www.openapis.org/) code generation for clients and servers
- [Webpack](https://webpack.js.org/) - Web assets compiler

# Popular Libraries

By design, Node.js only includes a very minimal library of modules. These packages offer commonly used items:

- [CSV for Node.js](https://csv.js.org/) - Suite of modules for working with CSV files
- [date-fns](https://date-fns.org/) - Date and time library
- [Decimal.js](https://mikemcl.github.io/decimal.js/) - A Decimal type for JavaScript
- [dotenv](https://github.com/motdotla/doten) - Loads environment variables from files
- [Format.js](https://formatjs.io/) - String formatting for internationalization
- [Handlebars](http://www.handlebarsjs.com/) - Templating, based on [Mustache](https://mustache.github.io/)
- [Lodash](https://lodash.com/) - Library of common utility functions
- [Math.js](http://mathjs.org/) - Library of standard mathematical functions
- [Nodemailer](https://nodemailer.com) - Sending emails
- [Passport](http://www.passportjs.org/) - Authentication
- [Winston](https://github.com/winstonjs/winston) - Logging
