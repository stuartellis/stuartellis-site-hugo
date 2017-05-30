+++
Title = "Setting Up Solus for Software Development"
Slug = "solus-setup"
Date = "2017-05-30T21:50:00+01:00"
Description = "Setting up a Solus installation for development and systems administration"
Categories = ["administration", "programming"]
Tags = ["administration", "linux", "javascript", "python", "ruby", "rust"]
Type = "article"
Draft = true

+++


This is a set of notes for setting up a [Solus](https://solus-project.com/)
installation on your PC, specifically for system administration and Web
development.

<!--more-->

# Installation #

## Enable Disk Encryption ##

Enable *LVM* and disk encryption when prompted during the setup process.

Disk encryption is the only protection against anyone with physical access to
your computer. All other security measures will be completely bypassed if
someone with physical access simply restarts the computer with a bootable pen
drive or remove the internal hard drive.

## Set a Password for UEFI ##

Modern Intel-based computers include UEFI firmware that runs when the machine is
powered on, to start the operating system. Restart your computer, press the
function key to enter the setup menu. Change the boot options so that the
computer only boots from the hard drive, and set both a user password for
startup, and an administrator password to protect the UEFI menus.

# Do This First! #

Log in once, run the Software Center utility, and ensure that the operating
system has the latest updates. After all of the updates have been applied,
restart the computer.

# Configuring System Security #

## Basic Settings ##

Select *Settings \> Privacy*, and review the settings. Depending upon your
needs, you may decide to turn off *Location Services* or *Usage & History*.

## Consider Requiring a Password on Bootup ##

If your computer is frequently left in
public places, then set a boot password. Otherwise, any malicious individual can
change the firmware settings to boot from a disc or device of their choosing. If
you did not enable disk encryption, then the attacker will have complete access
to all of the files on the system.

## Configuring a Firewall ##

FIXME

Solus includes [firewalld](http://www.firewalld.org/), but does not provide a graphical utility to manage it in the initial installation.

## Setting Up Backups ##

FIXME

# Setting Up for Development #

Every developer needs a text editor and a version control system.

To install the [Git version control system](http://www.git-scm.com/) on Solus,
run this command in a terminal window:

    sudo eopkg install git

To install GCC and the C compiler toolchain on Solus, run this command in a
terminal window:

    sudo eopkg install -c system.devel

Once the toolchain is installed, you can compile C programs and native
extensions for languages like Python and JavaScript.

## Choosing a Text Editor ##

Solus includes a command-line version of [nano](https://www.nano-editor.org/),
as well as a desktop text editor. The text editor has some support for
programming, but is more useful for light-weight word processing. Unless you
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

    apm install atom-beautify color-picker file-icons git-plus minimap

The [file-icons](https://atom.io/packages/file-icons) package requires no
configuration. Refer to the pages for
[atom-beautify](https://atom.io/packages/atom-beautify),
[color-picker](https://atom.io/packages/color-picker),
[git-plus](https://atom.io/packages/git-plus) and
[minimap](https://atom.io/packages/minimap) for details on how to use them.

Install code linters for the languages that you use. Atom
automatically runs the appropriate linter for the files that you are editing.

This command installs
support for [CSSLint](http://csslint.net/), [ESLint](http://eslint.org/) and
[yaml-js](http://nodeca.github.com/js-yaml/):

    apm install linter-csslint linter-eslint linter-js-yaml

## Setting Up A Directory Structure for Projects ##

To keep your projects tidy, I would recommend following the [Go developer
conventions](http://golang.org/doc/code.html). These guidelines may seem
slightly fussy, but they pay off when you have many projects, some of which are
on different version control hosts.

First create a top-level directory with a short, generic name like *code*. In
this directory, create an *src* sub-directory. For each repository host, create
a subdirectory in *src* that matches your username. Check out projects in the
directory. The final directory structure looks like this:

    code/
      src/
        bitbucket.org/
          my-bitbucket-username/
            a-project/
        github.com/
          my-github-username/
            another-project/

If you use Go, add *bin*, *doc* and *pkg* directories:

    code/
      bin/
      doc/
      pkg/
      src/
        bitbucket.org/
          my-bitbucket-username/
            a-project/
        github.com/
          my-github-username/
            another-project/

Once you set the top-level directory as the environment variable GOPATH, Go will
compile to the *bin*, *doc* and *pkg* subdirectories. You can add the *bin*
directory to your PATH to be able to run the compiled programs by typing their
names. You may or may not choose to use these directories with other programming
environments.

## Creating SSH Keys ##

You will frequently use SSH to access Git repositories or remote UNIX systems.
Solus includes the standard OpenSSH suite of tools.

To create an SSH key, run the *ssh-keygen* command in a terminal window. For
example:

    ssh-keygen -t rsa -b 4096 -C "Me MyName (MyDevice) <me@mydomain.com>"

> Use 4096-bit RSA keys for all systems. The older DSA standard only supports
1024-bit keys, which are now too small to be considered secure.

# Setting Up Environments #

## nvm for Node.js Development ##

FIXME: Test this! and update other docs

To maintain multiple Node.js versions on your system, use the
[nvm](https://github.com/creationix/nvm) utility.

Enter this command to install nvm:

     curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash

Open a new terminal window and enter this command:

    nvm install --lts

This installs the latest LTS release of Node.js, and makes it the default
Node.js run-time.

## Developer Tools for Go ##

Use *eopkg* to install [Go](https://golang.org/):

    sudo eopkg install golang

### Setting a Custom GOPATH ###

By default, current versions of Go automatically create and use a *go* directory
in your home directory as the GOPATH. To specify a custom GOPATH, such as a
*code* directory, set the GOPATH environment variable in your *~/.bashrc* file:

    export GOPATH="$HOME/code"

Add this to your PATH:

    $GOPATH/bin

Close the terminal and open it again for the changes to take effect.

## rustup for Rust Development ##

The official *rustup* utility enables you to install the tools for building
software with the Rust programming language. Click on the Install button on the
front page of the [Rust Website](https://www.rust-lang.org), and follow the
instructions.

By default, the installer adds the correct directory to your path. If this does
not work, add this to your PATH manually:

    $HOME/.cargo/bin

FIXME: Adding to .bash_profile PATH does not work

This process installs all of the tools into your home directory, and does not
add any files into shared system directories. The Rust packages from Solus
provide older versions of Rust, and do install the Rust tools into system
directories.

## RVM for Ruby Development ##

Solus provides packages for Ruby, but these can be outdated. To maintain current
and clean Ruby environments, use the [RVM](https://rvm.io/) system.

FIXME: Test this!

By default, RVM downloads copies of Ruby that have been compiled for your
operating system. If there is no compiled version, RVM then falls back to
downloading the source code and then compiling it on your computer. Enter this
command to ensure that the requirements for compiling Ruby are on your system,
using *eopkg*:

    sudo eopkg install autoconf automake gdbm gmp libksba libtool libyaml openssl pkg-config readline

Finally, you can speed up installation of gem packages by disabling the
generation of local documentation. To do this, create a file in your
home directory with the name *.gemrc* and put this line in it:

    gem: --no-ri --no-rdoc

## pyenv for Python Development ##

Solus includes a copy of Python 3. To maintain current and clean Python
environments, use the [pyenv](https://github.com/yyuu/pyenv) system and the
[pyenv-virtualenv](https://github.com/yyuu/pyenv-virtualenv) plugin.

FIXME Enter this command to install pyenv using Homebrew:

    sudo eopkg install pyenv pyenv-virtualenv

Next, add this line to the *.bashrc* file in your home directory:

    if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

Open a new terminal window and enter these commands:

    pyenv install 3.6.1
    pyenv global 3.6.1

These install Python 3.6.1 and make it the default Python run-time.

# Containers #

Solus includes *systemd-nspawn* for simple containers, and provides packages for
Docker. These may have more thorough testing and better system integration than
the packages from the Docker, Inc. Website. To install Docker on Solus, enter
these commands in a terminal window:

    sudo eopkg install docker
    sudo systemctl enable docker
    sudo systemctl start docker

To enable your user account to manage Docker without administrative privileges,
add your user account to the *docker* group:

    sudo usermod -G docker USERNAME

Replace *USERNAME* with your username. You must log out and log in again for
this change to take effect.

# SQL Databases #

If you develop any kind of database-driven application, it is useful to have a
version of the database server available on your system. Consider using
containers for this. If you prefer to install services directly on to your
workstation, Solus provides packages for PostgreSQL and MariaDB.

## Installing PostgreSQL ##

To install PostgreSQL using *eopkg*, enter these commands in a terminal window:

    sudo eopkg install postgresql postgresql-server
    sudo postgresql-setup --initdb
    sudo systemctl start postgresql
    sudo systemctl enable postgresql

These commands install the server, the command-line tools, and the client
libraries that are needed to compile adapters for programming languages.

## Installing MariaDB or MySQL ##

To install MariaDB using *eopkg*, enter these commands in a terminal window:

    sudo eopkg install mariadb-server
    sudo systemctl enable mariadb
    sudo systemctl start mariadb

FIXME To install MySQL using *eopkg*, enter this command in a terminal window:

    sudo eopkg install mysql

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

Run these statements to change the password for root access:

~~~sql
UPDATE mysql.user SET password = PASSWORD ('yourpassword') WHERE user
LIKE ‘root’;
FLUSH PRIVILEGES;
EXIT;
~~~

You now need a password to login to the installation as root. To login
with root again, use this command:

    mysql -u root -p

Enter the password when prompted.

You should also remove the anonymous accounts and test database that
MySQL automatically includes:

~~~sql
DROP DATABASE test;
DELETE FROM mysql.user WHERE user = ’’;
FLUSH PRIVILEGES;
~~~

If you intend to duplicate a production environment for testing, create a
configuration file on your Mac. Production installations of MySQL should be
configured with appropriate *SQL modes* to enable data integrity safeguards. By
default, MySQL permits various types of invalid data to be entered.

# Other Useful Desktop Applications for Developers #

FIXME

*Settings \> Online Accounts*

[Web page for third-party applications](https://solus-project.com/articles/software/third-party/en/)

* Google Chrome
* AWS CLI
* Heroku CLI
* Slack
* IRC client
* Virtual machine management: [VirtualBox](http://www.virtualbox.org/)
* MySQL database management: [MySQL Workbench](http://wb.mysql.com/)

# Online Resources #

FIXME
