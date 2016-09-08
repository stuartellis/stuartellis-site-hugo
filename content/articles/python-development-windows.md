+++
Title = "Starting Python Development on Windows"
Slug = "python-development-windows"
Date = "2016-07-01T01:00:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["python", "windows"]
Type = "article"

+++


These are some notes on starting Python development on Windows.

<!--more-->

# Installing Python #

First, download the latest version of Python from [the official
Website](http://www.python.org/).

The Windows version is provided as an MSI package. To install it
manually, just double-click the file. The MSI package format allows
Windows administrators to automate installation with their standard
tools.

By design, Python installs to a directory with the version number
embedded, e.g. C:\\Python34\\, so that you can have multiple versions of
Python on the same system without conflicts. Of course, only one
interpreter can be the default application for Python file types. It
also does not automatically modify the PATH environment variable, so
that you always have control over which copy of Python is run.

Typing the full path name for a Python interpreter each time quickly
gets tedious, so add the directories for your default Python version to
the PATH. Assuming that your Python installation is in C:\\Python34\\,
add this to your PATH:

    C:\Python34\;C:\Python34\Scripts\

You do not need to install or configure anything else to use Python.

Briefly, the default Python package automatically provides you with:

* The *Python runtime*
* An *interactive shell* (use the menu icon, or type **python** in a
    command prompt window)
* A basic IDE, called *IDLE*
* A large *standard library*, along with documentation
* An extensive *tutorial*, to help you get started

IDLE is intended as a basic and portable development environment that
lets new programmers start without having to learn their way around a
large IDE. It’s code completion is not perfect, and it’s integration
with the built-in Python debugger currently doesn’t work at all on
Windows. If you already use IDEs, it’s probably best to ignore IDLE, and
either buy a license for the [Wingware IDE](http://www.wingware.com/),
or follow the instructions below to install the free Eclipse IDE. My
preferred text editor on Windows is
[Atom](http://www.atom.io), but there are plenty
of others that support Python.

Whichever text editor or IDE you use, the supplied tutorial will walk
you through the basics of Python. The documentation for the standard
library does give simple examples for many features, but it is
specifically designed as a reference, rather than for learning. To
understand particular features you should start with the supplied
tutorial, or one of the books mentioned below.

# Essential Tools #

There are a number of de-facto standard utilities and libraries for
Python software development, but a few tools are so fundamental that you
should install them even before you begin to write Python code.

> *C Extensions Require a Compiler:* Setup a C compiler, such as MinGW,
> if you need to install Python applications with C extensions.

## Virtualenv ##

The venv system and the virtualenv kit provide the ability to create
virtual Python environments that do not interfere with either each
other, or the main Python installation. If you use virtual environments
from the start you can get into the habit of creating completely clean
Python environments for each project. This is particularly important for
Web development, where every application will have many dependencies.

To set up a new Python environment with virtualenv, change the working
directory to where ever you want to store the environment, and run the
virtualenv utility:

    virtualenv --no-site-packages MyNewEnv

To use a virtualenv environment, run the activate.bat batch file in the
Scripts subdirectory of that environment. Your command prompt will
change to show the active environment. Once you have finished working in
the current virtual environment, run the deactivate.bat batch file to
restore your settings to normal.

Each new environment automatically includes a copy of pip in
the Scripts subdirectory, so that you can setup the third-party
libraries and tools that you want to use in that environment. Put your
own code within a subdirectory of the environment, however you wish.
When you no longer need a particular environment, simply copy your code
out of it, and then delete the main directory for the environment.

> *Virtualenv Relies on PATH*: The activation batch file adds extra
> elements to the Windows PATH variable, which can expand the total
> length of your PATH beyond the permitted size. If your PATH becomes
> too long then file references will not be resolved correctly, and
> applications within your virtual Python environment will fail.

## A Version Control System ##

If you do not already use version control, you should also install either
[Mercurial](http://mercurial.selenic.com/) or [Git](http://git-scm.com/) on your
system. Git is now effectively the standard version control tool for developers,
but the Python project itself uses Mercurial.

Version control is obviously useful for collaboration and protecting
your code against loss. In addition, it is key to efficient testing and
deployment, particularly for server applications. Once code is version
controlled you can synchronize copies across multiple virtualenv
environments and computers, deploying or rolling back versions as you
require.

## Other Popular Tools ##

A number of other tools are commonly used in Python development, such as
[Pytest](http://pytest.org) for running unit test suites,
[Flake8](http://flake8.readthedocs.org/en/latest/) for code quality, and
[Sphinx](http://sphinx.pocoo.org/) for building documentation. You should
probably install and learn these as you need them.

# Setting up an IDE: Eclipse and PyDev #

Eclipse provides a mature and free general-purpose IDE that supports
multiple tasks and languages through plugins. The PyDev plugin enables
Eclipse to support Python. PyDev itself is also free, but the separate
PyDev Extensions plugin is a commercial product. PyDev Extensions
provides remote debugging and other advanced capabilities, so it is
useful, but not essential.

To run Eclipse you must have a Java runtime (JRE) on your system. If you
don’t already have a JRE installed, just go to the [Java
Website](http://www.java.com/), and follow the prompts.

Next, download a copy of Eclipse from [the Eclipse
Website](http://www.eclipse.org/). Each of the versions are bundled with
particular sets of Java development plugins, but are otherwise the same.
There is no installer for Eclipse, you just unzip the provided archive
file to a convenient location, such as C:\\Program Files\\Eclipse\\.

To add PyDev, use the plugin management built-in to Eclipse:

1. Choose *Help* \> *Software Updates*.
2. Select the *Available Software* tab.
3. Choose *Add Site…*
4. Enter http://pydev.org/updates in the *Location* field of the dialog
box, and choose *OK*.
5. Select *PyDev for Eclipse*, which is listed in the new site entry,
under *PyDev*.
6. Choose *Install…*
7. Follow the prompts, and agree to the license.

Once you have installed PyDev, specify the Python interpreter:

1. Choose *Window* \> *Preferences* \> *Pydev* \> *Interpreter -
Python*\
2. Select *New…*
3. Browse to the directory that holds your Python interpreter, e.g.
C:\\Python34\\, and select the **python.exe** file.
4. When the *Selection Needed* window appears, choose *OK*.

To run the Python interactive shell within Eclipse, define it as an
*External Tool*:

1. Select *Run* \> *External Tools* \> *External Tools…*
2. Choose *Program* \> *New Launch Configuration…*
3. Specify the Python interpreter in the *Location* field, and enter
**${container_loc}** in the *Working Directory* field. Add **-i** as
an *Argument*.

For a more detailed guide to configuring PyDev, with screenshots, use
[this
page](http://www.rose-hulman.edu/Class/csse/resources/Eclipse/eclipse-python-configuration.htm).

Watch [this
video](http://showmedo.com/videos/video?name=PydevEclipseFabio) to get a
very quick introduction to using PyDev.

The standard Eclipse builds include support for the CVS version control
system. Third-party plugins exist to integrate both Git and
Mercurial:

* [Eclipse Git plugin](http://www.eclipse.org/egit/)
* [Eclipse Mercurial plugin](http://javaforge.com/project/HGE)

# Accessing Databases #

The simplest answer: you do not need to install anything or setup a
service to create a SQL database for a new Python application, because
the Python standard library includes a version of
[SQLite](http://www.sqlite.org/). To access a SQL database service such
as MySQL or Oracle you will need to install the standard client software
for that product, along with a separate Python adapter. Both the SQLite
library and third-party database adapters follow the Python DB-API
specification, which means that you can program with them all in the
same way.

> *Connecting to Microsoft SQL Server*: Use the generic ODBC adapter to
> connect to Microsoft SQL Server databases.

In practice, most Python applications interact with databases through higher
level libraries, rather than using the DB-API adapters directly. The Django
framework includes an Object-Relational Mapper (ORM), but for other types of
application you should use [SQLAlchemy](http://www.sqlalchemy.org/), which
become the standard Python library for database access, and is probably one of
the best database toolkit libraries available for any programming language. You
may use the declarative portion of SQLAlchemy like a standard ORM, but it has
many more capabilities.

Django and SQLAlchemy ultimately rely on the standard client and DB-API adapter
for your database. When you use a database other than SQLite, ensure that these
are present and current, as low-level configuration errors are harder to
diagnose when you are not working directly with the DB-API adapters.

# Web Applications #

Today, most Python Web applications are built on a framework. Python Web
frameworks follow the WSGI standard, which provides consistent
interfaces between individual components, and between the components and
the host Web server. Any Web server that supports WSGI can host
compliant applications.

For small applications, use [Flask](http://flask.pocoo.org/). If you need a full
Model-View-Controller framework, try one of the following:

* [Django](http://www.djangoproject.com/)
* [Pyramid](http://www.pylonshq.com/)

Django is intended for building and managing groups of content-driven sites,
rather than for producing individual Web applications. It incorporates custom
libraries developed specifically for Django that closely integrate together,
rather than using other popular Python libraries, such as SQLAlchemy. Pyramid
offers a modular framework for integrating third-party Python libraries together
when developing custom Web applications.

If you work with more than one framework, I strongly recommend that you
install each framework into a separate virtualenv environment, to avoid
conflicts.

# Windows Integration #

Python is specifically designed to be portable and consistent across
operating systems, including obscure platforms. This means that the
Python standard library provides support for cross-platform operations,
but does not include a full set of specialised features for popular
operating systems. To get support for features that are specific to
Microsoft Windows, such as COM and the Registry, install the [win32
Extensions](https://sourceforge.net/projects/pywin32/).

Similarly, the distutils package in the standard library provides a
general-purpose system for building distributable Python packages. To
build fully self-contained executable installers for Windows, use
[py2exe](http://www.py2exe.org/). This method includes a Python
interpreter within your application, removing the need to have a
separate copy of Python installed on the target system.

If you are specifically interested in developing desktop applications,
consider using [wxPython](http://wxpython.org/), rather than the basic
Tk interface toolkit supplied with the standard library. Alternatively,
use the [GTK+](http://www.gtk.org/) toolkit, or
[Qt](http://trolltech.com/products).

# Learning Resources #

The supplied tutorial is pretty good, and enough for a committed student
or someone with previous programming experience to learn the essentials.
It also has the virtue of always being up to date, whilst third-party
documentation becomes obsolete over time.

If you are using Python 3, try [Dive Into Python
3](http://www.diveintopython3.net/) by Mark Pilgrim. The style of this book makes
it particularly good for those people with some previous experience of
programming, especially if they are impatient!

I know of two excellent books for Python 2 that are intended for learners: [Core
Python Programming](http://www.corepython.com/), second edition, by Wesley J.
Chun (Prentice Hall), and [Beginning Python: From Novice to
Professional](http://www.apress.com/book/view/9781590599822), second edition, by
Magnus Lie Hetland (Apress). Core Python Programming is probably the definitive
work on Python 2, and effectively explains even the most advanced features and
concepts. If you have not programmed before, or are intimidated by thick books,
you should probably start with Beginning Python.
