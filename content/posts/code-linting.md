+++
Categories = ["programming"]
Tags = []
Description = ""
Date = "2017-01-09T07:54:00Z"
Title = "A Pocket Guide to Linting (Code Linting Everywhere on Your Project)"
Type = "post"
Draft = true

+++

Linting is an extremely effective aid for maintaining code, and it is now
easy to set up the same quality checking on both your development and continuous
integration systems.

<!--more-->

This post uses a Ruby on Rails project as an example, since I'm familiar with
Rails and it uses a mixture of programming languages. My text editor of choice
is [Atom](http://www.atom.io), and for simplicity we'll use [Code
Climate](https://codeclimate.com) for server-based linting. Code Climate runs a
suite of Open Source linters, so that we can apply the same linters in the text
editors and build environments of our choice.

# So, Umm, What is a Linter? #

A linter is a command-line tool that checks one or more files that have been
written in a particular programming language against a set of rules. If a line
in a file does not meet one of these rules, the linter prints outs the line
number, and the rule. Modern computers can analyze a complete project with a
linter in seconds, or less.

Currently, every linter is an independent project that is written for a specific
programming language. For example, the [ESLint](http://eslint.org/) utility
checks JavaScript (and ES2015, and JSX) files for compliance with a set of good
practices, and is written in JavaScript itself.

Like many UNIX things, the simple tools become much more powerful as they are
used in conjunction with other software. You can manually run a linter against
the files in your project, but you will get much more value from having other
applications automatically run linters. The Atom test editor integrates with
linters through plugins, so that you can get feedback as your write your code,
and services like Code Climate can check your code on every Git push.

# How Automatic Linting Works in Atom #

To use a particular linter with Atom, you must install the appropriate linter
package. Several linter packages include a copy of the linter utility itself,
which means that these packages will work without any setup. In other cases, the
packages for Atom rely on you installing the command-line linter separately.

Once you add linter packages in Atom, the editor runs a linter each time that
you open or save a file that is relevant to the installed linter packages. If
there are any linter warnings for an open file, the bottom of the file tab shows
a list of linter warnings, and the total number of issues for the current file
also appears in the bar at the bottom of the Atom window.

Incidentally, you will notice that Atom has a package that is just called
*linter*, and is labelled *A Base Linter with Cow Powers*. This is the framework
that all of the actual linter packages for various programming languages use,
and it is installed the first time that you add any linter package to Atom.

# Setting Up Code Linting with Atom #

TODO

# Coala #

TODO

https://coala.io/

# Fun Bonus: Linting Prose #

You can lint your writing as well as your code! (English-only, unfortunately).
[Proselint](http://proselint.com/) tests plain-text files like Markdown
for [an interesting miscellany of problems](http://proselint.com/checks/),
including clichés, jargon, mis-use of punctuation, and other offences against
the English language.

Like Rubocop, Proselint requires you to have support for a particular
programming language installed on your computer. To use Proselint, you will need
Python 2 or above, and Pip, the Python package manager.

On macOS, you will have Python 2, but will need to install Pip yourself first.
Enter this command in a terminal window:

    easy_install --user pip

Then add this to the $PATH for your user account:

    $HOME/Library/Python/2.7/bin

Fedora and Ubuntu include both Python and Pip by default, so you do not need
to do either of the previous steps on these Linux systems.

To install the Proselint command-line tool with Pip, enter this in a terminal
window:

    pip install --user proselint

You can then install a plugin for your text editor. To integrate Proselint into
Atom, add the *linter-proselint* package. If you use the command-line, the APM
command is:

    apm install linter-proselint
