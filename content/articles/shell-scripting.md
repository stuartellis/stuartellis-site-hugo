+++
Title = "Shell Scripting for UNIX-like Systems"
Slug = "shell-scripting"
Date = "2018-11-25T15:13:00+00:00"
Description = "Shell scripting"
Categories = ["administration", "programming"]
Tags = ["administration", "shell", "bash"]
Type = "article"
Draft = true

+++

Notes on shell scripting for Bash and other UNIX shells.

<!--more-->

# The Shebang Line: /bin/sh Vs. /bin/bash

Start your shell scripts with the shebang for either _sh_ or _bash_.
The _bash_ shebang means that the script may use syntax that is specific to Bash. The _sh_ shebang means that the script should follow the syntax of the [Bourne shell](https://en.wikipedia.org/wiki/Bourne_shell), which implemented by many shells, including Bash, and the [Almquist](https://en.wikipedia.org/wiki/Almquist_shell) shell that is part of Busybox.

The shebang line for _sh_ is:

```bash
#!/bin/sh
```

Most Linux systems use Bash for shell scripts. Current versions of macOS also use Bash. Debian-based systems include Bash, but use the Dash shell for _sh_ scripts. Alpine Linux uses Busybox.

This [Stack Overflow answer on bash vs .sh](https://stackoverflow.com/questions/5725296/difference-between-sh-and-bash) provides more details.

Debian-based systems, such as Ubuntu, provide the [checkbashisms](http://manpages.ubuntu.com/manpages/cosmic/en/man1/checkbashisms.1.html) tool for you to be able to test scripts for portability.

# Enabling Better Error Handling with set

Always use a _set_ command at the start of your scripts, immediately after the shebang line:

```bash
set -euo pipefail
```

Bash and some other shells provide the _-o pipefail_ option, but it is not part of the POSIX standard.

In addition, add the _-E_ option to ensure that _ERR_ traps catch errors from functions and subshells:

```bash
set -Eeuo pipefail
```

To print each command that the shell runs as it executes, add the _-x_ option:

```bash
set -xeuo pipefail
```

# Use ShellCheck to Validate Your Scripts

The [ShellCheck](https://www.shellcheck.net/) utility will spot common mistakes and issues in your shell scripts. Always use this tool, because it will enable you to avoid whole classes of problem. For example, ShellCheck considers unquoted strings to be an issue, because of the risk of [wordsplitting](http://mywiki.wooledge.org/WordSplitting).

# Use sh to Format Your Shell Scripts

The [sh](https://github.com/mvdan/sh) utility will format your shell scripts to be consistent.

# Preparing the Environment

Each UNIX shell runs a specific set of scripts each time that starts. Use these default scripts to set environment variables.

If Bash is started as an interactive non-login shell, it runs the .bashrc scripts. The terminal windows on a Linux graphical desktop are non-login shells.

If Bash is started as an interactive login shell, it runs .bash_profile, .bash_login, and .profile (in that order).

If Bash is started as a non-interactive, non-login shell, it runs the script specified by the BASH_ENV environment variable.

If Bash is started with _sh_, it runs /etc/profile and ~/.profile scripts.

The global system copy of each default script will be in the _/etc_ directory, and there may be a second script with the same name in the home directory of the current user. Both of these scripts will run.

> For convenience, operating system vendors provide default scripts that call other scripts.

# Standard Environment Variables on Linux

The [Debian Wiki](https://wiki.debian.org/EnvironmentVariables) page lists these standard environment variables:

- _PATH_ Colon separated list of directories to search for commands.
- _HOME_ Current user's home directory.
- _LOGNAME_ Current user's name.
- _SHELL_ The user's preferred shell.
- _EDITOR_ The user's preferred text editor.
- _MAIL_ The user's electronic mail inbox location.

# Online Resources

- [Ryan Chadwick's Tutorial for Bash Scripting](https://ryanstutorials.net/bash-scripting-tutorial) - A gentle introduction to Bash
- [GreyCat's Bash Guide](http://mywiki.wooledge.org/FullBashGuide) - A more comprehensive guide to Bash
- [Progrium notes on good Bash style](https://github.com/progrium/bashstyle)
- [Google Style Guide for Shell](https://google.github.io/styleguide/shell.xml)
- [Explainshell](https://explainshell.com/) - enter a command-line on this site to see the help text that matches each argument
