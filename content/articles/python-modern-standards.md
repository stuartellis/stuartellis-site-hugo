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

## Use Black to Format Your Code

TODO

# Libraries

## Use pathlib for File and Directory Paths

The [pathlib](https://docs.python.org/3/library/pathlib.html) module was added to the standard library in version 3.4 of Python. Use _pathlib_ objects instead of strings whenever you need to work with file and directory pathnames. The existing methods in the standard library have been updated to support _pathlib_, such as _os.scandir()_.

## Use popen3

TODO

## Use Requests for HTTP Clients

TODO

## Use pytest for Testing

TODO

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
