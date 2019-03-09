+++
Title = "Modern Python Practices"
Slug = "python-modern-practices"
Date = "2019-03-09T11:25:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["python"]
Type = "article"
Draft = true

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

## Use Dataclasses 

FIXME

[PEP 557](https://www.python.org/dev/peps/pep-0557/) describes data classes.

Note that you can use the *enum* type in Python 3.4 or above for immutable collections of key-value pairs. Python 3 also has _collections.namedtuple()_ for key-value pairs.

Data classes were introduced in version 3.7 of Python. 

## Use collections.abc for Custom Collection Types

The abstract base classes in _collections.abc_ provide the components for building your own custom collection types.

Use these classes, because they are fast and well-tested. The implementations in Python 3.7 and above are written in C, to provide better performance than Python code.

## Use breakpoint() for Debugging

FIXME

Both the [built-in debugger](https://docs.python.org/3/library/pdb.html) and external debuggers can use breakpoints ???

[PEP 553](https://www.python.org/dev/peps/pep-0553/)

The *breakpoint()* feature was added in version 3.7 of Python.

## Use logging for Diagnostic Messages, Rather Than print()

The built-in *print()* statement is convenient for adding debugging information, but you should include logging in your scripts and applications. Use the [logging](https://docs.python.org/3/library/logging.html#logrecord-attributes) module in the standard library. 

## Use asyncio Where It Makes Sense 

TODO

Use _context variables_, which are safe for asyncio.

Context variables were introduced in version 3.7 of Python.

SQL database access... 

## Use Automatic Code Formatting

[PEP 8](https://www.python.org/dev/peps/pep-0008/) provides the accepted style guide for Python code. Use a formatting tool with a plugin to your editor, so that your code is automatically formatted to meet the standards of PEP 8. 

[Black](https://black.readthedocs.io/en/stable/) is replacing *autopep8* as the popular formatting tool for Python code.

## Read the Functional Programming HOWTO

The official documentation includes a [Functional Programming HOWTO](???)

FIXME

# Libraries

## Use argparse for Command-line Parsing 

The [argparse](https://docs.python.org/3/library/argparse.html) module is now the recommended way to process command-line input. Use _argparse_, rather than the older _optparse_ and _getopt_.

The _optparse_ module is officially deprecated, so update code that uses _optparse_ to use _argparse_ instead. 

Refer to [the argparse tutorial](https://docs.python.org/3/howto/argparse.html) in the official documentation for more details.

## Use pathlib for File and Directory Paths

Use [pathlib](https://docs.python.org/3/library/pathlib.html) objects instead of strings whenever you need to work with file and directory pathnames. 

Use the [the pathlib equivalents for os functions](https://docs.python.org/3/library/pathlib.html#correspondence-to-tools-in-the-os-module).

The existing methods in the standard library have been updated to support _pathlib_, such as _os.scandir()_.

The *pathlib* module was added to the standard library in version 3.4 of Python. 

## Use subprocess for Running External Commands

The [subprocess](https://docs.python.org/3/library/subprocess.html) module provides a safe way to run external commands. Use _subprocess_ rather than shell backquoting or the functions in _os_, such as _spawn_, _popen2_ and _popen3_. 

The _subprocess.run()_ function in current versions of Python is sufficient for most cases.

[PEP 324](https://www.python.org/dev/peps/pep-0324/) explains the technical details in depth. 

## Use Requests for HTTP Clients

Use the [requests](http://docs.python-requests.org/en/master/) package for HTTP, rather than the _urllib.request_ in the standard library. 

## Use pytest for Testing

[pytest](http://pytest.org) has superceded *nose* as the most popular testing system for Python. Use the *unittest* module in the standard library for situations where you cannot add pytest to the project.

# Managing Environments

## Use pipenv or Poetry

The combination of _pip_ and virtual environments help to make Python software easier to work with.

Docker...

TODO
