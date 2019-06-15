+++
Title = "Shell Scripting for UNIX-like Systems"
Slug = "shell-scripting"
Date = "2019-06-09T21:29:00+01:00"
Description = "Shell scripting"
Categories = ["automation", "devops", "programming"]
Tags = ["automation", "devops", "shell", "bash"]
Type = "article"
Toc = true

+++

Notes on shell scripting with Bash and other UNIX shells.

<!--more-->

# The Shebang Line: /bin/sh and /bin/bash

Start your shell scripts with the shebang _sh_, unless you have a specific reason to require another shell. Linux and other UNIX-like systems all include a symbolic link for _/bin/sh_ that points to the default shell for the operating system.

If you use the _sh_ shebang, shells will detect this, and interpret your script using the syntax of the [Bourne shell](https://en.wikipedia.org/wiki/Bourne_shell), without any extra features. This means that the script should run correctly in all of the shells that supports the Bourne syntax.

The shebang line for _sh_ is:

```shell
#!/bin/sh
```

The shells that support Bourne syntax include Bash, [Z shell (zsh)](https://en.wikipedia.org/wiki/Z_shell), the Debian Almquist shell (dash), and the [Almquist](https://en.wikipedia.org/wiki/Almquist_shell) shell that is part of Busybox.

Most Linux systems use Bash for shell scripts. Current versions of macOS also provide Bash, but [macOS Catalina uses Z shell by default](https://support.apple.com/en-ca/HT208050). Debian-based systems use the Dash shell for _sh_ scripts, and Bash for interactive shells. Alpine Linux uses Busybox.

If you need to use features that are specific to Bash, use the _bash_ shebang. This means that the script will be run by Bash, rather than the default shell.

This [Stack Overflow answer on bash vs .sh](https://stackoverflow.com/questions/5725296/difference-between-sh-and-bash) provides more details.

Debian-based systems, such as Ubuntu, provide the [checkbashisms](http://manpages.ubuntu.com/manpages/cosmic/en/man1/checkbashisms.1.html) tool for you to be able to test scripts for portability.

# Enabling Better Error Handling with set

Always use a _set_ command at the start of your scripts, immediately after the shebang line:

```shell
set -eu
```

Bash and some other shells provide the _-o pipefail_ option, but it is not part of the POSIX standard.

```bash
set -euo pipefail
```

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

### Bash Startup Scripts

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
- _MAIL_ The user's email inbox location.

# Running Commands on Remote Systems with SSH

To run a single command, use the _ssh_ utility:

```bash
ssh user1@server1.example "command"
```

To run multiple commands, use a HERE-doc:

```shell
ssh user1@server1.example << HERE
 command1
 command2
HERE
```

To run a script on a remote system, use SSH to send the contents of the script file to a script interpreter on the remote system. This example uses the bash shell:

```shell
ssh user1@server1.example '/bin/bash -s' < scriptfile.sh
```

The _-s_ option means that the bash shell will run what is sent to it from the standard input.

> ssh exits with either the exit status of the remote command, or with status number 255 if an error occurred.

# Online Resources

### Using the Command-line

- [The Art of Command Line](https://github.com/jlevy/the-art-of-command-line) - A guide to mastering the command-line
- [Explainshell](https://explainshell.com/) - enter a command-line on this site to see the help text that matches each argument

### Bash Scripting

- [Ryan Chadwick's Tutorial for Bash Scripting](https://ryanstutorials.net/bash-scripting-tutorial) - A gentle introduction to Bash
- [GreyCat's Bash Guide](http://mywiki.wooledge.org/FullBashGuide) - A more comprehensive guide to Bash
- [Progrium notes on good Bash style](https://github.com/progrium/bashstyle)
- [Google Style Guide for Shell](https://google.github.io/styleguide/shell.xml)
