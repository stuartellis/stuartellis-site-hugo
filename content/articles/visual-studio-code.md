+++
Title = "Setting up the Visual Studio Code Text Editor"
Slug = "visual-studio-code"
Date = "2017-08-20T13:12:00+01:00"
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

## Extensions for Web Development ##

TODO

## Extensions for Go Development ##

Run this command to add the [Go](https://marketplace.visualstudio.com/items?itemName=lukehoban.Go)
extension, which turns Code into a development environment for Go:

    code --install-extension lukehoban.go

The Go extension will automatically download and configure all of the tools that it needs.

## Extensions for Ruby Development ##

TODO

If you are a Ruby on Rails developer, use this command to install support for
[CoffeeLint](http://www.coffeelint.org/), 
[Rubocop](http://batsov.com/rubocop/), and YAML (using
[yaml-js](http://nodeca.github.com/js-yaml/)):

    code install linter-coffeelint linter-rubocop linter-js-yaml

# The EDITOR Environment Variable #

Remember to set the EDITOR environment
variable in your *~/.bash\_profile* file, so that this editor is
automatically invoked by command-line tools like your version control
system.

To make Visual Studio Code your default editor, use this line:

    export EDITOR="code -w"
