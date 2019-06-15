+++
Title = "The Standard Tools of the Ruby Platform"
Slug = "ruby-platform"
Date = "2016-07-01T01:00:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["ruby"]
Type = "article"
Toc = true

+++


Today, several implementations of Ruby exist, all using the same
language syntax, and providing the same platform components. This
article is a set of notes on the standard components of this common Ruby
platform.

<!--more-->

# Platform Overview #

The core components of a Ruby platform are:

* A Ruby interpreter
* The Ruby standard library
* An interactive shell
* *RubyGems* package manager
* *rdoc* documentation infrastructure
* *ri* command-line documentation viewer

> *Rake:* As of Ruby 1.9, the Rake task automation system is also
> officially part of the Ruby platform.

The official Ruby 1.8 platform uses the MRI interpreter and the *irb*
interactive shell. MRI is implemented in C, and versions are compiled
for all mainstream operating systems. Ruby 1.9 uses the much faster
YARV, instead of MRI. JRuby runs on the JRE, and is actually a Java
library.

### RubyGems Packages ###

RubyGems provides a cross-platform mechanism for managing the
third-party Ruby software on your system, which are provided as *gem*
packages. For convenience, set up Ruby itself by following the
appropriate installation process for your operating system, and then use
RubyGems to install and update the rest of your Ruby software.

RubyGems is part of the standard library for Ruby 1.9, and is often
supplied with distributions of Ruby 1.8, but was not included in
official Ruby 1.8 releases. For this reason, the process for installing
Ruby 1.8 on your system may involve an extra step to set up RubyGems.

# The Ruby Shell #

A Ruby shell lets you simply type code and run it, without needing to
setup any application structure. This lets you quickly write and run
one-time jobs, and try things out.

To run an interactive Ruby shell on Debian or Ubuntu, type:

    irb1.8

The *irb* program runs the contents of the file *\~/.irbrc* when the
shell is started. Use this file to define user-specific settings.

Use the *-d* option to run irb with debugging:

    irb -d

On Windows, use the *fxri* program provided by the One Click Ruby
Installer, instead of irb.

### Built-in Commands ###

In addition to standard Ruby code, you may invoke built-in commands
inside an irb session:

* *fg* - switch to a different subsession
* *irb* - creates a new subsession
* *jobs* - list current irb subsessions
* *conf* - display configuration settings
* *exit* - exit the shell

# More on RubyGems #

Each *gem* package is an archive file that encloses both code and spec
files. The spec defines the package, and lists any other gem packages
that are required for it to function. RubyGems can then automatically
install the requirements for a requested package before it installs the
package itself.

All gems are versioned, and you may have multiple versions of the same
package installed. A gem may also be digitally signed, but this is not
mandatory. Use the *security policy* option to specify how RubyGems
should handle signed and unsigned gems.

### Installing Packages with RubyGems ###

A very simple example:

    gem install hpricot

By default, RubyGems downloads gem packages from the RubyForge Website,
but you may add or remove source servers.

Notice that the *gem* utility copies metadata and the required gem files
into a local cache for reuse, before installing or updating any files
that are required to complete the operation that you specified.

> *Gem Installation Directory:* The current version of RubyGems installs
> gems into a .gem subdirectory within your home directory, unless you
> run the commands as an administrator. This was not the case before
> version 1.3 of RubyGems.

Some gems include C libraries as well as Ruby, and these are marked with
the platform that the C code has been compiled for, e.g. *win32* for
Windows platforms. In these cases, the gems for the *ruby* platform
actually provide source code, and RubyGems will automatically attempt to
compile working extensions as part of the setup process.

To run unit tests prior to installing a gem, add the *-t* option:

    gem install gem-name -t

To specify a security policy to apply when installing a gem, use the
*-P* option:

    gem install gem-name -P HighSecurity

To install a specific version of a gem, use the *-v* option:

    gem install gem-name -v version-number

To install a gem without the documentation, use the options:

    gem install gem-name --no-doc --no-ri

This option is probably most useful for servers.

### Querying with RubyGems ###

The *gem* utility provides two basic features for querying repositories.
Use *gem list* as a convenient way to find the name of relevant gems,
and *gem query* for more detailed searches.

To get a list of all of the gem packages that are already installed on
your system, run the *list* command:

    gem list

If you add part, or all of a word, *gem list* show only those gems whose
names begin with that set of characters:

    gem list ra

To see a list of those packages whose names or descriptions include a
particular word, use *query* with the *-n* option:

    gem query -n search-word

To search the public server, use the same command, but specify the
*—remote* option:

    gem query --remote -n search-word

Use the *—details* option to see a little more information with the
search results:

    gem query --details -n search-word

To view exhaustive details of a gem, use *specification*, instead of
*list* or *query*. The specification command only applies to the one
specific gem that is named, rather than all of those that match a search
term:

    gem specification --remote gem-name

Use the same command with *—local* to investigate an installed gem.

### Removing Packages with RubyGems ###

To remove a gem, use *uninstall*:

    gem uninstall gem-name

The routine will prompt you before it removes any command-line utilities
that have been installed by the package.

### Updating Installed Gems ###

> *Updating System Files Requires Administrative Privileges:* As always,
> you need administrator privileges to successfully change any software
> that is installed in a system directory. This includes the system copy
> of RubyGems, and any gems that are in the global gems directory for
> the system.

Run the *update* command to upgrade all of the gems on your system:

    gem update

By design, this command does not automatically upgrade RubyGems itself.
To do that use the *—system* option:

    gem update --system

To upgrade a particular gem, specify the name of the gem package:

    gem update gem-name

Any dependencies for the gem will also be updated at the same time.

### Other RubyGems Facilities ###

For a list of supported *gem* operations:

    gem command options

You only need to enter enough of the command name to uniquely identify
it.

For example, to display help text for all of the available commands,
type one of the following:

     gem help commands
     gem h commands

Other useful commands:

* *gem server* - To launch a Web server that makes gem packages and
    documentation available.
* \_gem ~~h\_~~ Display short list of options.
* \_gem ~~v\_~~ Display RubyGems version.
* *gem help command-name* - Displays the help text for the specified
    command.

# Using the Built-in Documentation #

To view documentation for packages installed with RubyGems in a Web
browser, first start the gem server:

    gem server

The server attaches to port 8808 of your system, so use this URL in any
browser:

    http://localhost:8808

By default, the server reads the documentation for the system gem
directory. To access the documentation for another directory, such as
the private gem directory for your account, specify the gem directory
with the *-d* option. For example:

    gem server -d ~/.gem/ruby/1.8/

Press Ctrl-C to shutdown the server.

### Accessing the Documentation from the Command-line ###

The *ri* utility provides access to documentation from the command-line.
Simply type *ri*, followed by the name of item that you would
information about. For clarity, *ri* requires that you specify a method
in the form *Class::method* for class methods, and *Class\#method* for
instance methods.

    ri Array
    ri Array::new
    ri Array#clear

The *ri* utility automatically checks a per-user *\~/.rdoc* directory,
the Ruby *system* documentation directory for standard library
documentation, the directory that RubyGems installs documentation into,
and the *site* documentation directory that global installations of
third-party software use. RubyGems automatically generates the
documentation for any software that you install with the *gem* command.

To view a help document as HTML, use the *-f* option of *ri* to output
it in HTML format, and then redirect the result:

    ri -f html Array > array.html

### Generating Documentation ###

The supplied *rdoc* utility reads Ruby source code files and extracts
information from the comments to generate HTML documentation.
Optionally, *rdoc* can generate help files for the *ri* command-line
help system.

    rdoc mycode/
    rdoc code1.rb code2.rb

Useful *rdoc* options:

* *-a* Document all methods, not just public methods.
* *-d* Create class and module diagrams in the well-known *dot*
    file format.
* *-o* directory-name Specify the output directory.
* *-q* Process files silently.
* *--ri* Generate ri documentation and install it in the user
    location.
* *--ri-site* Generate ri documentation and install it in the site
    location.
* *--ri-system* Generate ri documentation and install it in the
    system location.

# The ERB Template System #

The Ruby standard library includes a template system called ERB, which
can you use to generate documents, Web pages, source code, or any other
form of text. ERB is very tightly integrated with Ruby, and this enables
it to be extremely powerful whilst remaining very simple to use.

# The Rake Task Automation Utility #

Technically, Rake is a build system. In practice, it is a convenient way
to automate just about any small task.
