+++
Title = "Shell Scripting for UNIX-like Systems"
Slug = "shell-scripting"
Date = "2018-11-26T18:47:00+00:00"
Description = "Shell scripting"
Categories = ["administration", "programming"]
Tags = ["administration", "shell", "bash"]
Type = "article"

+++

Notes on shell scripting with Bash and other UNIX shells.

<!--more-->

# The Shebang Line: /bin/sh and /bin/bash

Start your shell scripts with the shebang for either _sh_ or _bash_.
The _bash_ shebang means that the script may use syntax that is specific to Bash. The _sh_ shebang means that the script should follow the syntax of the [Bourne shell](https://en.wikipedia.org/wiki/Bourne_shell), which is implemented by many shells. The shells that support Bourne syntax include Bash, and the [Almquist](https://en.wikipedia.org/wiki/Almquist_shell) shell that is part of Busybox.

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

# Startup Scripts

Each UNIX shell runs a specific set of scripts each time that starts. Use these default scripts to set environment variables.

Bash runs different scripts, depending on how is started:

- Started as an interactive non-login shell, it runs the .bashrc scripts. The terminal windows on a Linux graphical desktop are non-login shells.
- Started as an interactive login shell, it runs .bash_profile, .bash_login, and .profile (in that order).
- Started as a non-interactive, non-login shell, it runs the script specified by the BASH_ENV environment variable.
- Started with _sh_, it runs /etc/profile and ~/.profile scripts.

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

# Running Commands on Remote Systems with SSH

To run a single command, use the _ssh_ utility:

```bash
ssh user1@server1.example "command"
```

To run multiple commands, use a HERE-doc:

```bash
ssh user1@server1.example << HERE
 command1
 command2
HERE
```

To run a script on a remote system: pipe the contents of the script to the _ssh_ command:

```bash
cat script1.sh | ssh user1@server1.example
```

> ssh exits with either the exit status of the remote command, or with status number 255 if an error occurred.

# Online Resources

- [Ryan Chadwick's Tutorial for Bash Scripting](https://ryanstutorials.net/bash-scripting-tutorial) - A gentle introduction to Bash
- [GreyCat's Bash Guide](http://mywiki.wooledge.org/FullBashGuide) - A more comprehensive guide to Bash
- [Progrium notes on good Bash style](https://github.com/progrium/bashstyle)
- [Google Style Guide for Shell](https://google.github.io/styleguide/shell.xml)
- [Explainshell](https://explainshell.com/) - enter a command-line on this site to see the help text that matches each argument
