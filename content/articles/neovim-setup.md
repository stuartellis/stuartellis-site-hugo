++
Title = "Setting up the Neovim Text Editor"
Slug = "neovim-setup"
Date = "2018-07-30T21:03:00+01:00"
Description = "Setting up the Neovim text editor for development and systems administration"
Categories = ["administration", "programming"]
Tags = ["javascript"]
Type = "article"
Draft = true

+++

Notes on setting up the [Neovim](https://neovim.io) text editor.

<!--more-->

# Installing Neovim

To install Neovim on macOS with Homebrew, run this command:

    brew install neovim

## The EDITOR Environment Variable

Remember to set the EDITOR environment
variable in your _~/.bash_profile_ file, so that this editor is
automatically invoked by command-line tools like your version control
system.

To make Neovim your default editor, use this line:

    export EDITOR="nvim"

## Creating A Configuration File

Once you have installed Neovim, create a file called _~/.config/nvim/init.vim_. This is your configuration file for Neovim.

This command creates a _init.vim_ file with the _set number_ option specified:

    echo 'set number' >> ~/.config/nvim/init.vim

# Setting the Leader Key

Many packages use the _leader_ key. You must specify which key that you want to use as the leader key, because this is not set by default.

# Packages

Neovim and Vim 8 include support for plugins, which means that you do not need to use a third-party plugin manager.

To add plugins to current versions, first create a directory for plugins:

    mkdir -p ~/.local/share/nvim/site/pack/git-plugins/start

Then add these lines to your _init.vim_ file:

```vim
" Put these lines at the very end of your vimrc file.

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
```

You can now install plugins by using Git to download them to the packages directory. For example, this command installs the [ALE](https://github.com/w0rp/ale) plugin:

git clone https://github.com/w0rp/ale.git ~/.local/share/nvim/site/pack/git-plugins/start/ale

# Resources

- [Vimcasts](http://vimcasts.org/) - Screencasts on using Vim
