+++
Title = "Modern Python Practices"
Slug = "python-modern-practices"
Date = "2019-02-09T13:56:00+01:00"
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

The new f-string syntax is both more readable and has better performance than older methods.

TODO

## Use Dataclasses 

TODO

## Use asyncio Where It Makes Sense 

TODO

SQL database access... 

## Use Automatic Code Formatting

[PEP 8](https://www.python.org/dev/peps/pep-0008/) provides the accepted style guide for Python code. Use a formatting tool with a plugin to your editor, so that your code is automatically formatted to meet the standards of PEP 8. 

[Black](https://black.readthedocs.io/en/stable/) is replacing *autopep8* as the standard formatting tool for Python code.

# Libraries

## Use pathlib for File and Directory Paths

Use [pathlib](https://docs.python.org/3/library/pathlib.html) objects instead of strings whenever you need to work with file and directory pathnames. 

Use the [the pathlib equivalents for os functions](https://docs.python.org/3/library/pathlib.html#correspondence-to-tools-in-the-os-module).

The existing methods in the standard library have been updated to support _pathlib_, such as _os.scandir()_.

The *pathlib* module was added to the standard library in version 3.4 of Python. 

## Use popen3

TODO

## Use Requests for HTTP Clients

TODO

## Use pytest for Testing

[pytest](http://pytest.org) has superceded *nose* as the most popular testing system for Python. Use the *unittest* module in the standard library for situations where you cannot add pytest to the project.

# Possibly Controversial 

## Consider Using Debug or a Logger Instead of print()

A _debug()_ was added...

TODO

## Make Use of Type Hints

TODO

## Use pipenv or Poetry to Manage Development Environments

The combination of _pip_ and virtual environments help to make Python software easier to work with.

Docker...

TODO

## Pickle, Shelve, and Serialization

TODO
