+++
Title = "Setting Up Fedora Workstation for Software Development"
Slug = "fedora-workstation-setup"
Date = "2018-11-18T20:48:00+01:00"
Description = "Setting up a Fedora Workstation for development and systems administration"
Categories = ["administration", "programming"]
Tags = ["administration", "linux", "fedora", "golang", "javascript", "python", "rust"]
Type = "article"

+++

This is a set of notes for setting up an installation of the
[Fedora Workstation](https://getfedora.org/) Linux distribution on your PC, specifically
for systems administration and Web development.

<!--more-->

# Installation

## Enable Disk Encryption

Enable disk encryption when prompted during the setup process.

Disk encryption is the only protection against anyone with physical access to your
computer. All other security measures will be completely bypassed if someone with
physical access either restarts your computer with a bootable pen drive, or removes the
internal hard drive and attaches it to another computer.

## Set a Password for UEFI or BIOS

Once you have installed Fedora, restart your computer, and press the function key to
enter the setup menu for the UEFI firmware, or BIOS. Change the boot options so that the
computer only boots from the hard drive, and set both a user password for startup, and
an administrator password to protect the firmware menus.

# Do This First!

Log in once, run the GNOME Software utility, and ensure that the operating system has
the latest updates. After all of the updates have been applied, restart the computer.

# User Settings

Select _Settings \> Privacy_, and review the settings. Depending upon your needs, you
may decide to turn off _Location Services_ or _Usage & History_.

# Setting Up for Development

Every developer needs a text editor and a version control system. Fedora Workstation
includes the [Git version control system](http://www.git-scm.com/), but you will want to
install the text editor or IDE of your choice.

Fedora Workstation also includes the GCC compiler and toolchain, so that you can compile
C programs and native extensions for languages like Python and JavaScript.

## Text Editors

Fedora includes a small command-line version of [vim](http://www.vim.org/) with a limited set of features, as well as a
desktop text editor with basic support for programming. The package repositories include a number of other editors and IDEs.

If you would like a modern Vim editor with a good default configuration, [set up Neovim](https://www.stuartellis.name/articles/neovim-setup/).

### Setting The EDITOR Environment Variable

Whichever text editor you choose, remember to set the EDITOR environment variable in
your _~/.bashrc_ file, so that this editor is automatically invoked by command-line
tools like your version control system. For example, put this line in your profile to
make _nano_ the favored text editor:

    export EDITOR="nano"

## Configuring Git

Always set your details before you create or clone repositories on a new system. This
requires two commands in a terminal window:

    git config --global user.name "Your Name"
    git config --global user.email "you@your-domain.com"

The _global_ option means that the setting will apply to every repository that you work
with in the current user account.

To enable colors in the output, which can be very helpful, enter this command:

    git config --global color.ui auto

## Setting Up A Directory Structure for Projects

To keep your projects tidy, I would recommend following the
[Go developer conventions](http://golang.org/doc/code.html). These guidelines may seem
slightly fussy, but they pay off when you have many projects, some of which are on
different version control hosts.

First create a top-level directory with a short, generic name like _code_. By default Go
uses a directory called _go_, but you can change that when you set up a Go installation.

Once you set the top-level directory as the environment variable GOPATH, Go will compile
to the _bin_, _doc_ and _pkg_ subdirectories. You can add the _bin_ directory to your
PATH to be able to run the compiled programs by typing their names. You may or may not
choose to use these directories with other programming environments.

In this directory, create an _src_ sub-directory. For each repository host, create a
subdirectory in _src_ that matches your username. Check out projects in the directory.
The final directory structure looks like this:

    code/
      src/
        bitbucket.org/
          my-bitbucket-username/
            a-project/
        gitlab.com/
          my-gitlab-username/
            another-project/

## Creating SSH Keys

You will frequently use SSH to access Git repositories or remote UNIX systems. Fedora
includes the standard OpenSSH suite of tools.

To create an SSH key, run the _ssh-keygen_ command in a terminal window. For example:

    ssh-keygen -t rsa -b 4096 -C "Me MyName (MyDevice) <me@mydomain.com>"

> Use 4096-bit RSA keys for all systems. The older DSA standard only supports 1024-bit
> keys, which are now too small to be considered secure.

# Setting Up Environments

## nvm for Node.js Development

To install versions of Node.js on your system, use the
[nvm](https://github.com/creationix/nvm) utility.

Enter this command to install nvm:

     curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

Open a new terminal window and enter this command:

    nvm install --lts

This installs the latest LTS release of Node.js, and makes it the default Node.js
run-time.

To upgrade the copy of _npm_ that is provided with Node.js, run this command in a
terminal window:

    npm -g upgrade npm

## Developer Tools for Go

Use the _dnf_ tool to install [Go](https://golang.org/):

    sudo dnf install golang

By default, current versions of Go automatically create and use a _go_ directory in your
home directory as the GOPATH. To ensure that third-party tools and terminal
auto-completion features work, you should still explicitly set the environment
variables.

Set a GOPATH environment variable in your _~/.bashrc_ file:

    export GOPATH="$HOME/go"

Then, add this to your PATH:

    $GOPATH/bin

Close the terminal and open it again for the changes to take effect.

## Python Development

Fedora includes both Python 2 and Python 3. To run Python 3, be sure to specify
_python3_ as the interpreter:

    python3 --version

The _python_ interpreter is Python 2, which you should not use for new software.

To maintain current and clean Python environments, install
[pipenv](https://docs.pipenv.org/). It drives the [pip](https://pip.pypa.io/en/stable/)
and [virtual environment](https://docs.python.org/3/tutorial/venv.html) features that
are included with Python itself, but is more powerful and easier to use than working
with these features directly.

Enter this command to install pipenv:

    sudo dnf install pipenv

## rustup for Rust Development

The official _rustup_ utility enables you to install the tools for building software
with the Rust programming language. Click on the Install button on the front page of the
[Rust Website](https://www.rust-lang.org), and follow the instructions.

This process installs all of the tools into your home directory, and does not add any
files into shared system directories.

The installer does not currently add the correct directory to your PATH. To use your
Rust installation, edit the _.bashrc_ file in your home directory to add this line:

    source $HOME/.cargo/env

Close the terminal and open it again for the changes to take effect.

The Rust packages from Fedora may provide older versions of Rust, and do install the
Rust tools into system directories.

# Containers and Virtual Machines

## Managing Virtual Machines

Fedora Workstation installs [GNOME Boxes](https://wiki.gnome.org/Apps/Boxes) by default, to enable you to create and manage virtual machines. GNOME Boxes provides a graphical interface for the standard KVM and QEMU software. You can also use these directly on the command-line.

## Podman for Containers

Use [Podman](https://podman.io/) to work with containers on Fedora. Podman is a command-line tool that does not run a background service, or require root privileges, so it is more robust and secure than [Docker](https://www.docker.com/).

Podman accepts the same syntax as the _docker_ command-line tool, and will read Dockerfiles. Both Docker and Podman use the OCI image format, so that images created either product will work with the other. By default, Podman will check the Docker public registry for container images, as well as [Quay](https://quay.io/) registries.

Enter this command to install Podman:

    sudo dnf install podman

For convenience, create a shell alias that replaces Docker with podman:

    alias docker="podman"

The [Usage Transfer](https://github.com/containers/libpod/blob/master/transfer.md) page lists Docker commands, and the equivalents for Podman.

> Podman does not currently provide an equivalent to _docker\-compose_.

# SQL Databases

Consider using containers to provide the database services for your Web applications.
This enables you to use different versions of the database servers for different
projects, and ensure that you are running the same versions as the database instances on
your production systems.

If you prefer to install services directly on to your workstation, Fedora provides
packages for PostgreSQL and [MariaDB](https://mariadb.org/). If you need a database
server that is compatible with MySQL, install MariaDB. Otherwise, PostgreSQL is often a
better choice for new applications.

## Installing PostgreSQL

To install PostgreSQL using _dnf_, enter these commands in a terminal window:

    sudo dnf install postgresql-server
    sudo postgresql-setup --initdb
    sudo systemctl enable postgresql
    sudo systemctl start postgresql

These commands install the server, the command-line tools, and the client libraries that
are needed to compile adapters for programming languages.

To create a user account for yourself in PostgreSQL with administrative rights, enter
this command in a terminal window:

    sudo su - postgres
    createuser -s YOU
    exit

Replace _YOU_ with the username of your account on Fedora.

The _-s_ option means that your new PostgreSQL account is a _superuser_, with unlimited
rights over the databases. Once you have a superuser account, you may use tools like
_createuser_ or log in to databases without using sudo or the _-U_ option.

For example, to create an extra user account that is not a superuser:

    createuser EXTRA-ACCOUNT

Replace _EXTRA-ACCOUNT_ with the username of the new account.

Refer to the [Fedora Wiki article](https://fedoraproject.org/wiki/PostgreSQL) for more
information on working with PostgreSQL.
