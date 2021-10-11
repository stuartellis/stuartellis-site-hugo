+++
Title = "Useful Node.js Tools and Libraries"
Slug = "nodejs-toolbox"
Date = "2021-10-11T07:06:00+01:00"
Description = ""
Categories = ["javascript", "programming"]
Tags = ["javascript", "node.js"]
Type = "article"
Toc = true

+++

Notes on useful tools and libraries for [Node.js](https://nodejs.org).

<!--more-->

## Types of Application

### Web Applications

> [Express](https://expressjs.com/) is still most popular Web framework for Node.js, but it is not the best choice. 

Use [Fastify](https://www.fastify.io/) for smaller Websites and services. Fastify can use Express plugins. 

The [hapi](https://hapijs.com/) framework has a strong emphasis on quality and security, and is particularly suited for larger applications. Use it with [hapi pal](https://hapipal.com/), which provides a command-line tool for creating and managing hapi projects.

Cloud services such as [Vercel](https://vercel.com), [Google App Engine](https://cloud.google.com/appengine/), [Heroku](https://www.heroku.com/) and [Red Hat OpenShift](https://www.openshift.com/) provide low-maintenance hosting for Node.js Web applications.

To produce applications for _function as a service_ infrastructure, such as
[AWS Lambda](https://aws.amazon.com/lambda/), use the
[Serverless](https://www.serverless.com) or [Claudia.js](https://claudiajs.com/)
frameworks.

### Websites

[Eleventy](https://www.11ty.dev/) is a flexible static Website generator. [Gatsby](https://www.gatsbyjs.com/) relies on the React framework.

### Graphical Desktop Applications

To create desktop applications, use [Electron](https://electronjs.org/). The [Electron Forge](https://electronforge.io/) utility provides a complete set of features for developing and testing your application, including support for building installation packages.

### Mobile Applications

To develop mobile applications with JavaScript, use either
[Ionic](https://ionicframework.com/) or [React Native](http://reactnative.com/). Ionic
creates mobile apps that use HTML, CSS and JavaScript. React Native translates JavaScript into
instructions to the native APIs of each mobile operating system.

### Command-line Tools

Use [Commander](https://www.npmjs.com/package/commander). Add [conf](https://www.npmjs.com/package/conf) for configuration and [Inquirer.js](https://www.npmjs.com/package/inquirer) for prompts.

To package command-line tools, use [pkg](https://www.npmjs.com/package/pkg). This
creates stand-alone executables that include Node.js itself, your code, and any other
dependencies.

### Robotics and Internet of Things

[Johnny-Five](http://johnny-five.io/) is the main platform for working with robotics and hardware, such as [Arduino](https://www.arduino.cc/) boards.

Use the [Node SerialPort](https://serialport.io/) packages to communicate with devices over serial connections.

[Espruino](https://www.espruino.com/) provide single-chip boards and devices that are specifically designed to be programmed with JavaScript.

## Development

### Testing

Every JavaScript project should use [ESLint](http://eslint.org/).

[Jest](https://facebook.github.io/jest/) provides a comprehensive set of tools for
testing. Use [AVA](https://www.npmjs.com/package/ava) if you would like a more lightweight test runner.

> Avoid [Mocha](https://mochajs.org/) for new projects. This was a standard tool, but it has now been superseded.

- [Faker.js](https://github.com/Marak/faker.js) - Generates fake data
- [Nock](https://www.npmjs.com/package/nock) - Server mocking and expectations library

### Pre-commit Checks

Add [Husky](https://typicode.github.io/husky/) to your projects. It automatically runs commands before you commit code to version control. Use it with [lint-staged](https://github.com/okonet/lint-staged), which applies commands to the specific files that a Git commit would change.

### Build Tools

You should learn these as you need them.

- [dotenv](https://github.com/motdotla/dotenv) - Loads environment variables from files
- [rimraf](https://www.npmjs.com/package/rimraf) - Cross-platform file deletion
- [semantic-release](https://github.com/semantic-release/semantic-release) - Automates the package release workflow
- [Swagger](https://swagger.io/tools/open-source/) - [OpenAPI](https://www.openapis.org/) code generation for clients and servers
- [Webpack](https://webpack.js.org/) - Web assets compiler

## Popular Libraries

By design, Node.js only includes a very minimal library of modules.

These packages offer commonly used items:

- [Chokidar](https://www.npmjs.com/package/chokidar) - User-friendly filesystem watcher
- [Nodemailer](https://nodemailer.com) - Sending emails
- [Passport](http://www.passportjs.org/) - Authentication
- [Winston](https://github.com/winstonjs/winston) - Logging

### Web Clients

To connect with APIs, transfer files, and other Web tasks, use [axios](https://axios-http.com/), a HTTP client library that has a full range of features.

If you only need a simple HTTP client, consider [got](https://github.com/sindresorhus/got), which is a lightweight interface over the Node.js HTTP client library.

You can use the HTTP client library that is included with Node.js without any third-party modules, but it uses an API that is based on callbacks, rather than promises.

In some cases, you may need to automate a Web browser. [Puppeteer](https://github.com/GoogleChrome/puppeteer) enables you to automate copies of Google Chrome and Chromium Web browsers.

### Database Access

[Knex](http://knexjs.org/) provides a toolkit for working with SQL databases, including
query building, connection handling, and schema migrations.
[Objection.js](https://vincit.github.io/objection.js) is an Object Relational Mapper
(ORM) that builds on Knex.

Modern SQL databases support JSON documents. For example, PostgreSQL includes [data types for JSON](https://www.postgresql.org/docs/13/datatype-json.html), which means that it can store and query JSON documents alongside any other data type. For most projects, a SQL database with JSON support may be more appropriate than a document database.

To access existing MongoDB services, use [Mongoose](http://mongoosejs.com/).
Avoid using MongoDB for new projects, because current versions of MongoDB are not Open Source.

> _Driver software required:_ To access a database service such as PostgreSQL or
> MongoDB, you will need to install the appropriate Node.js driver.

### Common Data Types

- [date-fns](https://date-fns.org/) - Date and time library
- [Decimal.js](https://mikemcl.github.io/decimal.js/) - A Decimal type for JavaScript
- [Format.js](https://formatjs.io/) - String formatting for internationalization
- [Math.js](http://mathjs.org/) - Library of standard mathematical functions
- [URI.js](https://www.npmjs.com/package/urijs) - Library for working with URIs, URLs and URNs
- [uuid](https://www.npmjs.com/package/uuid) - creates and parses UUIDs

### JSON

The standard library includes support for JSON. These libraries provide additional capabilities:

- [ajv](https://ajv.js.org/) - JSON schema validator
- [flat](https://www.npmjs.com/package/flat) - Flatten or unflatten objects
- [JSONata](https://jsonata.org) - JSON querying

### Support for Other File Formats

- [Cheerio](https://cheerio.js.org/) - An implementation of the jQuery API for reading and processing HTML documents with Node.js.
- [CSV for Node.js](https://csv.js.org/) - Suite of modules for working with CSV files
- [Handlebars](https://handlebarsjs.com/) - Lightweight text templating
- [js-yaml](https://github.com/nodeca/js-yaml) - YAML
- [JSZip](https://stuk.github.io/jszip/) - ZIP archives
- [PDFKit](https://pdfkit.org/) - PDF generation
- [Remark](https://remark.js.org/) - Markdown processor with plugin support and CLI
