+++
Title = "Setting Up Fedora Workstation for Software Development"
Slug = "fedora-ws-setup"
Date = "2017-01-11T22:25:00+00:00"
Description = ""
Categories = ["administration", "programming"]
Tags = ["administration", "linux", "javascript", "python", "ruby", "rust"]
Type = "article"
Draft = true

+++


This is a set of notes for setting up Fedora Workstation, specifically for
system administration and Web development.

<!--more-->

# Do This First! #

Log in once, run the Software utility, and ensure that the operating system has
the latest updates. After all of the updates have been applied, restart the
computer.

# Configuring a User Account #

## Configuring The Trackpad ##

To make the trackpad behave correctly, ensure that these settings are
enabled:

* *Settings \> Mouse \& Touchpad \> Tap to Click*

# Configuring System Security #

Fedora is a secure operating system, but it is not yet perfect. If you are using
a laptop then you should probably make all of these changes as soon as possible.

## Basic Settings ##

Select *Settings \> Privacy*, and review the settings. Depending upon your
needs, you may decide to turn off *Location Services* or *Usage & History*.

## Enable Disk Encryption NOW ##

FIXME

Current versions of Fedora include a full-disk encryption system. You should
enable disk encryption *NOW*, because it is the only protection against anyone with
physical access to your computer. All other security measures will be completely
bypassed if someone with physical access simply restarts the computer with a
bootable pen drive.

> Disk encryption really is secure, which means that you can permanently lose access to your data if you
lose the passwords and the recovery key.

## Requiring a Password on Bootup ##

Modern Intel-based computers include EFI firmware that runs when the machine is
powered on, to start the operating system. This takes the place of the standard
PC BIOS, or Open Firmware on older Macs. If your computer is frequently left in
public places, then set a boot password. Otherwise, any malicious individual can
change the firmware settings to boot from a disc or device of their choosing. If
you did not enable disk encryption, then the attacker will have complete access
to all of the files on the system.

## Configuring a Firewall ##

FIXME

Fedora Workstation includes [firewalld](http://www.firewalld.org/), but does not provide a graphical utility to manage it in the initial installation.

## Setting Up Backups ##

FIXME

# Setting Up for Development #

Every developer needs a text editor and a version control system. Fedora
Workstation includes the [Git version control system](http://www.git-scm.com/),
but most developers prefer to install their own text editors and IDEs.

Fedora Workstation includes GCC and the C compiler toolchain by default. This
means that you can compile C programs and native extensions for languages like
Python and JavaScript without any extra requirements.

## Choosing a Text Editor ##

Fedora includes a command-line version of [vim](http://www.vim.org/), as well as
GNOME Text Editor, a desktop text editor. The Text Editor has some support for
programming, but is more useful for light-weight word processing. Unless you
already have a preferred editor, I suggest that you install
[Atom](http://www.atom.io),  which is a powerful graphical text editor.

Whichever text editor you choose, remember to set the EDITOR environment
variable in your *~/.bashrc* file, so that this editor is
automatically invoked by command-line tools like your version control
system. For example, put this line in your profile to make *vim* the
favored text editor:

    export EDITOR="vi"

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

If you are a Ruby on Rails developer, use this command to install support for
[CoffeeLint](http://www.coffeelint.org/) and
[Rubocop](http://batsov.com/rubocop/):

    apm install linter-coffeelint linter-rubocop

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
Fedora includes the standard OpenSSH suite of tools.

To create an SSH key, run the *ssh-keygen* command in a terminal window. For
example:

    ssh-keygen -t rsa -b 4096 -C "Me MyName (MyDevice) <me@mydomain.com>"

> Use 4096-bit RSA keys for all systems. The older DSA standard only supports
1024-bit keys, which are now too small to be considered secure.

# Setting Up Environments #

## nvm and Yarn for Node.js Development ##

FIXME: Test this!

To maintain multiple Node.js versions on your system, use the
[nvm](https://github.com/creationix/nvm) utility.

Enter this command to install nvm:

     curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash

Open a new Terminal window and enter this command:

    nvm install 6.9.4

This installs Node.js 6.9.4 and makes it the default Node.js run-time.

To install the [Yarn](http://yarnpkg.com) package manager, enter these commands
in a Terminal window:

    sudo wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo
    sudo dnf install yarn

Then add this to the end of your PATH:

    `yarn global bin`

For example:

    export PATH="$PATH:$HOME/.rvm/bin:$HOME/.cargo/bin:`yarn global bin`"

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
add any files into shared system directories. The Rust packages from Fedora
provide older versions of Rust, and do install the Rust tools into system
directories.

## RVM for Ruby Development ##

Fedora provides packages for Ruby, but these can be outdated. To maintain current
and clean Ruby environments, use the [RVM](https://rvm.io/) system.

FIXME: Test this!

By default, RVM downloads copies of Ruby that have been compiled for your
operating system. If there is no compiled version, RVM then falls back to
downloading the source code and then compiling it on your computer. Enter this
command to ensure that the requirements for compiling Ruby are on your system,
using DNF:

    sudo dnf install autoconf automake gdbm gmp libksba libtool libyaml openssl pkg-config readline

Finally, you can speed up installation of gem packages by disabling the
generation of local documentation. To do this, create a file in your
home directory with the name *.gemrc* and put this line in it:

    gem: --no-ri --no-rdoc

## pyenv for Python Development ##

Fedora includes a copy of Python 3. To maintain current and clean Python
environments, use the [pyenv](https://github.com/yyuu/pyenv) system and the
[pyenv-virtualenv](https://github.com/yyuu/pyenv-virtualenv) plugin.

FIXME Enter this command to install pyenv using Homebrew:

    brew install pyenv pyenv-virtualenv

Next, add this line to the *.bashrc* file in your home directory:

     if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

Open a new Terminal window and enter these commands:

    pyenv install 3.5.1
    pyenv global 3.5.1

These install Python 3.5 and make it the default Python run-time.

# Virtualization and Containers #

Fedora Workstation includes the *Boxes* application by default for
virtualization and remote desktop access. *Boxes* builds on the same KVM
virtualization technology that companies like DigitalOcean use for production
hosting.

Fedora includes *systemd-nspawn* for simple containers, and provides packages
for Docker. These may have more thorough testing and better system integration
than the packages from the Docker, Inc. Website. To install Docker on Fedora
Workstation, enter these commands in a terminal window:

    sudo dnf install docker
    sudo systemctl enable docker

FIXME: Does not run. See: http://www.projectatomic.io/blog/2015/06/notes-on-fedora-centos-and-docker-storage-drivers/

# SQL Databases #

If you develop any kind of database-driven application, it is useful to have a
version of the database server available on your system. Consider using
containers for this. If you prefer to install services directly on to your
workstation, Fedora provides packages for PostgreSQL and MariaDB.

## Installing PostgreSQL ##

To install PostgreSQL using DNF, enter these commands in a terminal window:

    sudo dnf install postgresql postgresql-server
    sudo postgresql-setup --initdb
    sudo systemctl start postgresql
    sudo systemctl enable postgresql

These commands install the server, the command-line tools, and the client
libraries that are needed to compile adapters for programming languages.

## Installing MariaDB or MySQL ##

To install MariaDB using DNF, enter these commands in a terminal window:

    sudo dnf install mariadb-server
    sudo systemctl enable mariadb
    sudo systemctl start mariadb

FIXME To install MySQL using DNF, enter this command in a terminal window:

    sudo dnf install mysql

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

# Online Resources #

FIXME
