+++
Title = "Setting up the Atom Text Editor"
Slug = "atom-setup"
Date = "2017-08-20T12:12:00+01:00"
Description = "Setting up the Atom text editor for development and systems administration"
Categories = ["administration", "programming"]
Tags = ["javascript"]
Type = "article"

+++

Notes on customizing the [Atom](https://atom.io) text editor.

<!--more-->

# Packages #

The Atom community provides extensions as [packages](https://atom.io/packages).
This command installs some packages that are generally useful:

    apm install color-picker file-icons

The [file-icons](https://atom.io/packages/file-icons) package requires no
configuration. Refer to the page for
[color-picker](https://atom.io/packages/color-picker) for details on how to use it.

Install code linters for the languages that you use. Atom automatically runs the
appropriate linter for the files that you are editing. 

## Packages for Web Development ##

This command installs
support for CSS (using [CSSLint](http://csslint.net/)) and JavaScript (using
[ESLint](http://eslint.org/)):

    apm install linter-csslint linter-eslint linter-js-yaml

## Packages for Go Development ##

Run this command to add the [go-plus](https://atom.io/packages/go-plus)
package, which turns Atom into a development environment for Go:

    apm install go-plus

The next time that you open Atom, you will see go-plus automatically download
and configure all of the tools that it needs. go-plus will ask you to restart
Atom once for the changes to take effect.

## Packages for Ruby Development ##

If you are a Ruby on Rails developer, use this command to install support for
[CoffeeLint](http://www.coffeelint.org/), 
[Rubocop](http://batsov.com/rubocop/), and YAML (using
[yaml-js](http://nodeca.github.com/js-yaml/)):

    apm install linter-coffeelint linter-rubocop linter-js-yaml

# The EDITOR Environment Variable #

Remember to set the EDITOR environment
variable in your *~/.bash\_profile* file, so that this editor is
automatically invoked by command-line tools like your version control
system.

To make Atom your default editor, use this line:

    export EDITOR="atom -w"
