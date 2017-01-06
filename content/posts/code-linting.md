+++
Categories = ["programming"]
Tags = []
Description = ""
Date = "2017-01-06T23:09:00Z"
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
suite of Open Source linters, so we can apply the same linters in the text
editors and build environments of our choice.

# Fun Bonus: Linting Prose #

You can lint your writing as well as your code! (English-only, unfortunately).
[Proselint](http://proselint.com/) tests plain-text files like Markdown
for [an interesting miscellany of problems](http://proselint.com/checks/),
including clichés, jargon, mis-use of punctuation, and other offences against
the English language.

To install Proselint you will need Python 2 or above, and Pip, the Python package
manager. Fedora and Ubuntu include both by default.

On macOS, you will have Python 2, but need to install Pip yourself first. Enter
this command in a terminal window:

    easy_install --user pip

Then add this to your $PATH:

    $HOME/Library/Python/2.7/bin

To install the Proselint command-line tool with Pip, enter this in a terminal
window:

    pip install --user proselint

You can then install a plugin for your text editor. To integrate Proselint into
Atom, add the *linter-proselint* package. If you use the command-line, the APM
command is:

    apm install linter-proselint
