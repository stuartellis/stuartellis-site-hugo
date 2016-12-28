+++
Title = "Setting Up an Apple Mac for Software Development"
Slug = "mac-setup"
Date = "2016-12-28T11:38:00+00:00"
Description = ""
Categories = ["administration", "programming"]
Tags = ["administration", "macos", "javascript", "python", "ruby", "rust"]
Type = "article"

+++


This is a set of notes for setting up an Apple Mac, specifically as a
development system. Current versions of macOS have a fairly good default
configuration for general-purpose use, but you do need to to adjust some
of the security settings. In addition, you need to install several
pieces of software in order to make the system useful for development.

<!--more-->

# Do This First! #

Log in once, run Software Update, and ensure that the operating system is at the
latest point release. After all of the updates have been applied, restart the
computer.

Log in again and create an Admin user account for your use. If other people will
be using the machine, create Standard accounts for them. Log out of the initial
account, and log in to the Admin account that you have just created.

Always log in with this new Admin account. The benefit of leaving the initial
account untouched is that it ensures that you always have a working account to
login with.

> *Admin accounts have sudo privileges:* All Admin accounts on a Mac may
> use sudo to run command-line utilities with administrative (root)
> privileges.

You should also find an external hard drive. Begin using Time Machine as
soon as possible, as it provides the most easy method for backing up
your system.

# Configuring a User Account #

## Configuring The Trackpad ##

To make the trackpad behave correctly, ensure that these settings are
enabled:

* *System Preferences \> Trackpad \> Tap to click*
* *System Preferences \> Accessibility \> Mouse & Trackpad \> Trackpad
    Options… \> Enable dragging*

## Creating a Private Applications Folder ##

Once you have logged into your account, create a folder called
*Applications* within your home folder. Whenever you are prompted to
drag a new applications into the global Applications folder, put it in
this private Applications folder instead. Some applications have to be
installed to global folders, but in most cases you can keep the system
directories clean by storing third-party products in your private
Applications folder.

## Securing the Safari Browser ##

Whether or not you regularly use Safari, you should open it once, and adjust the
settings in case that you use it later.

First, choose *Safari \> Preferences \> General* and deselect the option *Open
“safe” files after downloading*.

Then, check the plug-in settings. Go to *Safari \> Preferences \> Security \>
Plug-in Settings...* and review the plug-ins and settings.

# Configuring Security #

Apple provide quite secure operating systems, but unfortunately
convenience has won out over security in a few places. These can easily
be corrected by changing a few settings. If you are using a laptop then
you should probably make all of these changes as soon as possible.

## Basic Settings ##

Select *System Preferences \> Security & Privacy*, and set the
following:

* Under *General*, set *require a password after sleep or screen saver begins* to *immediately*
* Click *Advanced...* and select *Require an administrator password to access system-wide preferences*
* Under *Firewall*, click *Turn Firewall On*.

## Enable File Vault NOW ##

Current versions of macOS include File Vault 2, a full-disk encryption system
that has little in common with the much more limited File Vault 1. You should
enable File Vault *NOW*, because it is the only protection against anyone with
physical access to your computer. All other security measures will be completely
bypassed if someone with physical access simply restarts the computer with a
bootable pen drive.

> File Vault really is secure, which means that you can permanently lose access to your data if you
lose the passwords and the recovery key.

## Requiring a Password on Bootup ##

Intel-based Macs include EFI firmware that runs when the machine is powered on,
to start the operating system. This takes the place of the standard PC BIOS, or
Open Firmware on older Macs. If your computer is frequently left in public
places, then set a boot password. Otherwise, any malicious individual can change
the firmware settings to boot from a disc or device of their choosing. If you
did not enable File Vault, then the attacker will have complete access to all of
the files on the system.

[Apple Knowledge Base article
HT1352](http://support.apple.com/kb/HT1352) provides full details.

## Setting Up Time Machine Backups ##

Time Machine is very, very simple to setup. Just take a suitably large
external hard drive, plug it in to your Mac, and agree when prompted.
The drive setup process will reformat the hard drive. The only settings
that may need to change are the exclusions.

Choose *System Preferences \> Time Machine*, and click *Options*. Add to
the exclusions list any folders that contain ISO disk images, virtual
machines, or database files (such as Entourage). If the external hard
drive is short of space, exclude the *System* folder.

# Setting Up for Development #

The first step is to install a compiler. The easiest way to install
one is with the *Xcode Command Line Tools* package.

Once you have the compiler that is provided by Xcode, you can use
[Homebrew](http://brew.sh/) to install everything else that you need. Homebrew
itself manages packages for command-line tools and services. The
[Cask](http://caskroom.io/)  extension to Homebrew enables you to install
graphical desktop applications.

## Getting Xcode ##

Apple now provide the Xcode suite as a free download from the App Store.
To install Xcode Command Line Tools, install Xcode from the App Store,
then open a Terminal window and enter the following command:

    xcode-select --install

## Setting Up Homebrew ##

[Homebrew](http://brew.sh/) provides a package
management system for macOS, enabling you to quickly install and update the
tools and libraries that you need. Follow the instructions on the site.

You should also amend your PATH, so that the versions of tools that are
installed with Homebrew take precedence over others. To do this, edit
the file *.bash\_login* in your home directory to include this line:

    export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

You need to close all terminal windows for this change to take effect.

To check that Homebrew is installed correctly, run this command in a
terminal window:

    brew doctor

To update the index of available packages, run this command in a
terminal window:

    brew update

## Installing the Git Version Control System ##

The Xcode Command Line Tools include a copy of [Git](http://www.git-scm.com/),
which is now the standard for Open Source development, but this will be out of
date.

To install a newer version of Git than Apple provide, use Homebrew.
Enter this command in a terminal window:

    brew install git

If you do not use Homebrew, go to the [Web
site](http://www.git-scm.com/) and follow the link for *Other Download
Options* to obtain a macOS disk image. Open your downloaded copy of
the disk image and run the enclosed installer in the usual way, then
dismount the disk image.

## Choosing a Text Editor ##

Current versions of macOS include command-line versions of both
[Emacs](http://www.gnu.org/software/emacs/) and [vim](http://www.vim.org/), as
well as TextEdit, a desktop text editor. TextEdit is designed for light-weight
word processing, and has no support for programming. Unless you already have a
preferred editor, I suggest that you install [Atom](http://www.atom.io),  which
is a powerful graphical text editor.

Whichever text editor you choose, remember to set the EDITOR environment
variable in your *~/.bash\_profile* file, so that this editor is
automatically invoked by command-line tools like your version control
system. For example, put this line in your profile to make *vim* the
favored text editor:

    export EDITOR="vim"

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
macOS includes the standard OpenSSH suite of tools.

To create an SSH key, run the *ssh-keygen* command in a terminal window. For
example:

    ssh-keygen -t rsa -b 4096 -C "Me MyName (MyDevice) <me@mydomain.com>"

> Use 4096-bit RSA keys for all systems. The older DSA standard only supports
1024-bit keys, which are now too small to be considered secure.

# Setting Up Environments #

## nvm for Node.js Development ##

To maintain multiple Node.js versions on your system, use the [nvm](https://github.com/creationix/nvm) utility.

Enter this command to install nvm:

     curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash

Open a new Terminal window and enter this command:

    nvm install 6.6.0

This installs Node.js 6.6.0 and makes it the default Node.js run-time.

## rustup for Rust Development ##

The official *rustup* utility enables you to install the tools for building
software with the Rust programming language. Click on the Install button on the
front page of the [Rust Website](https://www.rust-lang.org), and follow the
instructions.

By default, the installer adds the correct directory to your path. If this does
not work, add this to your PATH manually:

    $HOME/.cargo/bin

This process installs all of the tools into your home directory, and does not
add any files into system directories.

## RVM for Ruby Development ##

All macOS systems include a copy of Ruby, but it is outdated. To maintain
current and clean Ruby environments, use the [RVM](https://rvm.io/) system.

RVM relies on Git, so you must have a working installation of Git before
you can set up RVM.

By default, RVM downloads copies of Ruby that have been compiled for your
operating system. If there is no compiled version, RVM then falls back to
downloading the source code and then compiling it on your computer. Enter this
command to ensure that the requirements for compiling Ruby are on your system,
using Homebrew:

    brew install autoconf automake gmp libksba libtool libyaml openssl pkg-config readline

Finally, you can speed up installation of gem packages by disabling the
generation of local documentation. To do this, create a file in your
home directory with the name *.gemrc* and put this line in it:

    gem: --no-ri --no-rdoc

## pyenv for Python Development ##

Unfortunately, macOS include a copy of Python 2. To maintain current and clean
Python environments, use the [pyenv](https://github.com/yyuu/pyenv) system and
the [pyenv-virtualenv](https://github.com/yyuu/pyenv-virtualenv) plugin.

Enter this command to install pyenv using Homebrew:

    brew install pyenv pyenv-virtualenv

Next, add this line to the *.bashrc* file in your home directory:

     if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

Open a new Terminal window and enter these commands:

    pyenv install 3.5.1
    pyenv global 3.5.1

These install Python 3.5 and make it the default Python run-time.

## A Lightweight Setup for Python 2 Development ##

If you only need to work with Python 2, and prefer not to use *pyenv*, you can
just use the copy of Python that is part of macOS, and add some tools.

First, install *pip*:

    easy_install --user pip

Then add this to your $PATH:

    $HOME/Library/Python/2.7/bin

Use *pip* to install [virtualenv](https://virtualenv.pypa.io/en/stable/):

    pip install --user virtualenv

You can now use *virtualenv* to create Python 2 virtual environments and manage
the packages within them using *pip*, all inside your home directory, and
without modifying any system files.

# SQL Databases #

If you develop any kind of database-driven application, it is useful to have a
version of the database server available on your system. Consider using
containers for this. If you prefer to install services directly on to your
workstation, Homebrew provides packages for PostgreSQL, MariaDB and MySQL.

## Installing PostgreSQL ##

To install PostgreSQL using Homebrew, enter this command in a terminal window:

    brew install postgresql

This command installs the server, the command-line tools, and the client
libraries that are needed to compile adapters for programming languages. To
start the server, follow the instructions that are displayed after the
installation process is completed.

## Installing MariaDB or MySQL ##

To install MariaDB using Homebrew, enter this command in a terminal window:

    brew install mariadb

To install MySQL using Homebrew, enter this command in a terminal window:

    brew install mysql

These commands install the server, the command-line tools, and the client
libraries that are needed to compile adapters for programming languages. To
start the server, follow the instructions that are displayed after the
installation process is completed.

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

* Office suite: [LibreOffice](http://www.libreoffice.org/)
* Virtual machine management: [VirtualBox](http://www.virtualbox.org/)
* Docker container management: [Docker for Mac](http://www.docker.com/products/docker#/mac)
* MySQL database management: [MySQL Workbench](http://wb.mysql.com/)

The ready-to-use versions of VirtualBox are free for personal use, but not
actually Open Source. If you want to pay for a virtual machine application with
better performance, [VMWare
Fusion](https://www.vmware.com/products/fusion/) is probably the best product
available.

# Online Resources #

Apple offer overviews and task-orientated help on their [support Web
site](http://www.apple.com/support/mac101/).

Every new user should probably read [How to switch to the
Mac](http://the.taoofmac.com/space/HOWTO/Switch%20To%20The%20Mac), by
Rui Carmo.
