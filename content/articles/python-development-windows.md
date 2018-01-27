+++
Title = "Starting Python Development on Windows"
Slug = "python-development-windows"
Date = "2018-01-27T13:30:00+00:00"
Description = ""
Categories = ["programming"]
Tags = ["python", "windows"]
Type = "article"

+++

These are some notes on starting Python development on Windows.

<!--more-->

# Installing Python #

First, download the latest version of Python from [the official
Website](http://www.python.org/). Select the option to *Add Python to PATH*, so that you do not need to type the full path for Python commands.

The default Python package automatically provides you with:

* The *Python runtime*
* An *interactive shell* (use the menu icon, or type **python** in a
    command prompt window)
* A basic IDE, called *IDLE*
* A large *standard library*, along with documentation
* An extensive *tutorial*, to help you get started

IDLE is intended as a basic and portable development environment that
lets new programmers start without having to install a separate editor for their code. For a much better experience, install a text editor or IDE that supports Python.

Whichever text editor or IDE you use, the tutorial that is supplied with Python  will walk you through the basics. The documentation for the standard
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

## pipenv for Virtual Environments ##

Install [pipenv](https://docs.pipenv.org/), so that each of your Python projects can have a separate environment and set of Python packages.

In a PowerShell windows enter the following command:

    pip install pipenv

The Python project now officially recommends pipenv. It uses the *pip* and virtual environment facilities that are included with Python itself, so it is fully compatible with other Python utilities.

The [Python Guide tutorial](http://docs.python-guide.org/en/latest/dev/virtualenvs/) shows you how to work with *pipenv*.

## A Version Control System ##

If you do not already use version control, you should also install [Git](http://git-scm.com/) on your
system. Git is now effectively the standard version control tool for developers.

Version control is obviously useful for collaboration and protecting
your code against loss. In addition, it is key to efficient testing and
deployment, particularly for server applications. Once code is version
controlled you can synchronize copies across multiple virtualenv
environments and computers, deploying or rolling back versions as you
require A Code Editor or IDE.

## Other Popular Tools ##

A number of other tools are commonly used in Python development, such as
[Pytest](http://pytest.org) for running unit test suites,
[Flake8](http://flake8.readthedocs.org/en/latest/) for code quality, and
[Sphinx](http://sphinx.pocoo.org/) for building documentation. You should
probably install and learn these as you need them.

# Choosing a Code Editor or IDE #

 My preferred text editor on Windows is [Visual Studio Code](https://code.visualstudio.com), but there are plenty of others. If you want a full IDE, consider the [Wingware IDE](http://www.wingware.com/),
or using the free Eclipse IDE with the [PyDev](http://www.pydev.org/) extension.

# Accessing Databases #

The simplest answer: you do not need to install anything or setup a
service to create a SQL database for a new Python application, because
the Python standard library includes a version of
[SQLite](http://www.sqlite.org/). To access a SQL database service such
as PostgreSQL, MySQL, or Oracle you will need to install the standard client software
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

Both SQLAlchemy and the ORM for Django ultimately rely on the standard client and DB-API adapter
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

Start with [The Hitchhiker’s Guide to Python](http://docs.python-guide.org), which provides clear advice on how to work with Python.

The tutorial that is supplied with Python is pretty good, and enough for a committed student or someone with previous programming experience to learn the essentials of the language. It also has the virtue of always being up to date, whilst third-party documentation becomes obsolete over time.

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
