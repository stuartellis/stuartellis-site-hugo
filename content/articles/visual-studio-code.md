+++
Title = "Setting up the Visual Studio Code Text Editor"
Slug = "visual-studio-code"
Date = "2018-01-20T11:11:00+00:00"
Description = "Setting up the Visual Studio Code text editor for development and systems administration"
Categories = ["administration", "programming"]
Tags = ["javascript"]
Type = "article"
Draft = true

+++

Notes on customizing the [Visual Studio Code](https://code.visualstudio.com) text editor.

<!--more-->

# Extensions #

Install code linters for the languages that you use. Code automatically runs the
appropriate linter for the files that you are editing. 

## Extensions for Development ##

Consider installing the *Git Lens* extension to enhance the user interface, and the *Docker* and *markdownlint* extensions if appropriate.

## Extensions for Web Development ##

Install *ESLint* or *TSLint* for linter integration, and the *Debugger for Chrome*.

## Extensions for Go Development ##

Run this command to add the [Go](https://marketplace.visualstudio.com/items?itemName=lukehoban.Go)
extension, which turns Code into a development environment for Go:

    code --install-extension lukehoban.go

The Go extension will automatically download and configure all of the tools that it needs.

## Extensions for Ruby Development ##

Run this command to add the [Ruby](https://marketplace.visualstudio.com/items?itemName=rebornix.ruby)
extension:

    code --install-extension rebornix.ruby

# The EDITOR Environment Variable #

Remember to set the EDITOR environment
variable in your *~/.bash\_profile* file, so that this editor is
automatically invoked by command-line tools like your version control
system.

To make Visual Studio Code your default editor, use this line:

    export EDITOR="code -w"
