+++
Title = "Modern Python Practices"
Slug = "python-modern-practices"
Date = "2022-05-26T06:30:00+01:00"
Description = ""
Categories = ["programming", "python"]
Tags = ["python"]
Type = "article"

+++

[Python](https://www.python.org/) has a long history, and it has evolved over time. This article describes some agreed modern best practices.

<!--more-->

# Tooling

### Use Python 3

Use Python 3.9 or above for new work. Third-party libraries may require Python 3.6 or above, and several features of modern Python work best with version 3.7 or later.

Avoid using Python 2. It is not supported by the Python development team. The current versions of many libraries are not compatible with Python 2.

### Use Virtual Environments for Development

The [virtual environments](https://docs.python.org/3/tutorial/venv.html) feature enables you to define separate sets of packages for each Python project, so that they do not conflict with each other.

There are several tools that help you to manage your Python projects, and use virtual environments. [Poetry](https://python-poetry.org/) is currently popular, but it may be superseded by [Hatch](https://hatch.pypa.io). If you prefer, you can also manually set up and manage virtual environments.

### Format Your Code

Use a formatting tool with a plugin to your editor, so that your code is automatically formatted to a consistent style.

If possible, use [Black](https://black.readthedocs.io/en/stable/) to format your code. Black is now the leading code formatter for Python. Black has been adopted by the Python Software Foundation and other major Python projects. It formats Python code to a style that follows the [PEP 8](https://www.python.org/dev/peps/pep-0008/) standard, but allows longer line lengths.

# Language Syntax

### Format Strings with f-strings

The new [f-string](https://docs.python.org/3/reference/lexical_analysis.html#f-strings) syntax is both more readable and has better performance than older methods. Use f-strings instead of _%_ formatting, _str.format()_ or _str.Template()_.

The older features for formatting strings will not be removed, to avoid breaking backward compatibility.

The f-strings feature was added in version 3.6 of Python. Alternate implementations of Python may include this specific feature, even when they do not support version 3.6 syntax.

> [PEP 498](https://www.python.org/dev/peps/pep-0498/) explains f-strings in detail.

### Use Datetime Objects with Time Zones

Always use **datetime** objects that are [aware](https://docs.python.org/3/library/datetime.html?highlight=datetime#aware-and-naive-objects) of time zones. By default, Python creates datetime objects that do not include a time zone. The documentation refers to datetime objects without a time zone as **naive**.

Avoid using **date** objects, except where the time of day is completely. The **date** objects are always **naive**, and do not include a time zone.

Use aware datetime objects with the UTC time zone for timestamps, logs and other internal features.

To get the current time and date in UTC as an aware datetime object, specify the UTC time zone with **now()**. For example:

```python
from datetime import datetime, timezone

dt = datetime.now(timezone.utc)
```

Python 3.9 and above include the **zoneinfo** module. This provides access to the standard IANA database of time zones.

> [PEP 615](https://www.python.org/dev/peps/pep-0615/) describes support for the IANA time zone database with **zoneinfo**.

### Use enum or Named Tuples for Immutable Sets of Key-Value Pairs

Use the _enum_ type in Python 3.4 or above for immutable collections of key-value pairs. Python 3 also has _collections.namedtuple()_ for immutable key-value pairs.

### Create Data Classes for Custom Data Objects

The data classes feature enables you to reduce the amount of code that you need to define classes for objects that exist to store values. The new syntax for data classes does not affect the behavior of the classes that you define with it. Each data class is a standard Python class.

Data classes were introduced in version 3.7 of Python.

> [PEP 557](https://www.python.org/dev/peps/pep-0557/) describes data classes.

### Use collections.abc for Custom Collection Types

The abstract base classes in _collections.abc_ provide the components for building your own custom collection types.

Use these classes, because they are fast and well-tested. The implementations in Python 3.7 and above are written in C, to provide better performance than Python code.

### Use breakpoint() for Debugging

This function drops you into the debugger at the point where it is called. Both the [built-in debugger](https://docs.python.org/3/library/pdb.html) and external debuggers can use these breakpoints.

The [breakpoint()](https://docs.python.org/3/library/functions.html#breakpoint) feature was added in version 3.7 of Python.

> [PEP 553](https://www.python.org/dev/peps/pep-0553/) describes the _breakpoint()_ function.

### Consider Using Type Hinting

Current versions of Python support type hinting. If you include these annotations, the [Mypy](http://www.mypy-lang.org/) tool can check your code.

> [PEP 484 - Type Hints](https://peps.python.org/pep-0484/) and [PEP 526 – Syntax for Variable Annotations](https://peps.python.org/pep-0526/) define the notation for type hinting.

# Application Design

### Use Logging for Diagnostic Messages, Rather Than print()

The built-in _print()_ statement is convenient for adding debugging information, but you should include logging in your scripts and applications. Use the [logging](https://docs.python.org/3/library/logging.html#logrecord-attributes) module in the standard library, or a third-party logging module.

### Only Use asyncio Where It Makes Sense

The [asynchronous features of Python](https://docs.python.org/3/library/asyncio.html) enable a single process to avoid blocking on I/O operations. You can achieve concurrency by running multiple Python processes, with or without asynchronous I/O.

To run multiple Web application processes, use [Gunicorn](https://gunicorn.org/) or another WSGI server. Use the [multiprocessing](https://docs.python.org/3/library/multiprocessing.html) package in the Python standard library to build custom applications that run as multiple processes.

Code that needs asynchronous I/O must not call any function in the standard library that synchronous I/O, such as _open()_, or the _logging_ module.

If you would like to work with _asyncio_, always use the most recent version of Python. Each new version of Python has improved the performance and features of async. For example, version 3.7 of Python introduced [context variables](https://docs.python.org/3/library/contextvars.html), which enable you to have data that is local to a specific _task_.

The initial version of _asyncio_ was included in version 3.4 of Python. Keywords for _async_ and _await_ were added in Python 3.5. Context variables and the _asyncio.run()_ function were introduced in version 3.7 of Python.

> [PEP 0567](https://www.python.org/dev/peps/pep-0567/) describes context variables.

# Libraries

### Handle Command-line Input with argparse

The [argparse](https://docs.python.org/3/library/argparse.html) module is now the recommended way to process command-line input. Use _argparse_, rather than the older _optparse_ and _getopt_.

The _optparse_ module is officially deprecated, so update code that uses _optparse_ to use _argparse_ instead.

Refer to [the argparse tutorial](https://docs.python.org/3/howto/argparse.html) in the official documentation for more details.

### Use pathlib for File and Directory Paths

Use [pathlib](https://docs.python.org/3/library/pathlib.html) objects instead of strings whenever you need to work with file and directory pathnames.

Consider using the [the pathlib equivalents for os functions](https://docs.python.org/3/library/pathlib.html#correspondence-to-tools-in-the-os-module).

The existing methods in the standard library have been updated to support Path objects.

To list all of the the files in a directory, use either the _.iterdir()_ function of a Path object, or the _os.scandir()_ function.

This [RealPython article](https://realpython.com/working-with-files-in-python/#directory-listing-in-modern-python-versions) provides a full explanation of the different Python functions for working with files and directories.

The _pathlib_ module was added to the standard library in Python 3.4, and other standard library functions were updated to support Path objects in version 3.5 of Python.

### Use os.scandir() Instead of os.listdir()

The _os.scandir()_ function is significantly faster and more efficient than _os.listdir()_. Use _os.scandir()_ wherever you previously used the _os.listdir()_ function.

This function provides an iterator, and works with a context manager:

```python
import os

with os.scandir('some_directory/') as entries:
    for entry in entries:
        print(entry.name)
```

The context manager frees resources as soon as the function completes. Use this option if you are concerned about performance or concurrency.

The _os.walk()_ function now calls _os.scandir()_, so it automatically has the same improved performance as this function.

The _os.scandir()_ function was added in version 3.5 of Python.

> [PEP 471](https://www.python.org/dev/peps/pep-0471/) explains _os.scandir()_.

### Run External Commands with subprocess

The [subprocess](https://docs.python.org/3/library/subprocess.html) module provides a safe way to run external commands. Use _subprocess_ rather than shell backquoting or the functions in _os_, such as _spawn_, _popen2_ and _popen3_. The _subprocess.run()_ function in current versions of Python is sufficient for most cases.

> [PEP 324](https://www.python.org/dev/peps/pep-0324/) explains the technical details of subprocess in detail.

### Use Requests for HTTP Clients

Use the [requests](https://2.python-requests.org/en/master/) package for HTTP, rather than the _urllib.request_ in the standard library.

### Test with pytest

Use [pytest](http://pytest.org) for testing. It has has superceded _nose_ as the most popular testing system for Python. Use the _unittest_ module in the standard library for situations where you cannot add pytest to the project.
