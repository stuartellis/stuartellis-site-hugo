+++
Title = "Setting Up Solus for Software Development"
Slug = "solus-setup"
Date = "2017-08-04T20:30:00+01:00"
Description = "Setting up a Solus installation for development and systems administration"
Categories = ["administration", "programming"]
Tags = ["administration", "linux", "solus", "golang", "javascript", "python", "rust"]
Type = "article"

+++


This is a set of notes for setting up an installation of the
[Solus](https://solus-project.com/) Linux distribution on your PC, specifically
for systems administration and Web development.

<!--more-->

# Installation #

## Enable Disk Encryption ##

Enable *LVM* and disk encryption when prompted during the setup process.

Disk encryption is the only protection against anyone with physical access to
your computer. All other security measures will be completely bypassed if
someone with physical access either restarts your computer with a bootable pen
drive, or removes the internal hard drive and attaches it to another computer.

## Set a Password for UEFI or BIOS ##

Once you have installed Solus, restart your computer, and press the function key
to enter the setup menu for the UEFI firmware, or BIOS. Change the boot options
so that the computer only boots from the hard drive, and set both a user
password for startup, and an administrator password to protect the firmware
menus.

# Do This First! #

Log in once, run the Software Center utility, and ensure that the operating
system has the latest updates. After all of the updates have been applied,
restart the computer.

# Configuring System Security #

## User Settings ##

Select *Settings \> Privacy*, and review the settings. Depending upon your
needs, you may decide to turn off *Location Services* or *Usage & History*.

## Consider Requiring a Password on Bootup ##

If your computer is frequently left in
public places, then set a boot password. Otherwise, any malicious individual can
change the firmware settings to boot from a disc or device of their choosing. If
you did not enable disk encryption, then the attacker will have complete access
to all of the files on the system.

# Setting Up for Development #

Every developer needs a text editor and a version control system.

## Git Version Control ##

To install the [Git version control system](http://www.git-scm.com/) on Solus,
run this command in a terminal window:

    sudo eopkg install git

Always set your details before you create or clone repositories on a new system.
This requires two commands in a terminal window:

    git config --global user.name "Your Name"
    git config --global user.email "you@your-domain.com"

The *global* option means that the setting will apply to every
repository that you work with in the current user account.

To enable colors in the output, which can be very helpful, enter this
command:

    git config --global color.ui auto

## Choosing a Text Editor ##

Solus includes a command-line version of [nano](https://www.nano-editor.org/),
as well as a desktop text editor. These text editors have some support for
programming, but are more useful for light-weight word processing. Unless you
already have a preferred editor, I suggest that you install
[Atom](http://www.atom.io), which is a powerful graphical text editor that is
specifically designed for programming.

To install Atom, enter this command in a terminal window:

    sudo eopkg install atom

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

    apm install color-picker file-icons minimap

The [file-icons](https://atom.io/packages/file-icons) package requires no
configuration. Refer to the pages for
[color-picker](https://atom.io/packages/color-picker) and
[minimap](https://atom.io/packages/minimap) for details on how to use them.

Install code linters for the languages that you use. Atom automatically runs the
appropriate linter for the files that you are editing. This command installs
support for CSS (using [CSSLint](http://csslint.net/)), JavaScript (using
[ESLint](http://eslint.org/)) and YAML (using
[yaml-js](http://nodeca.github.com/js-yaml/)):

    apm install linter-csslint linter-eslint linter-js-yaml

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
Solus includes the standard OpenSSH suite of tools.

To create an SSH key, run the *ssh-keygen* command in a terminal window. For
example:

    ssh-keygen -t rsa -b 4096 -C "Me MyName (MyDevice) <me@mydomain.com>"

> Use 4096-bit RSA keys for all systems. The older DSA standard only supports
1024-bit keys, which are now too small to be considered secure.

# Setting Up Environments #

## C Compiler ##

To install GCC and a complete C compiler toolchain on Solus, run this command in
a terminal window:

    sudo eopkg install -c system.devel

Once the toolchain is installed, you can compile C programs and native
extensions for languages like Python and JavaScript.

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

Use *eopkg* to install [Go](https://golang.org/):

    sudo eopkg install golang

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

The Rust packages from Solus may provide older versions of Rust, and do install
the Rust tools into system directories.

## Python Development ##

Solus includes both Python 2 and Python 3.

To run Python 3, be sure to specify *python3* as the interpreter, instead of
*python*. The *python* interpreter is Python 2.

# Containers and Virtual Machines #

Solus provides packages for [Docker](https://www.docker.com/), as well as
including *systemd-nspawn* for simple containers. The Docker packages for Solus
may have more thorough testing and better system integration than the generic
Linux packages from the Docker, Inc. Website.

## Installing Docker ##

To install Docker on Solus, enter these commands in a terminal window:

    sudo eopkg install docker
    sudo systemctl enable docker
    sudo systemctl start docker

To enable your user account to manage Docker without administrative privileges,
add your user account to the *docker* group:

    sudo usermod -aG docker USERNAME

Replace *USERNAME* with your username. You must log out and log in again for
this change to take effect.

## Installing GNOME Boxes ##

If you need a virtual machine manager, consider using [GNOME
Boxes](https://wiki.gnome.org/Apps/Boxes) to create and manage your virtual
machines. To install the Solus package for GNOME Boxes:

    sudo eopkg install gnome-boxes

# SQL Databases #

Consider using Docker containers to provide the database services for your Web
applications. This enables you to use different versions of the database servers
for different projects, and ensure that you are running the same versions as the
database instances on your production systems.

If you prefer to install services directly on to your workstation, Solus
provides packages for PostgreSQL and [MariaDB](https://mariadb.org/). If you
need a database server that is compatible with MySQL, install MariaDB.
Otherwise, PostgreSQL is often a better choice for new applications.

## Installing PostgreSQL ##

To install PostgreSQL using *eopkg*, enter these commands in a terminal window:

    sudo eopkg install postgresql
    sudo systemctl enable postgresql
    sudo systemctl start postgresql

These commands install the server, the command-line tools, and the client
libraries that are needed to compile adapters for programming languages.

To create a user account for yourself in PostgreSQL with administrative rights,
enter this command in a terminal window:

    sudo createuser -U postgres -s YOU

Replace *YOU* with the username of your account on Solus.

The *-s* option means that your new PostgreSQL account is a *superuser*, with
unlimited rights over the databases. Once you have a superuser account, you may
use tools like *createuser* or log in to databases without using sudo or the
*-U* option.

For example, to create an extra user account that is not a superuser:

    createuser EXTRA-ACCOUNT

Replace *EXTRA-ACCOUNT* with the username of the new account.

## Installing MariaDB ##

To install MariaDB using *eopkg*, enter these commands in a terminal window:

    sudo eopkg install mariadb-server
    sudo systemctl enable mariadb
    sudo systemctl start mariadb

These commands install the server, the command-line tools, and the client
libraries that are needed to compile adapters for programming languages.

> For compatibility, MariaDB uses the same names for command-line tools as MySQL.

Remember to set a password for the root accounts. First, login with the *mysql*
command-line utility:

    mysql -u root -q

> *The -q Option Disables Command History:* By default, the command-line client
> stores the full text of every command in a history file. If you know
> that you are going to run statements that include passwords or other
> sensitive data, use the -q option.

Once you have logged into MariaDB, run these statements to change the password
for root access:

~~~sql
UPDATE mysql.user SET password = PASSWORD('yourpassword') WHERE user
LIKE ‘root’;
FLUSH PRIVILEGES;
EXIT;
~~~

You now need a password to login to the installation as root. To login
with root again, use this command:

    mysql -u root -p

Enter the password when prompted.

You should also remove the anonymous accounts and test database that
MariaDB automatically includes. Log in to MariaDB and run these statements:

~~~sql
DROP DATABASE test;
DELETE FROM mysql.user WHERE user = ’’;
FLUSH PRIVILEGES;
~~~

Use SQL statements to create additional user accounts.

# Installing Proprietary Desktop Applications #

To install Google Chrome, Skype, Slack and other proprietary software, visit the
[Web page for third-party
applications](https://solus-project.com/articles/software/third-party/en/), and
follow the instructions. The Software Center also offers some, but not all, of
these products in the *Third Party* section.
