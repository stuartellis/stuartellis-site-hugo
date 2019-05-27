+++
Title = "Setting Up Python on Microsoft Windows"
Slug = "python-development-windows"
Date = "2019-04-27T10:51:00+01:00"
Description = ""
Categories = ["programming", "python"]
Tags = ["python", "windows"]
Type = "article"
Toc = true

+++

How to set up [Python](https://www.python.org/) on Microsoft Windows.

<!--more-->

# Installing Python on Windows

First, download the latest version of Python from [the official
Website](http://www.python.org/). Choose the _Windows x86-64 executable installer_ for the latest version of Python 3, unless you know that you need a different option.

Run the installer, and select the option to _Add Python to PATH_, so that you do not need to type the full path for Python commands. If prompted, choose the option to remove the path length limitation from Windows.

Python includes a complete copy of the official documentation, including the language reference and tutorials. To read the documentation, select the _Manuals_ item in the _Python_ folder on your _Start_ menu.

# Enabling Python in the Git Bash Shell

Git for Windows includes a UNIX shell. This is the same Bash shell that is standard on macOS and Linux. It also includes some of the same tools, such as _ssh_ and the _nano_ text editor.

To run Python inside this shell:

1. Start _Git Bash_
1. Type this command: _nano ~/.bash_profile_
1. Write the lines shown below in the window
1. Use _Ctrl-X_ to save and exit the editor
1. Type _exit_ to close the Git Bash window

The next time that you open Git Bash, the _python_ command will work as expected.

The Bash profile must include these lines:

```shell
alias python="winpty python"
alias pip="winpty pip"
```

# Setting up for Software Development

[This article](https://www.stuartellis.name/articles/python-getting-started) explains the next steps for working with Python.
