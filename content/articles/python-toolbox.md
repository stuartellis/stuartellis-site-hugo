+++
Title = "Useful Python Tools and Libraries"
Slug = "python-toolbox"
Date = "2022-05-07T08:18:00+01:00"
Description = ""
Categories = ["programming", "python"]
Tags = ["python"]
Type = "article"
Toc = true

+++

Key tools and libraries for the [Python](https://www.python.org/) programming language.

<!--more-->

## Using Python Command-Line Applications

Use [pipx](https://pypi.org/project/pipx/) to install Python command-line tools.

The pipx utility uses the _pip_ and [virtual environment](https://docs.python.org/3/tutorial/venv.html) facilities that are included with Python itself.

## Online Development Environments

These services enable you to work on Python projects in a cloud-based environment:

- [Python Anywhere](https://www.pythonanywhere.com/)
- [repl.it](https://repl.it/)

To quickly share pieces of code, use [Pastebin](https://pastebin.com/).

## Working on Python Projects

### Use pipenv for Virtual Environments

Install [pipenv](https://pipenv.pypa.io) to manage your Python projects. It ensures that each of your Python projects use a separate set of packages, and provides other features to help you maintain your work, such as [checking the code for style](https://docs.pipenv.org/advanced/#code-style-checking) and [warning you about security issues in libraries](https://docs.pipenv.org/advanced/#detection-of-security-vulnerabilities).

The pipenv tool uses the _pip_ and [virtual environment](https://docs.python.org/3/tutorial/venv.html) facilities that are included with Python itself, so it is compatible with other Python utilities.

The [Python Guide tutorial](http://docs.python-guide.org/en/latest/dev/virtualenvs/) shows you how to work with _pipenv_.

> [Hatch](https://ofek.dev/hatch) may replace pipenv, but it is not yet fully supported by code editors and third-party tools.

### Working with Multiple Versions of Python

If you need to develop with several different versions of Python, use [pyenv](https://github.com/pyenv/pyenv). This tool enables you to install multiple versions of Python on the same system, and switch between them.

### Managing Projects

- [Cookiecutter](https://cookiecutter.readthedocs.io/) to create new projects from templates
- [Sphinx](https://www.sphinx-doc.org) for building documentation

### Code Quality

- [Black](https://black.readthedocs.io/en/stable/) for code formatting
- [Pylint](https://www.pylint.org) for code quality

If you install the Python extension for Visual Studio Code, it will offer to use Pylint and autopep8 to check and format your code. Use Black instead of autopep8 for new projects.

### Tools for Testing Python Code

- [Pytest](http://pytest.org) for testing
- [Tox](https://tox.readthedocs.io/) runs sets of tests in multiple Python environments
- [Coverage](https://pypi.python.org/pypi/coverage/) for measuring the test coverage of code
- [Faker](http://faker.rtfd.org/) - Generates fake data
- [mypy](http://www.mypy-lang.org/) - Static type checking, using Python type annotations
- [Bandit](https://pypi.python.org/pypi/bandit) to check your code for common security issues
- [Safety](https://pyup.io/safety/) to check your project dependencies for known security vulnerabilities

## Developing Command-line Applications

Consider using [Typer](https://typer.tiangolo.com/) to build new command-line tools with Python. This builds on [Click](https://click.palletsprojects.com), which is the established framework for Python command-line tools.

[Python Fire](https://github.com/google/python-fire) enables you to add a command-line interface to existing code.

## Building Web Applications

For simple Websites and services, use the [Flask](https://flask.palletsprojects.com) framework. Flask itself provides the basic package of features that you need for a Web application, and the framework has a wide range of extensions to add more capabilities.

Use either [Django](http://www.djangoproject.com/) or [Pyramid](https://trypyramid.com/) for larger projects. Django provides a set of custom tools and libraries that closely integrate together. The main Django framework has features for content Websites, whilst [Django REST Framework](https://www.django-rest-framework.org/) is specifically for building APIs. Pyramid offers a modular framework for integrating third-party Python libraries together into custom Web applications.

All of these Web frameworks follow the WSGI standard for synchronous Python Web applications. This enables you to choose between many options for hosting your Python projects. In each case, a WSGI server such as [Gunicorn](https://gunicorn.org/) runs your code on the host system.

Several commercial services offer fully managed systems, so that you can deploy applications without any setting up or maintaining any servers yourself. These services include [Google App Engine](https://cloud.google.com/appengine/), [Heroku](https://www.heroku.com/) and [Python Anywhere](https://www.pythonanywhere.com/).

If you need more control over the infrastructure that your application uses, consider using containers, rather than setting up a cluster of Web servers. Services for hosting containers include [Red Hat OpenShift](https://www.openshift.com/), [DigitalOcean Kubernetes](https://www.digitalocean.com/products/kubernetes/) and [Google Kubernetes Engine](https://cloud.google.com/kubernetes-engine/).

[Full Stack Python](https://www.fullstackpython.com) provides a comprehensive guide to building Web applications with Python.

> Whichever Web framework you use, add the [secure.py](https://secure.readthedocs.io/en/latest/) extension to implement Web security features.

### Asynchronous Web Applications

Use [FastAPI](https://fastapi.tiangolo.com) for building API services that are asynchronous. If you need more control or compatibility than FastAPI provides, consider using either [Starlette](https://www.starlette.io/) or [Quart](https://pgjones.gitlab.io/quart/). Starlette is more low-level than FastAPI. Quart is specifically designed to use the same API as Flask.

These frameworks implement the [ASGI](https://asgi.readthedocs.io/en/latest/) standard. The [Uvicorn](http://www.uvicorn.org/) server implements ASGI, so that it can host applications that are built with any asynchronous framework that follows ASGI.

The [aiohttp](https://docs.aiohttp.org/en/stable) library provides an asynchronous HTTP client and server. The aiohttp server does not support ASGI.

## Developing Web Clients

Use the [requests](http://docs.python-requests.org/en/master/) library for your Web client software, such as downloading files or working with APIs. The HTTP support in the Python standard library is for low-level code.

If you need to get information from Websites that do not provide an API, use [Scrapy](https://doc.scrapy.org). You can then extract content from the pages with the [Beautiful Soup](https://www.crummy.com/software/BeautifulSoup/) library.

## Working with SQL Databases

The Python standard library includes a version of [SQLite](http://www.sqlite.org/). This means that you can use SQL databases in any Python project without installing a separate database product. Avoid underestimating SQLite: it is a robust and efficient database that will handle gigabytes of data.

To access other types of SQL databases such as PostgreSQL, MySQL, or Oracle, install the Python driver that the vendor of the database recommends. Each Python driver will require a particular client library. For example, the recommended Python driver for PostgreSQL is [psycopg](http://initd.org/psycopg/), which requires a copy of the libpq library.

> _Connecting to Microsoft SQL Server_: [Microsoft recommend that you use the ODBC adapter for SQL Server](https://docs.microsoft.com/en-us/sql/connect/python/python-driver-for-sql-server).

Whichever brand of SQL database you work with, use a database toolkit, rather than writing data access and schema management code yourself.

[SQLAlchemy](http://www.sqlalchemy.org/) is the standard Python library for database programming. You may use the declarative portion of SQLAlchemy like a standard ORM, but it has many more capabilities.

If your project has limited or specific needs, consider alternatives to SQLAlchemy. [Peewee](http://docs.peewee-orm.com/) offers a lightweight alternative to SQLAlchemy for accessing the most popular brands of Open Source database. For Django projects, use the Object-Relational Mapper (ORM) that is provided with Django, because this is integrated with the other features of the framework.

## Building Graphical Desktop Applications

Consider using [wxPython](http://wxpython.org/) to build graphical interfaces for your applications. The Tk interface toolkit that is supplied with the Python standard library is rather basic and dated. If you have advanced needs, you may prefer [QT for Python](https://www.qt.io/qt-for-python), which enables you to make use of the [QT](https://www.qt.io/) libraries.

If you are building 2D games, try [pygame](https://www.pygame.org). This provides a simple toolkit for games and multimedia applications.

## Microsoft Windows Integration

Python includes support for some features that are unique to Microsoft Windows, but not all of them. To use Python with other features of Windows, such as COM and the Registry, install the [win32 Extensions](https://github.com/mhammond/pywin32).

## Packaging Applications

Use [PyInstaller](http://www.pyinstaller.org/) to create applications that you can give to other people. PyInstaller creates stand-alone executables that include Python itself, your code, and any other dependencies. Follow the steps described in the [RealPython.com tutorial](https://realpython.com/pyinstaller-python/) to add PyInstaller to your project.

If you only need to deploy your application to systems that you know will have a suitable version of Python, use [shiv](https://github.com/linkedin/shiv). The shiv utility packages your application and dependencies into a ZIP file that Python interpreters will run.

To run your Python server applications on Kubernetes, package them as containers.

## Other Useful Libraries

- [Jinja2](http://jinja.pocoo.org/) - Text templating, for generating HTML and other formats
- [Matplotlib](https://matplotlib.org/) - Plotting 2D graphs and charts
- [Pendulum](https://pendulum.eustace.io/) - Date and time parsing
- [Pillow](https://python-pillow.org/) - Image processing
- [python-dotenv](https://github.com/theskumar/python-dotenv) - Load environment variables from files
- [pytz](https://pythonhosted.org/pytz/) - Timezone database, for Python versions 3.8 and below
- [PyYAML](https://pyyaml.org/) - YAML support for Python
- [Reportlab](https://www.reportlab.com/opensource/) - PDF generation

## Learning Resources

[This article](https://www.stuartellis.name/articles/python-learning-resources) lists useful learning resources for Python.
