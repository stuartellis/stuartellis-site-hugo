+++
Title = "Modern Python Practices"
Slug = "python-modern-practices"
Date = "2019-03-10T08:16:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["python"]
Type = "article"

+++

[Python](https://www.python.org/) has a long history, and has evolved over time. This article describes some agreed modern best practices. 

<!--more-->

# Language

## Use Python 3

Use Python 3 for all new work. Python 2 will no longer be supported, as of 2020. All of the major libraries and frameworks now support Python 3. Several will remove support for Python 2 in upcoming releases.

## Use f-strings to Format Strings

The new [f-string](https://docs.python.org/3/reference/lexical_analysis.html#f-strings) syntax is both more readable and has better performance than older methods. Use f-strings instead of _%_ formatting, *str.format()* or *str.Template()*.

The older features for formatting strings will not be removed, to avoid breaking backward compatibility. 

[PEP 498](https://www.python.org/dev/peps/pep-0498/) explains f-strings in detail.

The f-strings feature was added in version 3.6 of Python. Alternate implementations of Python may include this specific feature, even when they do not support version 3.6 syntax.

## Use Data Classes 

The data classes feature enables you to reduce the amount of code that you need to define classes for objects that exist to store values. The new syntax for data classes does not affect the behavior of the classes that you define with it. Each data class is a standard Python class.

[PEP 557](https://www.python.org/dev/peps/pep-0557/) describes data classes.

Note that you can use the *enum* type in Python 3.4 or above for immutable collections of key-value pairs. Python 3 also has _collections.namedtuple()_ for immutable key-value pairs.

Data classes were introduced in version 3.7 of Python. 

## Use collections.abc for Custom Collection Types

The abstract base classes in _collections.abc_ provide the components for building your own custom collection types.

Use these classes, because they are fast and well-tested. The implementations in Python 3.7 and above are written in C, to provide better performance than Python code.

## Use breakpoint() for Debugging

This function drops you into the debugger at the point where it is called. Both the [built-in debugger](https://docs.python.org/3/library/pdb.html) and external debuggers can use these breakpoints.

[PEP 553](https://www.python.org/dev/peps/pep-0553/) describes the _breakpoint()_ function.

The [breakpoint()](https://docs.python.org/3/library/functions.html#breakpoint) feature was added in version 3.7 of Python.

## Use Logging for Diagnostic Messages, Rather Than print()

The built-in *print()* statement is convenient for adding debugging information, but you should include logging in your scripts and applications. Use the [logging](https://docs.python.org/3/library/logging.html#logrecord-attributes) module in the standard library, or a third-party logging module.

## Use asyncio Where It Makes Sense 

There are multiple ways to achieve concurrency with Python. In many cases, the appropriate solution uses multiple processes, such as a WSGI Web server like [Gunicorn](https://gunicorn.org/), or the [multiprocessing](https://docs.python.org/3/library/multiprocessing.html) package in the standard library. The [asynchronous features of Python](https://docs.python.org/3/library/asyncio.html) enable a single process to avoid blocking on I/O operations. 

If you would like to work with _asyncio_, always use the most recent version of Python. Each new version of Python has improved the performance and features of async. For example, version 3.7 of Python introduced [context variables](https://docs.python.org/3/library/contextvars.html), which enable you to have data that is local to a specific _task_.

[PEP 0567](https://www.python.org/dev/peps/pep-0567/) describes context variables.

The initial version of _asyncio_ was included in version 3.4 of Python. Keywords for _async_ and _await_ were added in Python 3.5. Context variables and the _asyncio.run()_ function were introduced in version 3.7 of Python.

## Use Automatic Code Formatting

[PEP 8](https://www.python.org/dev/peps/pep-0008/) provides the accepted style guide for Python code. Use a formatting tool with a plugin to your editor, so that your code is automatically formatted to meet the standards of PEP 8. 

[Black](https://black.readthedocs.io/en/stable/) is replacing *autopep8* as the popular formatting tool for Python code, even though Black is officially in beta testing.

# Libraries

## Use argparse for Command-line Parsing 

The [argparse](https://docs.python.org/3/library/argparse.html) module is now the recommended way to process command-line input. Use _argparse_, rather than the older _optparse_ and _getopt_.

The _optparse_ module is officially deprecated, so update code that uses _optparse_ to use _argparse_ instead. 

Refer to [the argparse tutorial](https://docs.python.org/3/howto/argparse.html) in the official documentation for more details.

## Use pathlib for File and Directory Paths

Use [pathlib](https://docs.python.org/3/library/pathlib.html) objects instead of strings whenever you need to work with file and directory pathnames. 

Consider using the [the pathlib equivalents for os functions](https://docs.python.org/3/library/pathlib.html#correspondence-to-tools-in-the-os-module).

The existing methods in the standard library have been updated to support Path objects.

To list all of the the files in a directory, use either the _.iterdir()_ function of a Path object, or the _os.scandir()_ function.

This [RealPython article](https://realpython.com/working-with-files-in-python/#directory-listing-in-modern-python-versions) provides a full explanation of the different Python functions for working with files and directories.

The *pathlib* module was added to the standard library in Python 3.4, and other standard library functions were updated to support Path objects in version 3.5 of Python.

## Use os.scandir() Instead of os.listdir()

The _os.scandir()_ function is significantly faster and more efficient than  _os.listdir()_. Use _os.scandir()_ wherever you previously used the _os.listdir()_ function.

This function provides an iterator, and works with a context manager:

```python
import os

with os.scandir('some_directory/') as entries:
    for entry in entries:
        print(entry.name)
```

The context manager frees resources as soon as the function completes. Use this option if you are concerned about performance or concurrency. 

The _os.walk()_ function now calls _os.scandir()_, so it automatically has the same improved performance as this function.

[PEP 471](https://www.python.org/dev/peps/pep-0471/) explains _os.scandir()_.

The _os.scandir()_ function was added in version 3.5 of Python.

## Use subprocess for Running External Commands

The [subprocess](https://docs.python.org/3/library/subprocess.html) module provides a safe way to run external commands. Use _subprocess_ rather than shell backquoting or the functions in _os_, such as _spawn_, _popen2_ and _popen3_. The _subprocess.run()_ function in current versions of Python is sufficient for most cases.

[PEP 324](https://www.python.org/dev/peps/pep-0324/) explains the technical details of subprocess in depth.

## Use Requests for HTTP Clients

Use the [requests](http://docs.python-requests.org/en/master/) package for HTTP, rather than the _urllib.request_ in the standard library. 

## Use pytest for Testing

The [pytest](http://pytest.org) package has superceded *nose* as the most popular testing system for Python. Use the *unittest* module in the standard library for situations where you cannot add pytest to the project.

# Use Virtual Environments for Development

The [virtual environments](https://docs.python.org/3/tutorial/venv.html) feature enables you to define separate sets of packages for each Python project, so that they do not conflict with each other.

You may use the utilities that are included with Python to manage virtual environments, but the documentation currently recommends that you use [pipenv](https://docs.pipenv.org/) instead. Many developers now prefer the [poetry](https://poetry.eustace.io/) tool.