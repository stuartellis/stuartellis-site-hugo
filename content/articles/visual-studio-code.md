+++
Title = "Setting up the Visual Studio Code Text Editor"
Slug = "visual-studio-code"
Date = "2018-08-14T20:30:00+01:00"
Description = "Setting up the Visual Studio Code text editor for development and systems administration"
Categories = ["administration", "programming"]
Tags = ["golang", "javascript", "python", "ruby"]
Type = "article"

+++

Notes on customizing the [Visual Studio Code](https://code.visualstudio.com) text
editor.

<!--more-->

# Visual Studio Code

## Installing Visual Studio Code

### Installing Code on macOS

To install Visual Studio Code on macOS with Homebrew, enter this command in a terminal window:

    brew cask install visual-studio-code

### Installing Visual Studio Code to a USB Drive

To run Visual Studio Code directly from a USB device, without installing it on the computer, use [portable mode](https://code.visualstudio.com/docs/editor/portable).

## The EDITOR Environment Variable

Remember to set the EDITOR environment variable in your shell profile, so that this
editor is automatically invoked by command-line tools like your version control system.

To make Visual Studio Code your default editor, use this line:

    export EDITOR="code -w"

## Setting up Collaborative Edting with Live Share

Use the [Live Share service](https://visualstudio.microsoft.com/services/live-share/) for collaborative editing between copies of Visual Studio and Visual Studio Code.

## Disabling Telemetry

Visual Studio Code enables telemetry by default, and connects to remote services for various features. The FAQ explains [how Code complies with the GDPR](https://code.visualstudio.com/docs/supporting/faq#_gdpr-and-vs-code).

To disable telemetry and crash reporting, set these options in *Preferences > Settings*:

~~~json
"telemetry.enableTelemetry": false,
"telemetry.enableCrashReporter": false
~~~

## Extensions

### Extensions for Writing

- [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)
- [Spell Right](https://marketplace.visualstudio.com/items?itemName=ban.spellright)

### Extensions for Software Development

- [Git Lens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens) to
  enhance the Git support in the user interface
- The
  [Docker](https://marketplace.visualstudio.com/items?itemName=PeterJausovec.vscode-docker)
  extension
- [VSCodeVim](https://marketplace.visualstudio.com/items?itemName=vscodevim.vim) to emulate Vim
- [YAML Support](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml)

### Extensions for Popular Programming Languages

Visual Studio Code includes support for JavaScript, TypeScript and Node.js. To add support for other programming languages, install the extension for the languages that you would like to use.

Run this command to add the
[Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
extension:

    code --install-extension ms-python.python

You will need to install some additional tools into the environment to use all of the features of this extension.

Run this command to add the
[Go](https://marketplace.visualstudio.com/items?itemName=ms-vscode.Go) extension, which
turns Code into a development environment for Go:

    code --install-extension ms-vscode.go

The Go extension will automatically download and configure all of the tools that it
needs.

Run this command to add the
[Ruby](https://marketplace.visualstudio.com/items?itemName=rebornix.ruby) extension:

    code --install-extension rebornix.ruby

You will need to install some additional tools into the environment to use all of the
features of this extension.

### Useful Extensions for Web Development

- [ESLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
  or [TSLint](https://marketplace.visualstudio.com/items?itemName=eg2.tslint) for
  JavaScript linter integration
- [Debugger for Chrome](https://marketplace.visualstudio.com/items?itemName=msjsdiag.debugger-for-chrome)
  to debug JavaScript in the Web browser

### Useful Extensions for Operations

- [Ansible](https://marketplace.visualstudio.com/items?itemName=vscoss.vscode-ansible)
- [AWS CloudFormation Linter](https://marketplace.visualstudio.com/items?itemName=kddejong.vscode-cfn-lint)
- [Microsoft SQL Server](https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql)
- [PowerShell](https://marketplace.visualstudio.com/items?itemName=ms-vscode.powershell)

# Resources

- [Visual Studio Code documentation](https://code.visualstudio.com/Docs)
- [Up your AWS CloudFormation game with Visual Studio Code](https://hodgkins.io/up-your-cloudformation-game-with-vscode)