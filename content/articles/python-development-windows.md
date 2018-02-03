+++
Title = "Starting Python Development on Windows"
Slug = "python-development-windows"
Date = "2018-02-03T18:00:00+00:00"
Description = ""
Categories = ["programming"]
Tags = ["python", "windows"]
Type = "article"

+++

Notes on starting Python development on Windows.

<!--more-->

# Installing Python #

First, download the latest version of Python from [the official
Website](http://www.python.org/). Choose the *Windows x86-64 executable installer* for the latest version of Python 3, unless you know that you need a different option.

Run the installer, and select the option to *Add Python to PATH*, so that you do not need to type the full path for Python commands. If prompted, choose the option to remove the path length limitation from Windows.

The default Python package automatically provides you with:

* The *Python runtime*
* An *interactive shell* (use the menu icon, or type _python_ in a
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

## pipenv for Virtual Environments ##

Install [pipenv](https://docs.pipenv.org/) to manage your Python projects. It ensures that each of your Python projects use a separate set of packages, and provides other features to help you maintain your work, such as [checking the code](https://docs.pipenv.org/advanced/#code-style-checking) and [warning you about security issues in libraries](https://docs.pipenv.org/advanced/#detection-of-security-vulnerabilities).

In a command prompt window enter the following command:

    pip install pipenv

The Python project now officially recommends pipenv. It uses the *pip* and [virtual environment](https://docs.python.org/3/tutorial/venv.html) facilities that are included with Python itself, so it is fully compatible with other Python utilities, whilst being much easier to use than other tools.

The [Python Guide tutorial](http://docs.python-guide.org/en/latest/dev/virtualenvs/) shows you how to work with *pipenv*.

## A Version Control System ##

If you do not already use version control, you should also install [Git](http://git-scm.com/) on your
system. Git is now effectively the standard version control tool for developers.

Version control is obviously vital for collaborating with other programmers. It also enables you to efficiently copy your application to other systems for testing or deployment.

## Other Popular Tools ##

A number of other tools are commonly used in Python development, such as
[Pytest](http://pytest.org) for running unit test suites,
[Pylint](https://www.pylint.org) for code quality, [autopep8](https://pypi.python.org/pypi/autopep8/) for code formatting, and
[Sphinx](http://sphinx.pocoo.org) for building documentation. You should
probably install and learn these as you need them.

# Choosing a Code Editor or IDE #

 My preferred text editor on Windows is currently [Visual Studio Code](https://code.visualstudio.com). It is easy to use, and will automatically offer to download Python support the first time that you open a Python file. You may also consider [Atom](https://atom.io/), which is a high-quality editor that is designed to be customised, or [Notepad++](https://notepad-plus-plus.org/) for older computers with limited resources. All of these editors are free.

 If you would like to use a full IDE, consider the [Wing IDE](http://www.wingware.com/), which is proprietary, or using the free Eclipse IDE with the [PyDev](http://www.pydev.org/) extension. Current versions of Microsoft Visual Studio also include support for Python.

# Web Applications #

For very simple Websites and services, use [Flask](http://flask.pocoo.org/). The Flask framework provides the basic package of features that you need for a small Web application.

If you need a full Model-View-Controller framework, use either [Django](http://www.djangoproject.com/), or [Pyramid](https://trypyramid.com/). Django provides a set of custom tools and libraries that closely integrate together. Pyramid offers a modular framework for integrating third-party Python libraries together when developing custom Web applications.

Python Web frameworks follow the WSGI standard, which provides consistent
interfaces between individual components, and between the components and
the host Web server. Any server that supports WSGI can host your Python applications. Cloud services such as [Heroku](https://www.heroku.com/) and [Google App Engine](https://cloud.google.com/appengine/) also provide hosting for Python Web applications.

[Full Stack Python](https://www.fullstackpython.com) provides a comprehensive guide to building Web applications with Python.

# Web Clients #

Use the [requests](http://docs.python-requests.org/en/master/) library for your  Web client software, such as downloading files or working with APIs. The HTTP support in the Python standard library is for low-level code.

If you need to get information from Websites that do not provide an API, use [Scrapy](https://doc.scrapy.org). You can then extract content from the pages with the [Beautiful Soup](https://www.crummy.com/software/BeautifulSoup/) library.

# Accessing Databases #

The simplest answer: you do not need to install anything or setup a
service to create a SQL database for a new Python application, because
the Python standard library includes a version of
[SQLite](http://www.sqlite.org/).

To access a SQL database service such
as PostgreSQL, MySQL, or Oracle you will need to install the standard client software
for that product, along with a separate Python adapter.

> *Connecting to Microsoft SQL Server*: [Microsoft recommend that you use the ODBC adapter for SQL Server](https://docs.microsoft.com/en-us/sql/connect/python/python-driver-for-sql-server).

The Django Web framework includes an Object-Relational Mapper (ORM). For other 
applications use either [Records](https://pypi.python.org/pypi/records/), or [SQLAlchemy](http://www.sqlalchemy.org/). Records provides a simple interface for SQL queries. SQLAlchemy has become the standard Python library for database programming, and is probably one of the best database toolkit libraries available for any programming language. You may use the declarative portion of SQLAlchemy like a standard ORM, but it has many more capabilities.

# Graphical Desktop Applications #

If you are specifically interested in developing desktop applications, start with [wxPython](http://wxpython.org/). The Tk interface toolkit that is supplied with the Python standard library is rather basic and dated. If you have advanced needs, you may prefer [PySide](https://wiki.qt.io/PySide), which enables you to make use of the [QT](https://www.qt.io/) libraries.

# Windows Integration #

Python includes support for some features that are unique to Microsoft Windows, but not all of them. To use Python with other features of Windows, such as COM and the Registry, install the [win32
Extensions](https://github.com/mhammond/pywin32).

# Creating Application Installers #

To build fully self-contained executable installers for Windows, use [PyInstaller](http://www.pyinstaller.org/) or [py2exe](http://www.py2exe.org/). These package a Python interpreter with your application, avoiding the need to have a separate copy of Python installed on the target system.

# Learning Resources #

Start with [The Hitchhiker’s Guide to Python](http://docs.python-guide.org), which provides clear advice on how to work with Python.

The tutorial that is supplied with Python is pretty good, and enough for a committed student or someone with previous programming experience to learn the essentials of the language. It also has the virtue of always being up to date, whilst third-party documentation becomes obsolete over time. The Internet provides many other resources, though.

Google provide a [free course for learning Python](https://developers.google.com/edu/python/), consisting of video lectures and exercises. There are also two excellent books for learning Python 3 that you can read for free online. [Dive Into Python
3](http://www.diveintopython3.net/) is particularly good for those people with some previous experience of
programming, especially if they are impatient! If you are not a programmer, try [Automate the Boring Stuff with Python](http://automatetheboringstuff.com/), which includes a gentle introduction to programming.

Once you have learned Python itself, go to [Full Stack Python](https://www.fullstackpython.com) for a comprehensive guide to building Web applications with Python.
