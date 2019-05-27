+++
Title = "Starting Node.js Development"
Slug = "nodejs-development"
Date = "2019-04-21T11:43:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["javascript", "node.js"]
Type = "article"
Toc = true

+++

Notes on development with [Node.js](https://nodejs.org) and JavaScript.

<!--more-->

# Installing Node.js

## Node.js on Windows

To install Node.js on Windows, download it from
[the official Website](https://nodejs.org). Choose the 64-bit _Windows installer_
package for the current LTS version, unless you know that you need a different option.

## Node.js on macOS

To install Node.js on macOS, use [Homebrew](http://brew.sh/).

## Node.js on Linux

To install Node.js on Linux, use the
[recommended installation process for your distribution](https://nodejs.org/en/download/package-manager/). [Nodesource](https://nodesource.com/) maintain the Linux packages for popular distributions.

If the Linux distribution supports snaps, you can also install
[Node.js as a snap](https://nodesource.com/blog/announcing-node-js-snap-linux-users/).
Snaps automatically update, so are not suitable for situations where you need a
reproducible environment.

## Node.js with Docker

Use the [official Docker image for Node.js](https://hub.docker.com/_/node/). The Node.js Foundation maintain these Docker images.

## Linux and macOS: Global Package Installation

If you use macOS or Linux, follow the instructions in this [guide to npm global without sudo](https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md) to make global package installation use your home directory.

On these operating systems, the default configuration of Node.js causes the _global_ option of npm to install packages to a shared location. This location requires administrator privileges to access, which means that every command will need unsafe levels of privileges.

> Whenever possible use npx to run commands, rather than installing them globally.

## Using Multiple Versions of Node.js

If you need to have multiple versions of Node.js on the same system, use [nvm](https://github.com/creationix/nvm) on Linux or macOS, and [nvm-windows](https://github.com/coreybutler/nvm-windows) for Microsoft Windows.

## Post-Installation Check

Once you have installed Node.js, run the _npm doctor_ command in a terminal window:

    npm doctor

This run various checks to verify that Node.js and Git are installed correctly, and tests whether the system can access the package registry for npm.

# Tools Provided with Node.js

Every current Node.js installation includes the [npm](https://docs.npmjs.com/cli/npm) and [npx](https://www.npmjs.com/package/npx) command-line tools.

## npm for Managing Projects

The [npm](https://docs.npmjs.com/cli/npm) tool helps you to manage your project throughout the development process.

To start a new project, use the _npm init_ command. This creates the [package.json](https://docs.npmjs.com/files/package.json.html) file that describes your project.

You then use npm for your tasks, including:

- [Installing other packages](https://docs.npmjs.com/cli/install.html)
- [Running the project test suite](https://docs.npmjs.com/cli/test.html)
- [Auditing for package dependencies that have known security issues](https://docs.npmjs.com/cli/audit.html)
- [Setting project version numbers](https://docs.npmjs.com/cli/version.html).

> Use the [run-script](https://docs.npmjs.com/cli/run-script) feature to add appropriate custom npm commands to your project.

You also use npm to [publish to package registries](https://docs.npmjs.com/cli/publish.html). If you are developing an application, remember to run the [shrinkwrap](https://docs.npmjs.com/cli/shrinkwrap) command on the project before you publish it to a registry.

The npm tool is intended for use by automated systems as well as humans. Use the [ci command](https://docs.npmjs.com/cli/ci.html) to install clean versions of your projects for automated testing and deployment.

## npx for Running Commands

The [npx](https://www.npmjs.com/package/npx) utility automatically finds and runs JavaScript command-line tools that you specify. If the tool is not already installed on your computer, npx automatically downloads and runs a temporary copy, without permanently installing it.

This means that you can type _npx_, followed by the commands for any tool that is available in the npm package registry, and npx should run that tool. For example, type this in a terminal to run [learnyounode](https://github.com/workshopper/learnyounode), an interactive tutorial program:

    npx learnyounode

The npx utility only works with tools that have npm packages. However, you can use _npx shx_ to run UNIX tools like _ls_ on any operating system:

    npx shx ls

This is not a special feature of the npx utility. It works because the [ShellJS project](https://documentup.com/shelljs/shelljs) publishes JavaScript implementations of the standard UNIX tools to the npm registry in a package called [shx](https://www.npmjs.com/package/shx).

When you run npx in the working directory of a JavaScript project, it checks the commands that have been installed by the packages for that project. If the project has the command, npx runs that copy of the command.

If npx cannot find the specified command in the project, or you run npx outside of a project directory, then npx downloads a package for the command from the npm registry, and then runs the command. By default, npx downloads the latest version of the package. The packages that npx downloads are cached, so that each package is only downloaded once.

You can override the default behaviour of npx with command-line options. The optional _-p_ flag for npx enables you to specify the name and specific version of the package that contains the command that you want to run. Use the _--no-install_ flag to disable the feature to automatically download packages from the npm registry.

# Essential Tools

There are a number of very popular utilities and libraries for JavaScript software
development, but a few tools are so fundamental that you should install them even before
you begin to write JavaScript code.

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

Use the [Markdown](https://commonmark.org/) format for separate documents, such as README files, and the [JSDoc](http://usejsdoc.org/) format for writing documentation in code. Many tools understand these formats.

The [Documentation.js](http://documentation.js.org/) generator builds sets of documentation from JSDoc.

# Learning Node.js

The [NodeSchool](http://nodeschool.io/) project offers free interactive tutorials for Node.js and JavaScript. These include [learnyounode](https://github.com/workshopper/learnyounode), a tutorial for learning the basics of Node.js itself. Type this in a terminal to run learnyounode:

    npx learnyounode

# Other Resources

- [Useful learning resources for JavaScript](https://www.stuartellis.name/articles/javascript-learning-resources)
- [Useful tools and libraries for Node.js](https://www.stuartellis.name/articles/nodejs-toolbox)
