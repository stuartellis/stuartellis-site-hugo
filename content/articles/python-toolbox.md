+++
Title = "Useful Python Tools and Libraries"
Slug = "python-toolbox"
Date = "2018-12-20T13:43:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["python"]
Type = "article"

+++

Notes on useful tools and libraries for Python.

<!--more-->

# Use pipenv for Virtual Environments

Install [pipenv](https://docs.pipenv.org/) to manage your Python projects. It ensures that each of your Python projects use a separate set of packages, and provides other features to help you maintain your work, such as [checking the code](https://docs.pipenv.org/advanced/#code-style-checking) and [warning you about security issues in libraries](https://docs.pipenv.org/advanced/#detection-of-security-vulnerabilities).

In a command prompt window enter the following command:

    pip install pipenv

The pipenv tool uses the _pip_ and [virtual environment](https://docs.python.org/3/tutorial/venv.html) facilities that are included with Python itself, so it is fully compatible with other Python utilities, whilst being much easier to use than other tools. The Python packaging documentation now officially recommends pipenv.

The [Python Guide tutorial](http://docs.python-guide.org/en/latest/dev/virtualenvs/) shows you how to work with _pipenv_.

# Tools for Python Projects

- [Cookiecutter](https://cookiecutter.readthedocs.io/) to create new projects from templates
- [autopep8](https://pypi.python.org/pypi/autopep8/) for code formatting
- [Pylint](https://www.pylint.org) for code quality
- [Sphinx](http://sphinx.pocoo.org) for building documentation

If you install the Python extension, Visual Studio Code will offer to use Pylint and autopep8 to check and format your code.

# Tools for Testing Python Code

- [Pytest](http://pytest.org) for testing
- [Tox](https://tox.readthedocs.io/) runs sets of tests in multiple Python environments
- [Coverage](https://pypi.python.org/pypi/coverage/) for measuring the test coverage of code
- [Faker](http://faker.rtfd.org/) - Generates fake data
- [mypy](http://www.mypy-lang.org/) - Static type checking, using Python type annotations
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

# Building Graphical Desktop Applications

If you are specifically interested in developing desktop applications, start with [wxPython](http://wxpython.org/). The Tk interface toolkit that is supplied with the Python standard library is rather basic and dated. If you have advanced needs, you may prefer [QT for Python](https://www.qt.io/qt-for-python), which enables you to make use of the [QT](https://www.qt.io/) libraries.

# Microsoft Windows Integration

Python includes support for some features that are unique to Microsoft Windows, but not all of them. To use Python with other features of Windows, such as COM and the Registry, install the [win32 Extensions](https://github.com/mhammond/pywin32).

# Packaging Applications

To build packaged applications, use [PyInstaller](http://www.pyinstaller.org/). This creates stand-alone executables that include Python itself, your code, and any other dependencies.

To package a Python application for systems that already have Python installed, consider using [pex](https://github.com/pantsbuild/pex/).

# Other Useful Libraries

- [Bokeh](https://bokeh.pydata.org) - Interactive charts and other visualizations
- [Pendulum](https://pendulum.eustace.io/) - Date and time parsing
- [Pillow](https://python-pillow.org/) - Image processing
- [PyYAML](https://pyyaml.org/) - YAML support for Python
- [Reportlab](https://www.reportlab.com/opensource/) - PDF generation
- [uvloop](https://uvloop.readthedocs.io/) - Extremely fast replacement for the standard Python asyncio event loop
