+++
Title = "Setting up the Visual Studio Code Text Editor"
Slug = "visual-studio-code"
Date = "2018-08-12T15:44:00+01:00"
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

To install Visual Studio Code on macOS with Homebrew, enter this command in a terminal
window:

    brew cask install visual-studio-code

## The EDITOR Environment Variable

Remember to set the EDITOR environment variable in your shell profile, so that this
editor is automatically invoked by command-line tools like your version control system.

To make Visual Studio Code your default editor, use this line:

    export EDITOR="code -w"

## Extensions

Install code linters for the languages that you use. Code automatically runs the
appropriate linter for the files that you are editing.

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

### Extensions for Popular Programming Languages

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

- [Ansible](https://marketplace.visualstudio.com/items?itemName=dvscoss.vscode-ansible)
- [Microsoft SQL Server](https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql)
- [PowerShell](https://marketplace.visualstudio.com/items?itemName=ms-vscode.powershell)
