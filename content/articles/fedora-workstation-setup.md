+++
Title = "Setting Up Fedora Workstation for Software Development"
Slug = "fedora-workstation-setup"
Date = "2019-02-24T17:49:00+01:00"
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

# Installing Desktop Applications with Flatpak

[Flatpak](https://flatpak.org) is the new standard for desktop software packages. The Fedora project still provides RPM packages for many Open Source desktop applications, but Flatpak already offers newer versions of products, and software that is not available from Fedora, such as Slack.

For legal reasons, you must enable access to the public [Flathub repository](https://flathub.org) yourself. Follow the instructions to [set up access to the Flathub repository](https://flatpak.org/setup/Fedora/). The desktp _Software_ utility will then show Flatpak packages as well as RPMs.

A small number of proprietary software products are currently provided as RPM packages, such as Google Chrome and the nVidia graphics drivers. To enable access to these, open the _Software_ utility, choose _Software Repositories_ and click the _Install_ button for _Third Party Repositories_.

> Install code editors and IDEs with RPM packages, not Flatpak. Currently, Flatpak packages may prevent application plugins from working correctly.

# Setting Up for Development

Every developer needs a text editor and a version control system. Fedora Workstation
includes the [Git version control system](http://www.git-scm.com/), but you will want to
install the text editor or IDE of your choice.

## Text Editors

Fedora includes a small command-line version of [vim](http://www.vim.org/) with a limited set of features, as well as a
desktop text editor with basic support for programming. You should install the code editors and development environments that you prefer.

> Install code editors and IDEs with RPM packages, not Flatpak. Currently, Flatpak packages may prevent application plugins from working correctly.

### Neovim

If you would like a modern Vim editor with a good default configuration, [set up Neovim](https://www.stuartellis.name/articles/neovim-setup/).

### Visual Studio Code

The Microsoft releases of Visual Studio Code are proprietary software with telemetry enabled by default. Use the RPM packages that are provided by the [vscodium](https://github.com/VSCodium/vscodium) project. If you would prefer to use Flatpak packages, use [Visual Studio Code OSS](https://flathub.org/apps/details/com.visualstudio.code.oss).

Visual Studio Code and VSCodium require the library _libXss_, which is provided by the _libXScrnSaver_ package. Install this package before you install Visual Studio Code:

    sudo dnf install libXScrnSaver

Once you have installed Visual Studio Code or VSCodium, read [this article](https://www.stuartellis.name/articles/visual-studio-code/) for more information about using the editor.

### Setting The EDITOR Environment Variable

Whichever text editor you choose, remember to set the EDITOR environment variable in
your _~/.bashrc_ file, so that this editor is automatically invoked by command-line
tools like your version control system. For example, put this line in your profile to
make Neovim (_nvim_) the favored text editor:

    export EDITOR="nvim"

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

# Support for Programming Languages 

## Default Languages: Python and C 

Fedora Workstation includes Python 3. It also has the GCC compiler and toolchain, for working with C. The GCC tools enable languages like Python and JavaScript to compile native extensions that are written in C code.

## Working with Python on Fedora

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

## Using Modules to Add Extra Languages

Fedora now includes the optional [modularity](https://docs.fedoraproject.org/en-US/modularity/) feature to provide sets of software packages that are updated independently of the operating system. Use modules to install packages for extra programming languages, such as Java and Go. 

Modules allow to you to switch the installed packages between different streams of releases, such as LTS and current. This feature will not enable you to have multiple versions of the same product on the same system at the same time. Use containers or tools such as [nvm](https://github.com/creationix/nvm) and [rustup](https://rustup.rs/) to run multiple versions of the same product at the same time.

## Using nvm to Manage Node.js

The [nvm](https://github.com/creationix/nvm) tool enables you to use multiple versions of Node.js, including the latest versions.

To install nvm, use this command:

     curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

Then, open a new terminal window and enter this command:

    nvm install --lts

This installs the latest LTS release of Node.js, and makes it the default Node.js run-time.

If you use nvm, you can upgrade the npm package manager with npm itself. To upgrade the copy of _npm_ that is provided with Node.js, run this command in a
terminal window:

    npm -g upgrade npm

## Installing rustup for Rust Development

Use the official [rustup](https://rustup.rs/) utility to install the tools for building software
with the Rust programming language. It supports using multiple versions of Rust on the same system, and has other features to assist with software development. 

To install _rustup_, click on the Install button on the front page of the
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

## Using Podman for Containers

Use [Podman](https://podman.io/) to work with containers on Fedora. Podman is a command-line tool that is designed to be more robust and secure than [Docker](https://www.docker.com/). Unlike Docker, Podman does not run a background service, or require root privileges.

Podman accepts the same syntax as the _docker_ command-line tool, and will read Dockerfiles. Both Docker and Podman use the OCI image format, so that images created either product will work with the other. By default, Podman will check the Docker public registry for container images, as well as [Quay](https://quay.io/) registries.

Enter this command to install Podman:

    sudo dnf install podman

For convenience, define a shell alias in your _.bashrc_ file: 

    alias docker="podman"

This will redirect any call to Docker, so that it uses Podman instead.

The [Usage Transfer](https://github.com/containers/libpod/blob/master/transfer.md) page lists Docker commands, and the equivalents for Podman. [This article](https://developers.redhat.com/blog/2019/02/21/podman-and-buildah-for-docker-users/) explains the relationship between Podman, Buildah and Docker in more detail.

> Use [pods](https://developers.redhat.com/blog/2019/01/15/podman-managing-containers-pods/) to run groups of containers. This feature of Podman replaces _docker\-compose_.

## Working with Virtual Machines

Fedora Workstation installs [GNOME Boxes](https://wiki.gnome.org/Apps/Boxes) by default, to enable you to create and manage virtual machines. GNOME Boxes provides a graphical interface for the standard KVM and QEMU software. You can also use these directly on the command-line.

# SQL Databases

Consider using containers to provide the database services for your Web applications.
This will enable you to use different versions of the database servers for different
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
