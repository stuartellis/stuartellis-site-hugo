+++
Title = "Shell Scripting"
Slug = "shell-scripting"
Date = "2018-10-10T08:09:00+00:00"
Description = "Shell scripting"
Categories = ["administration", "programming"]
Tags = ["administration", "shell", "bash"]
Type = "article"
Draft = true

+++

Notes on shell scripting for Bash and other UNIX shells.

<!--more-->

# The Shebang Line: /bin/sh Vs. /bin/bash

[Stack Overflow answer on bash vs .sh](https://stackoverflow.com/questions/5725296/difference-between-sh-and-bash)

[checkbashisms](http://manpages.ubuntu.com/manpages/cosmic/en/man1/checkbashisms.1.html)

Debian-based systems use the Dash shell for system scripts, and Alpine Linux uses the shell implementation that is part of Busybox.

# Enabling Better Error Handling with set

Always use a *set* command at the start of your scripts, immediately after the shebang line:

~~~bash
set -euo pipefail
~~~

To print each command that the shell runs as it executes, add the *-x* option:

~~~bash
set -xeuo pipefail
~~~

# Use ShellCheck to Validate Your Scripts

[ShellCheck](https://www.shellcheck.net/)

# Online Resources

* [Progrium notes on good Bash style](https://github.com/progrium/bashstyle)
* [Google Style Guide for Shell](https://google.github.io/styleguide/shell.xml)