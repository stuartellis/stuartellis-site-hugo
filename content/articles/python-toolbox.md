+++
Title = "Useful Python Tools and Libraries"
Slug = "python-toolbox"
Date = "2019-05-06T13:41:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["python"]
Type = "article"

+++

Notes on useful tools and libraries for the [Python](https://www.python.org/) programming language.

<!--more-->

# Online Development Environments

These services enable you to work on Python projects in a cloud-based environment:

- [Python Anywhere](https://www.pythonanywhere.com/)
- [repl.it](https://repl.it/)

To quickly share pieces of code, use [Pastebin](https://pastebin.com/).

# Working on Python Projects

## Use pipenv for Virtual Environments

Install [pipenv](https://docs.pipenv.org/) to manage your Python projects. It ensures that each of your Python projects use a separate set of packages, and provides other features to help you maintain your work, such as [checking the code](https://docs.pipenv.org/advanced/#code-style-checking) and [warning you about security issues in libraries](https://docs.pipenv.org/advanced/#detection-of-security-vulnerabilities).

In a command prompt window enter the following command:

    pip install pipenv

The pipenv tool uses the _pip_ and [virtual environment](https://docs.python.org/3/tutorial/venv.html) facilities that are included with Python itself, so it is compatible with other Python utilities.

The [Python Guide tutorial](http://docs.python-guide.org/en/latest/dev/virtualenvs/) shows you how to work with _pipenv_.

## Working with Multiple Versions of Python

If you need to develop with several different versions of Python, use [pyenv](https://github.com/pyenv/pyenv). This tool enables you to install multiple versions of Python on the same system, and switch between them.

## Managing Projects

- [Cookiecutter](https://cookiecutter.readthedocs.io/) to create new projects from templates
- [Sphinx](http://sphinx.pocoo.org) for building documentation

## Code Quality

- [autopep8](https://pypi.python.org/pypi/autopep8/) for code formatting
- [Pylint](https://www.pylint.org) for code quality

If you install the Python extension for Visual Studio Code, it will offer to use Pylint and autopep8 to check and format your code.

## Tools for Testing Python Code

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

For simple Websites and services, use the [Flask](http://flask.pocoo.org/) framework. Flask itself provides the basic package of features that you need for a Web application, and the framework has [a wide range of extensions](http://flask.pocoo.org/extensions/) to add more capabilities.

Use either [Django](http://www.djangoproject.com/) or [Pyramid](https://trypyramid.com/) for larger projects. Django provides a set of custom tools and libraries that closely integrate together. Pyramid offers a modular framework for integrating third-party Python libraries together into custom Web applications.

These Web frameworks follow the WSGI standard. Any server that supports WSGI can run Python Web applications, which means that there are many options for hosting your projects. You can either set up your own systems with the software of your choice, or use cloud services for application hosting.

[Google App Engine](https://cloud.google.com/appengine/), [Heroku](https://www.heroku.com/) and [Python Anywhere](https://www.pythonanywhere.com/) enable you to run Python Web applications without managing systems. If you need more control over the infrastructure that your application uses, consider using containers and a Kubernetes service, such as [Red Hat OpenShift](https://www.openshift.com/), [DigitalOcean Kubernetes](https://www.digitalocean.com/products/kubernetes/) or [Google Kubernetes Engine](https://cloud.google.com/kubernetes-engine/).

[Full Stack Python](https://www.fullstackpython.com) provides a comprehensive guide to building Web applications with Python.

> Whichever Web framework you use, add the [secure.py](https://secure.readthedocs.io/en/latest/) extension to implement Web security features.

# Developing Web Clients

Use the [requests](http://docs.python-requests.org/en/master/) library for your Web client software, such as downloading files or working with APIs. The HTTP support in the Python standard library is for low-level code.

If you need to get information from Websites that do not provide an API, use [Scrapy](https://doc.scrapy.org). You can then extract content from the pages with the [Beautiful Soup](https://www.crummy.com/software/BeautifulSoup/) library.

# Working with SQL Databases

The Python standard library includes a version of [SQLite](http://www.sqlite.org/). This means that you can use SQL databases in any Python project without installing a separate database product. Avoid underestimating SQLite: it is a robust and efficient database that will handle gigabytes of data.

To access other types of SQL databases such as PostgreSQL, MySQL, or Oracle, install the Python driver that the vendor of the database recommends. Each Python driver will require a particular client library. For example, the recommended Python driver for PostgreSQL is [psycopg](http://initd.org/psycopg/), which requires a copy of the libpq library.

> _Connecting to Microsoft SQL Server_: [Microsoft recommend that you use the ODBC adapter for SQL Server](https://docs.microsoft.com/en-us/sql/connect/python/python-driver-for-sql-server).

Whichever brand of SQL database you work with, use a database toolkit, rather than writing data access and schema management code yourself.

[SQLAlchemy](http://www.sqlalchemy.org/) is the standard Python library for database programming. You may use the declarative portion of SQLAlchemy like a standard ORM, but it has many more capabilities. [Records](https://pypi.python.org/pypi/records/) provides a simple programming interface and command-line tool for SQLAlchemy.

If your project has limited or specific needs, consider alternatives to SQLAlchemy. [Peewee](http://docs.peewee-orm.com/) offers a lightweight alternative to SQLAlchemy for accessing the most popular brands of Open Source database. For Django projects, use the Object-Relational Mapper (ORM) that is provided with Django, because this is integrated with the other features of the framework.

# Building Graphical Desktop Applications

Consider using [wxPython](http://wxpython.org/) to build graphical interfaces for your applications. The Tk interface toolkit that is supplied with the Python standard library is rather basic and dated. If you have advanced needs, you may prefer [QT for Python](https://www.qt.io/qt-for-python), which enables you to make use of the [QT](https://www.qt.io/) libraries.

If you are building 2D games, try [pygame](https://www.pygame.org). This provides a simple toolkit for games and multimedia applications.

# Microsoft Windows Integration

Python includes support for some features that are unique to Microsoft Windows, but not all of them. To use Python with other features of Windows, such as COM and the Registry, install the [win32 Extensions](https://github.com/mhammond/pywin32).

# Packaging Applications

Use [PyInstaller](http://www.pyinstaller.org/) to create applications that you can give to other people. PyInstaller creates stand-alone executables that include Python itself, your code, and any other dependencies. Follow the steps described in the [RealPython.com tutorial](https://realpython.com/pyinstaller-python/) to add PyInstaller to your project.

If you only need to deploy your application to systems that you know will have a suitable version of Python, use [shiv](https://github.com/linkedin/shiv). The shiv utility packages your application and dependencies into a ZIP file that Python interpreters will run.

# Other Useful Libraries

- [Gunicorn](https://gunicorn.org/) - Fast Web server for Python WSGI applications
- [Jinja2](http://jinja.pocoo.org/) - Text templating, for generating HTML and other formats
- [Matplotlib](https://matplotlib.org/) - Plotting 2D graphs and charts
- [Pendulum](https://pendulum.eustace.io/) - Date and time parsing
- [Pillow](https://python-pillow.org/) - Image processing
- [python-dotenv](https://github.com/theskumar/python-dotenv) - Load environment variables from files
- [PyYAML](https://pyyaml.org/) - YAML support for Python
- [Reportlab](https://www.reportlab.com/opensource/) - PDF generation

# Learning Resources

[This article](https://www.stuartellis.name/articles/python-learning-resources) lists useful learning resources for Python.
