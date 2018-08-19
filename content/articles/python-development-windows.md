+++
Title = "Starting Python Development on Windows"
Slug = "python-development-windows"
Date = "2018-08-19T18:13:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["python", "windows"]
Type = "article"

+++

Notes on starting Python development, with specific details on using Microsoft Windows.

<!--more-->

# Installing Python on Windows

First, download the latest version of Python from [the official
Website](http://www.python.org/). Choose the _Windows x86-64 executable installer_ for the latest version of Python 3, unless you know that you need a different option.

Run the installer, and select the option to _Add Python to PATH_, so that you do not need to type the full path for Python commands. If prompted, choose the option to remove the path length limitation from Windows.

A standard Python installation provides you with:

- The _Python runtime_
- An _interactive shell_ (use the menu icon, or type _python_ in a
  command prompt window)
- A basic IDE, called _IDLE_
- A large _standard library_, along with documentation
- An extensive _tutorial_, to help you get started

IDLE is intended as a basic and portable development environment that
lets new programmers start without having to install a separate editor for their code. For a much better experience, install a text editor or IDE that supports Python.

The tutorial that is supplied with Python can walk you through the basics. The documentation for the standard library does provide simple examples for many features, but it is specifically designed as a reference, rather than for learning. The last section of this article gives you links to courses and books that you may find more helpful when starting with Python.

# Choosing a Code Editor or IDE

If you do not already have a preferred editor, consider [Visual Studio Code](https://code.visualstudio.com). [This tutorial](https://code.visualstudio.com/docs/python/python-tutorial) shows you the features that Visual Studio Code has for Python development, including code quality checks, and support for debugging. If you are new to programming, start with [Mu](https://codewith.mu/), which is specifically designed for to help new developers work with Python. Both of these editors are free.

If you would like to use a full IDE, there are several options available. [Wing IDE](http://www.wingware.com/) and [PyCharm](https://www.jetbrains.com/pycharm/) are proprietary, commercial products. The free Eclipse IDE can be be used for Python development with the [PyDev](http://www.pydev.org/) extension. Current versions of Microsoft Visual Studio also include support for Python.

# Essential Tools

There are a number of de-facto standard utilities and libraries for
Python software development, but a few tools are so fundamental that you
should install them even before you begin to write Python code.

## Git for Version Control

If you do not already use version control, you should also install [Git](http://git-scm.com/) on your
system. Git is now effectively the standard version control tool for developers.

Version control is obviously vital for collaborating with other programmers. It also enables you to efficiently copy your application to other systems for testing, deployment and backup.

If Git is installed, Atom and Visual Studio Code provide you with access to information and features from Git directly in their user interfaces. If you use Visual Studio Code, you should also consider installing the [Git Lens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens) extension, which enhances the integration with Git.

## pipenv for Virtual Environments

Install [pipenv](https://docs.pipenv.org/) to manage your Python projects. It ensures that each of your Python projects use a separate set of packages, and provides other features to help you maintain your work, such as [checking the code](https://docs.pipenv.org/advanced/#code-style-checking) and [warning you about security issues in libraries](https://docs.pipenv.org/advanced/#detection-of-security-vulnerabilities).

In a command prompt window enter the following command:

    pip install pipenv

The pipenv tool uses the _pip_ and [virtual environment](https://docs.python.org/3/tutorial/venv.html) facilities that are included with Python itself, so it is fully compatible with other Python utilities, whilst being much easier to use than other tools. The Python packaging documentation now officially recommends pipenv.

The [Python Guide tutorial](http://docs.python-guide.org/en/latest/dev/virtualenvs/) shows you how to work with _pipenv_.

# Other Tools

These tools are also commonly used in Python development. You should probably learn these as you need them.

## Tools for Python Projects

- [Cookiecutter](https://cookiecutter.readthedocs.io/) to create new projects from templates
- [autopep8](https://pypi.python.org/pypi/autopep8/) for code formatting
- [Pylint](https://www.pylint.org) for code quality
- [Sphinx](http://sphinx.pocoo.org) for building documentation

If you install the Python extension, Visual Studio Code will offer to use Pylint and autopep8 to check and format your code.

## Tools for Testing Python Code 

- [Pytest](http://pytest.org) for testing
- [Tox](https://tox.readthedocs.io/) runs sets of tests in multiple Python environments
- [Coverage](https://pypi.python.org/pypi/coverage/) for measuring the test coverage of code
- [Bandit](https://pypi.python.org/pypi/bandit) to check your code for common security issues
- [Safety](https://pyup.io/safety/) to check your project dependencies for known security vulnerabilities 

# Developing Command-line Applications

Use the [Click](http://click.pocoo.org) framework to build command-line tools with Python.

[Python Fire](https://github.com/google/python-fire) enables you to add a command-line interface to existing code.

# Building Web Applications

For very simple Websites and services, use [Flask](http://flask.pocoo.org/). The Flask framework provides the basic package of features that you need for a small Web application.

Use either [Django](http://www.djangoproject.com/) or [Pyramid](https://trypyramid.com/) for larger projects. Django provides a set of custom tools and libraries that closely integrate together. Pyramid offers a modular framework for integrating third-party Python libraries together when developing custom Web applications.

Python Web frameworks follow the WSGI standard, which provides consistent
interfaces between individual components, and between the components and the
host Web server. Any server that supports WSGI can host your Python
applications. Cloud services such as [Google App
Engine](https://cloud.google.com/appengine/), [Heroku](https://www.heroku.com/),
[Python Anywhere](https://www.pythonanywhere.com/) and [Red Hat
OpenShift](https://www.openshift.com/) provide low-maintenance hosting for
Python Web applications.

[Full Stack Python](https://www.fullstackpython.com) provides a comprehensive guide to building Web applications with Python.

# Developing Web Clients

Use the [requests](http://docs.python-requests.org/en/master/) library for your Web client software, such as downloading files or working with APIs. The HTTP support in the Python standard library is for low-level code.

If you need to get information from Websites that do not provide an API, use [Scrapy](https://doc.scrapy.org). You can then extract content from the pages with the [Beautiful Soup](https://www.crummy.com/software/BeautifulSoup/) library.

# Accessing Databases

The simplest answer: you do not need to install anything or setup a
service to create a SQL database for a new Python application, because
the Python standard library includes a version of
[SQLite](http://www.sqlite.org/).

To access a SQL database service such as PostgreSQL, MySQL, or Oracle you will need to install the client software for that product, along with a separate Python adapter.

> _Connecting to Microsoft SQL Server_: [Microsoft recommend that you use the ODBC adapter for SQL Server](https://docs.microsoft.com/en-us/sql/connect/python/python-driver-for-sql-server).

The Django Web framework includes an Object-Relational Mapper (ORM). For other applications, use [SQLAlchemy](http://www.sqlalchemy.org/), which has become the standard Python library for database programming. You may use the declarative portion of SQLAlchemy like a standard ORM, but it has many more capabilities. [Records](https://pypi.python.org/pypi/records/) provides a simple programming interface and command-line tool for SQLAlchemy.

# Graphical Desktop Applications

If you are specifically interested in developing desktop applications, start with [wxPython](http://wxpython.org/). The Tk interface toolkit that is supplied with the Python standard library is rather basic and dated. If you have advanced needs, you may prefer [PySide2](https://wiki.qt.io/PySide2), which enables you to make use of the [QT](https://www.qt.io/) libraries.

# Microsoft Windows Integration

Python includes support for some features that are unique to Microsoft Windows, but not all of them. To use Python with other features of Windows, such as COM and the Registry, install the [win32 Extensions](https://github.com/mhammond/pywin32).

# Packaging Applications

To build packaged applications for Windows, use [PyInstaller](http://www.pyinstaller.org/) or [py2exe](http://www.py2exe.org/). These create stand-alone executables that include Python itself, your code, and any other dependencies.

# Learning Resources

There are several excellent books for learning Python 3 that you can read for free online. [Dive Into Python 3](http://www.diveintopython3.net/) is particularly good for those people with some previous experience of
programming, especially if they are impatient! If you are not a programmer, try [Automate the Boring Stuff with Python](http://automatetheboringstuff.com/), which includes a gentle introduction to programming.

Once you have learned Python itself, visit [The Hitchhiker’s Guide to Python](http://docs.python-guide.org), which provides clear advice on daily work with Python, and [Full Stack Python](https://www.fullstackpython.com) for a comprehensive guide to building Web applications with Python.
