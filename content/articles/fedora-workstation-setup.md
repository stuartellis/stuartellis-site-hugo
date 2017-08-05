+++
Title = "Setting Up Fedora Workstation for Software Development"
Slug = "fedora-workstation-setup"
Date = "2017-08-05T15:12:00+01:00"
Description = "Setting up a Fedora Workstation for development and systems administration"
Categories = ["administration", "programming"]
Tags = ["administration", "linux", "fedora", "golang", "javascript", "python", "rust"]
Type = "article"

+++


This is a set of notes for setting up an installation of the [Fedora Workstation](https://getfedora.org/) Linux distribution on your PC, specifically
for systems administration and Web development.

<!--more-->

# Installation #

## Enable Disk Encryption ##

Enable disk encryption when prompted during the setup process.

Disk encryption is the only protection against anyone with physical access to
your computer. All other security measures will be completely bypassed if
someone with physical access either restarts your computer with a bootable pen
drive, or removes the internal hard drive and attaches it to another computer.

## Set a Password for UEFI or BIOS ##

Once you have installed Fedora, restart your computer, and press the function key
to enter the setup menu for the UEFI firmware, or BIOS. Change the boot options
so that the computer only boots from the hard drive, and set both a user
password for startup, and an administrator password to protect the firmware
menus.

# Do This First! #

Log in once, run the GNOME Software utility, and ensure that the operating
system has the latest updates. After all of the updates have been applied,
restart the computer.

# User Settings #

Select *Settings \> Privacy*, and review the settings. Depending upon your
needs, you may decide to turn off *Location Services* or *Usage & History*.

# Setting Up for Development #

Every developer needs a text editor and a version control system. Fedora
Workstation includes the [Git version control system](http://www.git-scm.com/),
but you will want to install the text editor or IDE of your choice.

Fedora Workstation also includes the GCC compiler and toolchain, so that you can
compile C programs and native extensions for languages like Python and
JavaScript.

## Choosing a Text Editor ##

Fedora includes a command-line version of [vim](http://www.vim.org/),
as well as a desktop text editor. These text editors have some support for
programming, but are more useful for light-weight word processing. Unless you
already have a preferred editor, I suggest that you install
[Atom](http://www.atom.io), which is a powerful graphical text editor that is
specifically designed for programming.

To install Atom, download the RPM package from the [Atom
Website](http://www.atom.io), then double-click on it. Once the Software utility
shows the package, click on the *Install* button and enter your password when
prompted.

Whichever text editor you choose, remember to set the EDITOR environment
variable in your *~/.bashrc* file, so that this editor is
automatically invoked by command-line tools like your version control
system. For example, put this line in your profile to make *nano* the
favored text editor:

    export EDITOR="nano"

To make Atom your default editor, use this line instead:

    export EDITOR="atom -w"

## Customizing Your Text Editor ##

You will massively improve your experience with your text editor by adding a
useful set of extensions to it. The exact extensions that will benefit the most
you depend upon the work that you do, but you should always look at version
control integration, convenient access to the terminal, and linters for your
preferred programming languages and data file formats.

The Atom community provides extensions as [packages](https://atom.io/packages).
This command installs some packages that are generally useful:

    apm install color-picker file-icons

The [file-icons](https://atom.io/packages/file-icons) package requires no
configuration. Refer to the page for
[color-picker](https://atom.io/packages/color-picker) for details on how to use it.

Install code linters for the languages that you use. Atom automatically runs the
appropriate linter for the files that you are editing. This command installs
support for CSS (using [CSSLint](http://csslint.net/)), JavaScript (using
[ESLint](http://eslint.org/)) and YAML (using
[yaml-js](http://nodeca.github.com/js-yaml/)):

    apm install linter-csslint linter-eslint linter-js-yaml

## Configuring Git ##

Always set your details before you create or clone repositories on a new system.
This requires two commands in a terminal window:

    git config --global user.name "Your Name"
    git config --global user.email "you@your-domain.com"

The *global* option means that the setting will apply to every
repository that you work with in the current user account.

To enable colors in the output, which can be very helpful, enter this
command:

    git config --global color.ui auto

## Setting Up A Directory Structure for Projects ##

To keep your projects tidy, I would recommend following the [Go developer
conventions](http://golang.org/doc/code.html). These guidelines may seem
slightly fussy, but they pay off when you have many projects, some of which are
on different version control hosts.

First create a top-level directory with a short, generic name like *code*. By
default Go uses a directory called *go*, but you can change that when you set up
a Go installation.

Once you set the top-level directory as the environment variable GOPATH, Go will
compile to the *bin*, *doc* and *pkg* subdirectories. You can add the *bin*
directory to your PATH to be able to run the compiled programs by typing their
names. You may or may not choose to use these directories with other programming
environments.

In this directory, create an *src* sub-directory. For each repository host,
create a subdirectory in *src* that matches your username. Check out projects in
the directory. The final directory structure looks like this:

    code/
      src/
        bitbucket.org/
          my-bitbucket-username/
            a-project/
        github.com/
          my-github-username/
            another-project/

## Creating SSH Keys ##

You will frequently use SSH to access Git repositories or remote UNIX systems.
Fedora includes the standard OpenSSH suite of tools.

To create an SSH key, run the *ssh-keygen* command in a terminal window. For
example:

    ssh-keygen -t rsa -b 4096 -C "Me MyName (MyDevice) <me@mydomain.com>"

> Use 4096-bit RSA keys for all systems. The older DSA standard only supports
1024-bit keys, which are now too small to be considered secure.

# Setting Up Environments #

## nvm for Node.js Development ##

To maintain multiple Node.js versions on your system, use the
[nvm](https://github.com/creationix/nvm) utility.

Enter this command to install nvm:

     curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

Open a new terminal window and enter this command:

    nvm install --lts

This installs the latest LTS release of Node.js, and makes it the default
Node.js run-time.

To upgrade the copy of *npm* that is provided with Node.js, run this command in
a terminal window:

    npm -g upgrade npm

## Developer Tools for Go ##

Use *dnf* to install [Go](https://golang.org/):

    sudo dnf install golang

To run Go applications that you have compiled, edit the  *~/.bashrc* and add
this to your PATH:

    export PATH="$GOPATH/bin:$PATH"

Close the terminal and open it again for the changes to take effect.

### Setting a Custom GOPATH ###

By default, current versions of Go automatically create and use a *go* directory
in your home directory as the GOPATH, which is the root directory for your Go
workspace. To specify a custom GOPATH, set the GOPATH environment variable in
your *~/.bashrc* file. For example this sets a directory called *code* as your
Go workspace:

    export GOPATH="$HOME/code"

Close the terminal and open it again for the changes to take effect.

## rustup for Rust Development ##

The official *rustup* utility enables you to install the tools for building
software with the Rust programming language. Click on the Install button on the
front page of the [Rust Website](https://www.rust-lang.org), and follow the
instructions.

This process installs all of the tools into your home directory, and does not
add any files into shared system directories.

The installer does not currently add the correct directory to your PATH. To use
your Rust installation, edit the *.bashrc* file in your home directory to add
this line:

    source $HOME/.cargo/env

Close the terminal and open it again for the changes to take effect.

The Rust packages from Fedora may provide older versions of Rust, and do install
the Rust tools into system directories.

## Python Development ##

Fedora includes both Python 2 and Python 3.

To run Python 3, be sure to specify *python3* as the interpreter, instead of
*python*. The *python* interpreter is Python 2.

# Containers and Virtual Machines #

Fedora Workstation includes [GNOME Boxes](https://wiki.gnome.org/Apps/Boxes) to
create and manage your virtual machines, as well as *systemd-nspawn* for
simple containers.

The Fedora project also provide packages for [Docker](https://www.docker.com/).
The Docker packages for Fedora have more thorough testing and better integration
with the operating system than packages from the Docker, Inc. Website.

## Installing Docker ##

To install Docker on Fedora, enter these commands in a terminal window:

    sudo dnf install docker
    sudo systemctl enable docker
    sudo systemctl start docker

# SQL Databases #

Consider using Docker containers to provide the database services for your Web
applications. This enables you to use different versions of the database servers
for different projects, and ensure that you are running the same versions as the
database instances on your production systems.

If you prefer to install services directly on to your workstation, Fedora
provides packages for PostgreSQL and [MariaDB](https://mariadb.org/). If you
need a database server that is compatible with MySQL, install MariaDB.
Otherwise, PostgreSQL is often a better choice for new applications.

## Installing PostgreSQL ##

To install PostgreSQL using *dnf*, enter these commands in a terminal window:

    sudo dnf install postgresql-server
    sudo postgresql-setup --initdb
    sudo systemctl enable postgresql
    sudo systemctl start postgresql

These commands install the server, the command-line tools, and the client
libraries that are needed to compile adapters for programming languages.

To create a user account for yourself in PostgreSQL with administrative rights,
enter this command in a terminal window:

    sudo su - postgres
    createuser -s YOU
    exit

Replace *YOU* with the username of your account on Fedora.

The *-s* option means that your new PostgreSQL account is a *superuser*, with
unlimited rights over the databases. Once you have a superuser account, you may
use tools like *createuser* or log in to databases without using sudo or the
*-U* option.

For example, to create an extra user account that is not a superuser:

    createuser EXTRA-ACCOUNT

Replace *EXTRA-ACCOUNT* with the username of the new account.

Refer to the [Fedora Wiki article](https://fedoraproject.org/wiki/PostgreSQL)
for more information on working with PostgreSQL.
