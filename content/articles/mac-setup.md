+++
Title = "Setting Up an Apple Mac for Software Development"
Slug = "mac-setup"
Date = "2018-09-03T21:07:00+01:00"
Description = "Setting up an Apple Mac for development and systems administration"
Categories = ["administration", "programming"]
Tags = ["administration", "macos", "golang", "javascript", "python", "ruby", "rust"]
Type = "article"

+++

This is a guide for setting up an Apple Mac for software development. Current versions
of macOS have a fairly good default configuration for general-purpose use, but you do
need to to adjust some of the security settings. In addition, you need to install
several pieces of software in order to make the system useful for development.

<!--more-->

# Do This First!

Log in once, run Software Update, and ensure that the operating system is at the latest
point release. After all of the updates have been applied, restart the computer.

Log in again and create an Admin user account for your use. If other people will be
using the machine, create Standard accounts for them. Log out of the initial account,
and log in to the Admin account that you have just created.

Always log in with this new Admin account. The benefit of leaving the initial account
untouched is that it ensures that you always have a working account to login with.

> _Admin accounts have sudo privileges:_ All Admin accounts on a Mac may use sudo to run
> command-line utilities with administrative (root) privileges.

You should also find an external hard drive. Begin using Time Machine as soon as
possible, as it provides the most easy method for backing up your system.

# Configuring a User Account

## Configuring The Trackpad

To make the trackpad behave correctly, ensure that these settings are enabled:

- _System Preferences \> Trackpad \> Tap to click_
- _System Preferences \> Accessibility \> Mouse & Trackpad \> Trackpad Options… \>
  Enable dragging_

## Creating a Private Applications Folder

Once you have logged into your account, create a folder called _Applications_ within
your home folder. Whenever you are prompted to drag a new applications into the global
Applications folder, put it in this private Applications folder instead. Some
applications have to be installed to global folders, but in most cases you can keep the
system directories clean by storing third-party products in your private Applications
folder.

## Securing the Safari Browser

Whether or not you regularly use Safari, you should open it once, and adjust the
settings in case that you use it later.

First, choose _Safari \> Preferences \> General_ and deselect the option _Open “safe”
files after downloading_.

Then, check the plug-in settings. Go to _Safari \> Preferences \> Security \> Plug-in
Settings..._ and review the plug-ins and settings.

# Configuring Security

Apple provide quite secure operating systems, but unfortunately convenience has won out
over security in a few places. These can easily be corrected by changing a few settings.
If you are using a laptop then you should probably make all of these changes as soon as
possible.

## Basic Settings

Select _System Preferences \> Security & Privacy_, and set the following:

- Under _General_, set _require a password after sleep or screen saver begins_ to
  _immediately_
- Click _Advanced..._ and select _Require an administrator password to access
  system-wide preferences_
- Under _Firewall_, click _Turn Firewall On_.

## Enable File Vault NOW

Current versions of macOS include File Vault 2, a full-disk encryption system that has
little in common with the much more limited File Vault 1. You should enable File Vault
_NOW_, because it is the only protection against anyone with physical access to your
computer. All other security measures will be completely bypassed if someone with
physical access simply restarts the computer with a bootable pen drive.

> File Vault really is secure, which means that you can permanently lose access to your
> data if you lose the passwords and the recovery key.

## Set a Firmware Password

Set a password to stop access to the
[Recovery](https://support.apple.com/en-us/HT201314) mode. Otherwise, any malicious
individual can change the firmware settings to boot from a disc or device of their
choosing. If you did not enable File Vault, then the attacker will have complete access
to all of the files on the system.

[Apple Knowledge Base article HT204455](https://support.apple.com/en-gb/HT204455)
provides full details.

## Setting Up Time Machine Backups

Time Machine is simple to set up. Just take a suitably large external hard drive, plug it
in to your Mac, and agree when prompted. The drive setup process will reformat the hard
drive. The only settings that may need to change are the exclusions.

Choose _System Preferences \> Time Machine_, and click _Options_. Add to the exclusions
list any folders that contain ISO disk images, virtual machines, or database files (such
as Entourage). If the external hard drive is short of space, exclude the _System_
folder.

# Setting Up for Development

The first step is to install a compiler. The easiest way to install one is with the
_Xcode Command Line Tools_ package.

Once you have the compiler that is provided by Xcode, you can use
[Homebrew](http://brew.sh/) to install everything else that you need. Homebrew itself
manages packages for command-line tools and services. The
[Cask](https://caskroom.github.io/) extension to Homebrew enables you to install
graphical desktop applications.

## Getting Xcode

Apple now provide the Xcode suite as a free download from the App Store. To install
Xcode Command Line Tools, install Xcode from the App Store, then open a Terminal window
and enter the following command:

    xcode-select --install

## Setting Up Homebrew

[Homebrew](http://brew.sh/) provides a package management system for macOS, enabling you
to quickly install and update the tools and libraries that you need. Follow the
instructions on the site.

You should also amend your PATH, so that the versions of tools that are installed with
Homebrew take precedence over others. To do this, edit the file _.bash_profile_ in
your home directory to include this line:

    export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

You need to close all terminal windows for this change to take effect.

To check that Homebrew is installed correctly, run this command in a terminal window:

    brew doctor

To update the index of available packages, run this command in a terminal window:

    brew update

Once you have set up Homebrew, use the _brew install_ command to add command-line software to your Mac, and _brew cask install_ to add graphical software. For example, this command installs the Slack app:

    brew cask install slack

## Installing the Git Version Control System

The Xcode Command Line Tools include a copy of [Git](http://www.git-scm.com/), which is
now the standard for Open Source development, but this will be out of date.

To install a newer version of Git than Apple provide, use Homebrew. Enter this command in a terminal window:

    brew install git

If you do not use Homebrew, go to the [Web site](http://www.git-scm.com/) and follow the
link for _Other Download Options_ to obtain a macOS disk image. Open your downloaded
copy of the disk image and run the enclosed installer in the usual way, then dismount
the disk image.

Always set your details before you create or clone repositories on a new system. This
requires two commands in a terminal window:

    git config --global user.name "Your Name"
    git config --global user.email "you@your-domain.com"

The _global_ option means that the setting will apply to every repository that you work
with in the current user account.

To enable colors in the output, which can be very helpful, enter this command:

    git config --global color.ui auto

## Text Editors

Installations of macOS include older command-line versions of both
[Emacs](http://www.gnu.org/software/emacs/) and [vim](http://www.vim.org/), as well as
TextEdit, a desktop text editor. TextEdit is designed for light-weight word processing,
and has no support for programming. Unless you already have a preferred editor, I
suggest that you install either [Visual Studio Code](https://code.visualstudio.com) or [Oni](https://www.onivim.io/), which are powerful graphical text editors, or [Neovim](https://neovim.io) for a console Vim editor.

### Setting The EDITOR Environment Variable

Whichever text editor you choose, remember to set the EDITOR environment variable in
your _~/.bash\_profile_ file, so that this editor is automatically invoked by
command-line tools like your version control system. For example, put this line in your
profile to make Neovim (_nvim_) the favored text editor:

    export EDITOR="nvim"

### Setting Up Visual Studio Code

To install Visual Studio Code, enter this command in a terminal window:

    brew cask install visual-studio-code

Consider installing these extensions:

- Support for your preferred languages, e.g.
  [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python),
  [Ruby](https://marketplace.visualstudio.com/items?itemName=rebornix.ruby) or
  [Go](https://marketplace.visualstudio.com/items?itemName=ms-vscode.Go)
- [ESLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
  or [TSLint](https://marketplace.visualstudio.com/items?itemName=eg2.tslint) for
  JavaScript linter integration
- [Debugger for Chrome](https://marketplace.visualstudio.com/items?itemName=msjsdiag.debugger-for-chrome)
  to debug JavaScript in the Web browser
- [Git Lens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens) to
  enhance the Git support in the user interface
- The
  [Docker](https://marketplace.visualstudio.com/items?itemName=PeterJausovec.vscode-docker)
  extension
- [YAML Support](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml)

To make Visual Studio Code your default editor, use this line in your _~/.bash\_profile_ file:

    export EDITOR="code -w"

Visual Studio Code enables telemetry and crash reporting by default. To disable these, set these options in _Preferences > Settings_:

```json
"telemetry.enableTelemetry": false,
"telemetry.enableCrashReporter": false
```

If you would like to enable Vim keybindings in Visual Studio Code, install the [VSCodeVim](https://marketplace.visualstudio.com/items?itemName=vscodevim.vim) extension.

### Setting Up Neovim

To install Neovim on macOS with Homebrew, run this command:

    brew install neovim

Remember to set the EDITOR environment
variable in your _~/.bash\_profile_ file, so that this editor is
automatically invoked by command-line tools like your version control
system.

To make Neovim your default editor, use this line:

    export EDITOR="nvim"

Once you have installed Neovim, create a file called _~/.config/nvim/init.vim_. This is your configuration file for Neovim.

This command creates a _init.vim_ file with the _leader_ option specified to set a leader key:

    echo 'let mapleader = ","' >> ~/.config/nvim/init.vim

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

> Oni automatically detects an existing Neovim configuration, and will offer to use instead of the default settings.

## Setting Up A Directory Structure for Projects

To keep your projects tidy, I would recommend following the
[Go developer conventions](http://golang.org/doc/code.html). These guidelines may seem
slightly fussy, but they pay off when you have many projects, some of which are on
different version control hosts.

First create a top-level directory with a short, generic name like _code_. By default Go
uses a directory called _go_, but you can change that when you set up a Go installation.

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

You will frequently use SSH to access Git repositories or remote UNIX systems. macOS
includes the standard OpenSSH suite of tools.

OpenSSH stores your SSH keys in a _.ssh_ directory. To create this directory, run these commands in a terminal window:

    mkdir $HOME/.ssh
    chmod 0700 $HOME/.ssh

To create an SSH key, run the _ssh-keygen_ command in a terminal window. For example:

    ssh-keygen -t rsa -b 4096 -C "Me MyName (MyDevice) <me@mydomain.com>"

> Use 4096-bit RSA keys for all systems. The older DSA standard only supports 1024-bit
> keys, which are now too small to be considered secure.

# Setting Up Environments

## Node.js for JavaScript Development

Homebrew provides separate packages for each version of [Node.js](https://nodejs.org).
To ensure that you are using the version of Node.js that you expect, specify the version
when you install it. For example, enter this command in a Terminal window to install the
Node.js 8, the current LTS release:

    brew install node@8

Add the _bin/_ directory for this Node.js installation to your PATH:

    /usr/local/opt/node@8/bin

If you need [yarn](https://yarnpkg.com/en/), enter this command in a Terminal window to
install it:

    brew install yarn

## Developer Tools for Go

Use Homebrew to install [Go](https://golang.org/) and the
[dep](https://golang.github.io/dep/) tool:

    brew install golang dep

The current version of Go includes experimental support for dependency management with modules, but existing projects are likely to either use dep, or an older tool.

### Setting a GOPATH

By default, current versions of Go automatically create and use a _go_ directory in your
home directory as the GOPATH. To ensure that third-party tools and Terminal
auto-completion work, you should still explicitly set the environment variables.

Set a GOPATH environment variable in your _~/.bashrc_ file:

    export GOPATH="$HOME/go"

Then, add this to your PATH:

    $GOPATH/bin

Close the Terminal and open it again for the changes to take effect.

## rustup for Rust Development

The official _rustup_ utility enables you to install the tools for building software
with the Rust programming language. Click on the Install button on the front page of the
[Rust Website](https://www.rust-lang.org), and follow the instructions.

By default, the installer adds the correct directory to your path. If this does not
work, add this to your PATH manually:

    $HOME/.cargo/bin

This process installs all of the tools into your home directory, and does not add any
files into system directories.

## RVM for Ruby Development

All macOS systems include a copy of Ruby, but it is outdated. To maintain current and
clean Ruby environments, use the [RVM](https://rvm.io/) system.

RVM relies on Git, so you must have a working installation of Git before you can set up
RVM.

By default, RVM downloads copies of Ruby that have been compiled for your operating
system. If there is no compiled version, RVM then falls back to downloading the source
code and then compiling it on your computer. Enter this command to ensure that the
requirements for compiling Ruby are on your system, using Homebrew:

    brew install autoconf automake gdbm gmp libksba libtool libyaml openssl pkg-config readline

Finally, you can speed up installation of gem packages by disabling the generation of
local documentation. To do this, create a file in your home directory with the name
_.gemrc_ and put this line in it:

    gem: --no-ri --no-rdoc

## pipenv for Python Development

Unfortunately, macOS includes a copy of Python 2, so you will need to install Python 3 yourself. To maintain current and
clean Python environments, you should also install [pipenv](https://docs.pipenv.org/). It drives the
[pip](https://pip.pypa.io/en/stable/) and
[virtual environment](https://docs.python.org/3/tutorial/venv.html) features that are
included with Python itself, but is more powerful and easier to use than working with
these features directly.

Enter this command to install Python 3 and pipenv using Homebrew:

    brew install python3 pipenv

The pipenv tool itself will use the copy of Python 3 from Homebrew by default. To use
this Python 3 interpreter without pipenv, specify _python3_ on the command-line and in
your scripts, rather than _python_:

    python3 --version

If you need to run the _pip_ utility, rather than setting up a development environment with pipenv, always use the command _pip3_:

    pip3 --version

The [Python Guide tutorial](http://docs.python-guide.org/en/latest/dev/virtualenvs/)
shows you how to work with _pipenv_.

# SQL Databases

If you develop any kind of database-driven application, it is useful to have a version
of the database server available on your system. Consider using
[Docker](https://www.docker.com/) containers for this. If you prefer to install services
directly on to your workstation, Homebrew provides packages for PostgreSQL, MariaDB and
MySQL.

## Installing PostgreSQL

To install PostgreSQL using Homebrew, enter this command in a terminal window:

    brew install postgresql

This command installs the server, the command-line tools, and the client libraries that
are needed to compile adapters for programming languages.

Homebrew also provides some commands for managing your PostgreSQL installation. For
example, to start the server, follow the instructions that are displayed after the
installation process is completed. If you upgrade your copy of PostgreSQL, you should
use the _postgresql-upgrade-database_ command that Homebrew gives you.

## Installing MariaDB or MySQL

To install MariaDB using Homebrew, enter this command in a terminal window:

    brew install mariadb

To install MySQL using Homebrew, enter this command in a terminal window:

    brew install mysql

These commands install the server, the command-line tools, and the client libraries that
are needed to compile adapters for programming languages. To start the server, follow
the instructions that are displayed after the installation process is completed.

> For compatibility, MariaDB uses the same names for command-line tools as MySQL.

Remember to set a password for the root accounts. First, login with the _mysql_
command-line utility:

    mysql -u root -q

> _The -q Option Disables Command History:_ By default, the command-line client stores
> the full text of every command in a history file. If you know that you are going to
> run statements that include passwords or other sensitive data, use the -q option.

Run these statements to change the password for root access:

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

You should also remove the anonymous accounts and test database that MySQL automatically
includes:

```sql
DROP DATABASE test;
DELETE FROM mysql.user WHERE user = ’’;
FLUSH PRIVILEGES;
```

If you intend to duplicate a production environment for testing, create a configuration
file on your Mac. Production installations of MySQL should be configured with
appropriate _SQL modes_ to enable data integrity safeguards. By default, MySQL permits
various types of invalid data to be entered.

# Other Useful Desktop Applications for Developers

- [LibreOffice](http://www.libreoffice.org/) suite: _brew cask install libreoffice_
- [VirtualBox](http://www.virtualbox.org/) virtual machine management: _brew cask install virtualbox_
- [Docker](https://store.docker.com/editions/community/docker-ce-desktop-mac) container management: _brew cask install docker_
- [MySQL Workbench](http://wb.mysql.com/): _brew cask install mysqlworkbench_

# Online Resources

Apple offer overviews and task-orientated help on their
[support Web site for new macOS users](https://support.apple.com/explore/new-to-mac).

Every new user should probably read
[How to switch to the Mac](http://taoofmac.com/space/HOWTO/Switch), by Rui Carmo.
