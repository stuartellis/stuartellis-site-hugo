+++
Title = "Starting Python Development on Windows"
Slug = "python-development-windows"
Date = "2018-12-30T18:11:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["python", "windows"]
Type = "article"

+++

Notes on starting [Python](https://www.python.org/) development, with specific details on using Microsoft Windows.

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

If you are new to programming, start with [Mu](https://codewith.mu/), which is specifically designed to help new developers work with Python.

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

# Building Graphical Desktop Applications

If you are specifically interested in developing desktop applications, start with [wxPython](http://wxpython.org/). The Tk interface toolkit that is supplied with the Python standard library is rather basic and dated. If you have advanced needs, consider [QT for Python](https://www.qt.io/qt-for-python), which enables you to make use of the [QT](https://www.qt.io/) libraries. 

# Microsoft Windows Integration

Python includes support for some features that are unique to Microsoft Windows, but not all of them. To use Python with other features of Windows, such as COM and the Registry, install the [win32 Extensions](https://github.com/mhammond/pywin32).

# Packaging Applications

To build packaged applications for Windows, use [PyInstaller](http://www.pyinstaller.org/). This creates stand-alone executables that include Python itself, your code, and any other dependencies.

# Learning Resources

[This article](https://www.stuartellis.name/articles/python-learning-resources) lists useful learning resources for Python.
