+++
Categories = ["programming"]
Tags = []
Description = ""
Date = "2017-01-14T15:28:00Z"
Title = "A Pocket Guide to Linting (Code Linting Everywhere on Your Project)"
Type = "post"
Draft = true

+++

[Lint checking](https://en.wikipedia.org/wiki/Lint_(software)) is an extremely
effective aid for maintaining the quality of your code, and it is now easy to
set up the same quality checking on both your development and continuous
integration systems.

<!--more-->

FIXME: Pictures!

My text editor of choice is [Atom](http://www.atom.io), and in this post we'll
also look at enforcing lint checks in the build process with [Travis
CI](https://travis-ci.org/), and setting up [Code
Climate](https://codeclimate.com) to give us project analysis with a nice user
interface. Code Climate runs a suite of Open Source linters, so that we can
apply the same linter rules in all of these environments.

Travis and Code Climate themselves are proprietary services, but there is no fee
for Open Source projects. To self-host your Continuous Integration and code
analysis, try [Jenkins](https://jenkins.io) with either linters or [Sonarqube](https://www.sonarqube.org).

# So, Umm, What is a Linter? #

A linter is a command-line tool that checks one or more files that have been
written in a particular programming language or data format against a set of
rules. If a line in a file does not meet one of these rules, the linter prints
outs the line number, and the rule that has been broken. Modern computers can
analyze a complete project with a linter in seconds, or less.

Currently, every linter is an independent project that is written for a specific
data format or programming language. For example, the
[ESLint](http://eslint.org/) utility checks JavaScript (and ES2015, and JSX)
files for compliance with a set of good practices, and is written in JavaScript
itself.

Like many UNIX things, the simple tools become much more powerful as they are
used in conjunction with other software. You can manually run a linter against
the files in your project, but you will get much more value from having other
applications automatically run linters. The Atom test editor integrates with
linters through plugins, so that you can get feedback as your write your code,
and you can set your CI system to fail commits that introduce poor code.
Services like Code Climate will provide more detailed reports for every Git
push.

# A Handy List of Linters #

* CoffeeScript - Linter: [CoffeeLint](http://www.coffeelint.org/), Atom package: [linter-coffeelint](https://atom.io/packages/linter-coffeelint)
* CSS - Linter: [CSSLint](http://csslint.net/), Atom package: [linter-csslint](https://atom.io/packages/linter-csslint)
* English (see below!) - Linter: [Proselint](http://proselint.com/), Atom package: [linter-proselint](https://atom.io/packages/linter-proselint)*
* Go - Linter: [golinter](https://github.com/golang/lint), Atom package: [linter-golinter](https://atom.io/packages/linter-golinter)*
* Java - [linting is built-in](https://docs.oracle.com/javase/8/docs/technotes/tools/unix/javac.html), Atom package: [linter-javac](https://atom.io/packages/linter-javac)
* JavaScript and JSX - Linter: [ESLint](http://eslint.org/), Atom package: [linter-eslint](https://atom.io/packages/linter-eslint)
* PHP - [linting is built-in](http://www.php.net/manual/en/features.commandline.options.php), Atom package: [linter-php](https://atom.io/packages/linter-php)
* Python - Linter: [Pylint](https://www.pylint.org/), Atom package: [linter-pylint](https://atom.io/packages/linter-pylint)*
* Ruby - Linter: [Rubocop](http://batsov.com/rubocop/), Atom package: [linter-rubocop](https://atom.io/packages/linter-rubocop)*
* Rust - [linting is built-in](https://doc.rust-lang.org/reference.html#lint-check-attributes), Atom package: [linter-rust](https://atom.io/packages/linter-rust)
* XML - Linter: [xmllint](http://xmlsoft.org/xmllint.html), Atom package: [linter-xmllint](https://atom.io/packages/linter-xmllint)*
* YAML - Linter: [yaml-js](http://nodeca.github.com/js-yaml/), Atom package: [linter-js-yaml](https://atom.io/packages/linter-js-yaml)

The asterisk means that the Atom linter package for that language requires the
separate command-line linter utility to be installed. Check the Web page for the
package, which will explain.

# Automatic Linting in Atom #

To use a particular linter with the Atom editor, install the appropriate
package. I prefer to install multiple Atom packages from the command-line,
simply because it is quicker to copy and paste the command. The *apm* utility
that is supplied with Atom makes this easy:

    apm install linter-csslint linter-eslint linter-rust

A number of these packages will work without any other setup. Several packages
include a copy of the linter utility itself, because the utility is written in
JavaScript. In other cases, like Java and Rust, the programming language
includes linting capabilities in the default installation.

Otherwise, the packages for Atom rely on you installing the command-line linter
separately. For example, if you are a Ruby developer, either include the Rubocop
linter in your projects with Bundler, or add it to your Ruby installation:

    gem install rubocop

Then enter this command to install the Atom package:

    apm install linter-rubocop

Once you add linter packages in Atom, the editor runs a linter each time that
you open or save a file that is relevant to whichever installed linter packages.
If there are any linter warnings for an open file, the bottom of the file tab
shows a list of linter warnings. The number of issues for the current file and
the total number of linter issues for the project also appear in the bar at the
bottom of the Atom window.

FIXME: Pictures!

Incidentally, you will notice that Atom has a package that is just called
*linter*, and is labelled *A Base Linter with Cow Powers*. This is the framework
that all of the actual linter packages for various programming languages use,
and it is installed the first time that you add any linter package to Atom.

# Tuning Your Linters #

Once you have started using linters, you will quickly realise that you do not
always agree with what they tell you. Sometimes there will be parts of your code
where you deliberately break rules, or standard rules that you do not agree
with. For this reason, each linter will check the root directory of your project
for a configuration file that overrides the defaults, and have ways of adjusting
or disabling rules for particular files.

Each linter works differently, so it is hard to generalise beyond this. For a
good example of a linter, with documentation for
[rules](http://eslint.org/docs/rules/), [how to configure
them](http://eslint.org/docs/user-guide/configuring#configuring-rules), [how to
exclude specific
files](http://eslint.org/docs/user-guide/configuring#ignoring-files-and-directories),
and [how to disable individual rules for a particular
file](http://eslint.org/docs/user-guide/configuring#disabling-rules-with-inline-comments),
take a look at [the documentation for
ESLint](http://eslint.org/docs/user-guide/configuring).

By the way, if you use Code Climate, the setup process generates a set of
configuration files for the default linters, so that you can download and add
these to your project immediately.

# Adding Linter Testing to Your Continuous Integration #

Here, we will use a linter to provide a simple pass or fail test for commits:
if the linter finds any issue, the test fails. This enables us to enforce coding
standards for the project, since we must specifically exclude every issue that
we do not intend to fix. If that is too much work, just set up project analysis
to report issues, as shown in the next section.

The [Travis CI documentation](https://docs.travis-ci.com/). [Travis for Node.js developers by dwyl](https://github.com/dwyl/learn-travis).

FIXME

First, make sure that the build environment will have the linter installed. Modern CI systems usually create a clean environment for each build, so you need to either add this to the job configuration for the CI service, or include the linter as a dependency for  the builds.

Next, add the configuration files for your linter to the repository for your project.

FIXME: Pictures!

If you don't like Travis, you can use an alternative service, such as
[CircleCI](https://circleci.com/), [Codeship](https://codeship.com/) or
[Semaphore](https://semaphoreci.com/), all of which have a free plan for light
use. For example, the *circle.yml* file for CircleCI would look like this:

FIXME

# Project Analysis with Code Climate #

FIXME

https://docs.codeclimate.com/docs/getting-started-configuration

FIXME: Pictures!

Once you have set up a project, add a webhook to your Continuous Integration
system to trigger a Code Climate report each time that a commit is pushed. If
you are using Travis, the documentation includes a section on [Code
Climate](https://docs.travis-ci.com/user/code-climate/).

If you don't like Code Climate, alternative services include
[Codacy](https://www.codacy.com/), [CodeFactor](https://www.codefactor.io/),
[Hound](https://houndci.com/) and
[QuantifiedCode](https://www.quantifiedcode.com/).

# Bonus Fun: Linting Prose #

You can lint your writing as well as your code! (English-only, unfortunately).
[Proselint](http://proselint.com/) tests plain-text files like Markdown for [an
interesting miscellany of problems](http://proselint.com/checks/). These include
stray punctuation and FIXMEs, as well as clichés, jargon, and other offences
against the English language.

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

Behold:

FIXME: Pictures!
