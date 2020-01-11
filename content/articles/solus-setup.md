+++
Title = "Setting Up Solus for Software Development"
Slug = "solus-setup"
Date = "2018-07-15T01:01:00+00:00"
Description = "Setting up a Solus installation for development and systems administration"
Categories = ["devops", "programming"]
Tags = ["devops", "linux", "solus", "golang", "javascript", "python"]
Type = "article"
Toc = true

+++

How to set up an installation of the [Solus](https://getsol.us) Linux distribution on your PC for systems administration and Web development.

<!--more-->

# Installation

### Enable Disk Encryption

Enable _LVM_ and disk encryption when prompted during the setup process.

Disk encryption is the only protection against anyone with physical access to your
computer. All other security measures will be completely bypassed if someone with
physical access either restarts your computer with a bootable pen drive, or removes the
internal hard drive and attaches it to another computer.

### Set a Password for UEFI or BIOS

Once you have installed Solus, restart your computer, and press the function key to
enter the setup menu for the UEFI firmware, or BIOS. Change the boot options so that the
computer only boots from the hard drive, and set both a user password for startup, and
an administrator password to protect the firmware menus.

# Do This First!

Log in once, run the Software Center utility, and ensure that the operating system has
the latest updates. After all of the updates have been applied, restart the computer.

# User Settings

Select _Settings \> Privacy_, and review the settings. Depending upon your needs, you
may decide to turn off _Location Services_ or _Usage & History_.

# Setting Up for Development

Every developer needs a text editor and a version control system.

### Git Version Control

To install the [Git version control system](http://www.git-scm.com/) on Solus, run this
command in a terminal window:

    sudo eopkg install git

Always set your details before you create or clone repositories on a new system. This
requires two commands in a terminal window:

    git config --global user.name "Your Name"
    git config --global user.email "you@your-domain.com"

The _global_ option means that the setting will apply to every repository that you work
with in the current user account.

To enable colors in the output, which can be very helpful, enter this command:

    git config --global color.ui auto

### Text Editors

Solus includes a command-line version of [nano](https://www.nano-editor.org/), as well
as a desktop text editor. These text editors have some support for programming, but are
more useful for light-weight word processing. The package repositories include other editors and IDEs.

You will massively improve your experience with your text editor by adding a useful set
of extensions to it. The exact extensions that will benefit the most you depend upon the
work that you do, but you should always look at version control integration, convenient
access to the terminal, and linters for your preferred programming languages and data
file formats.

#### Setting The EDITOR Environment Variable

Whichever text editor you choose, remember to set the EDITOR environment variable in
your _~/.bashrc_ file, so that this editor is automatically invoked by command-line
tools like your version control system. For example, put this line in your profile to
make _nano_ the favored text editor:

    export EDITOR="nano"

### Setting Up A Directory Structure for Projects

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

### Creating SSH Keys

You will frequently use SSH to access Git repositories or remote UNIX systems. Solus
includes the standard OpenSSH suite of tools.

To create an SSH key, run the _ssh-keygen_ command in a terminal window. For example:

    ssh-keygen -t rsa -b 4096 -C "Me MyName (MyDevice) <me@mydomain.com>"

> Use 4096-bit RSA keys for all systems. The older DSA standard only supports 1024-bit
> keys, which are now too small to be considered secure.

# Setting Up Environments

### C Compiler

To install GCC and a complete C compiler toolchain on Solus, run this command in a
terminal window:

    sudo eopkg install -c system.devel

Once the toolchain is installed, you can compile C programs and native extensions for
languages like Python and JavaScript.

### nvm for Node.js Development

To maintain multiple Node.js versions on your system, use the
[nvm](https://github.com/creationix/nvm) utility.

Enter this command to install nvm:

     curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash

Open a new terminal window and enter this command:

    nvm install --lts

This installs the latest LTS release of Node.js, and makes it the default Node.js
run-time.

To upgrade the copy of _npm_ that is provided with Node.js, run this command in a
terminal window:

    npm -g upgrade npm

### Developer Tools for Go

Use _eopkg_ to install [Go](https://golang.org/):

    sudo eopkg install golang

Current versions of Go do not require a GOPATH environment variable, but you should set it to ensure that third-party tools and Terminal auto-completion work correctly.

Set a GOPATH environment variable in your _~/.bashrc_ file:

    export GOPATH="$HOME/go"

Then, add this to your PATH:

    $GOPATH/bin

Close the terminal and open it again for the changes to take effect.

### Python Development

Solus includes both Python 2 and Python 3. To run Python 3, be sure to specify _python3_
as the interpreter:

    python3 --version

The _python_ interpreter is Python 2, which you should not use for new software.

To maintain current and clean Python environments, install
[pipenv](https://docs.pipenv.org/). It drives the [pip](https://pip.pypa.io/en/stable/)
and [virtual environment](https://docs.python.org/3/tutorial/venv.html) features that
are included with Python itself, but is more powerful and easier to use than working
with these features directly.

### rustup for Rust Development

The official _rustup_ utility enables you to install the tools for building software
with the Rust programming language. Click on the Install button on the front page of the
[Rust Website](https://www.rust-lang.org), and follow the instructions.

This process installs all of the tools into your home directory, and does not add any
files into shared system directories.

The installer does not currently add the correct directory to your PATH. To use your
Rust installation, edit the _.bashrc_ file in your home directory to add this line:

    source $HOME/.cargo/env

Close the terminal and open it again for the changes to take effect.

The Rust packages from Solus may provide older versions of Rust, and will install the
Rust tools into system directories.

# Containers and Virtual Machines

Solus provides packages for [Docker](https://www.docker.com/), as well as including
_systemd-nspawn_ for simple containers. The Docker packages for Solus may have more
thorough testing and better system integration than the generic Linux packages from the
Docker, Inc. Website.

### Installing Docker

To install Docker on Solus, enter these commands in a terminal window:

    sudo eopkg install docker
    sudo systemctl enable docker
    sudo systemctl start docker

To enable your user account to manage Docker without administrative privileges, add your
user account to the _docker_ group:

    sudo usermod -aG docker USERNAME

Replace _USERNAME_ with your username. You must log out and log in again for this change
to take effect.

### Installing GNOME Boxes

If you need a virtual machine manager, consider using
[GNOME Boxes](https://wiki.gnome.org/Apps/Boxes) to create and manage your virtual
machines. To install the Solus package for GNOME Boxes:

    sudo eopkg install gnome-boxes

# SQL Databases

Consider using Docker containers to provide the database services for your Web
applications. This enables you to use different versions of the database servers for
different projects, and ensure that you are running the same versions as the database
instances on your production systems.

If you prefer to install services directly on to your workstation, Solus provides
packages for PostgreSQL and [MariaDB](https://mariadb.org/). If you need a database
server that is compatible with MySQL, install MariaDB. Otherwise, PostgreSQL is often a
better choice for new applications.

### Installing PostgreSQL

To install PostgreSQL using _eopkg_, enter these commands in a terminal window:

    sudo eopkg install postgresql
    sudo systemctl enable postgresql
    sudo systemctl start postgresql

These commands install the server, the command-line tools, and the client libraries that
are needed to compile adapters for programming languages.

To create a user account for yourself in PostgreSQL with administrative rights, enter
this command in a terminal window:

    sudo createuser -U postgres -s YOU

Replace _YOU_ with the username of your account on Solus.

The _-s_ option means that your new PostgreSQL account is a _superuser_, with unlimited
rights over the databases. Once you have a superuser account, you may use tools like
_createuser_ or log in to databases without using sudo or the _-U_ option.

For example, to create an extra user account that is not a superuser:

    createuser EXTRA-ACCOUNT

Replace _EXTRA-ACCOUNT_ with the username of the new account.

### Installing MariaDB

To install MariaDB using _eopkg_, enter these commands in a terminal window:

    sudo eopkg install mariadb-server
    sudo systemctl enable mariadb
    sudo systemctl start mariadb

These commands install the server, the command-line tools, and the client libraries that
are needed to compile adapters for programming languages.

> For compatibility, MariaDB uses the same names for command-line tools as MySQL.

Remember to set a password for the root accounts. First, login with the _mysql_
command-line utility:

    mysql -u root -q

> _The -q Option Disables Command History:_ By default, the command-line client stores
> the full text of every command in a history file. If you know that you are going to
> run statements that include passwords or other sensitive data, use the -q option.

Once you have logged into MariaDB, run these statements to change the password for root
access:

```sql
UPDATE mysql.user SET password = PASSWORD('yourpassword') WHERE user
LIKE ‘root’;
FLUSH PRIVILEGES;
EXIT;
```

You now need a password to login to the installation as root. To login with root again,
use this command:

    mysql -u root -p

Enter the password when prompted.

You should also remove the anonymous accounts and test database that MariaDB
automatically includes. Log in to MariaDB and run these statements:

```sql
DROP DATABASE test;
DELETE FROM mysql.user WHERE user = ’’;
FLUSH PRIVILEGES;
```

Use SQL statements to create additional user accounts.
