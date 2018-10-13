+++
Title = "Shell Scripting"
Slug = "shell-scripting"
Date = "2018-10-13T17:59:00+00:00"
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

Bash and some other shells provide the *-o pipefail* option, but it is not part of the POSIX standard.  

In addition, add the *-E* option to ensure that *ERR* traps catch errors from functions and subshells:

~~~bash
set -Eeuo pipefail
~~~

To print each command that the shell runs as it executes, add the *-x* option:

~~~bash
set -xeuo pipefail
~~~

# Use ShellCheck to Validate Your Scripts

The [ShellCheck](https://www.shellcheck.net/) utility will spot common mistakes and issues in your shell scripts. Always use this tool, because it will enable you to avoid whole classes of problem. For example, ShellCheck considers unquoted strings to be an issue, because of the risk of [wordsplitting](http://mywiki.wooledge.org/WordSplitting).

# Use sh to Format Your Shell Scripts

The [sh](https://github.com/mvdan/sh) utility will format your shell scripts to be consistent.

# Online Resources

* [Ryan Chadwick's Tutorial for Bash Scripting](https://ryanstutorials.net/bash-scripting-tutorial) - A gentle introduction to Bash
* [GreyCat's Bash Guide](http://mywiki.wooledge.org/FullBashGuide) - A more comprehensive guide to Bash
* [Progrium notes on good Bash style](https://github.com/progrium/bashstyle)
* [Google Style Guide for Shell](https://google.github.io/styleguide/shell.xml)
* [Explainshell](https://explainshell.com/) - enter a command-line on this site to see the help text that matches each argument 