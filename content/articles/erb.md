+++
Title = "An Introduction to ERB Templating"
Slug = "erb"
Date = "2016-07-01T01:00:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["rails", "ruby"]
Type = "article"
Toc = true

+++


ERB (Embedded RuBy) is a feature of Ruby that enables you to
conveniently generate any kind of text, in any quantity, from templates.

<!--more-->

# Overview #

ERB templates combine plain text with Ruby code for variable
substitution and flow control, making them easy to write and
maintain.

Although ERB is most commonly seen generating Web pages, it is also used
to produce XML documents, RSS feeds, source code, and other forms of
structured text file. It can be extremely valuable when you need to
create files which include many repetitions of a standard pattern, such
as unit test suites.

The main component of ERB is a library which you can call within your
Ruby applications and Rake tasks. This library accepts any string as a
template, and imposes no limitations on the source of the template. You
may define a template entirely within your code, or store it in an
external location and load it as required. This means that you can keep
templates in files, SQL databases, or any other kind of storage that you
want to use.

Ruby distributions also include a command-line utility that enables you
to process templates that are held in files without writing any
additional code. Logically, this utility is called *erb*.

> ERB is part of the Ruby standard library. You do not need to install
> any other software to use it. Rails uses an improved version, called Erubis.

The supplied documentation for ERB provides a good introduction:

    ri ERB

# Writing Templates #

ERB copies the text portions of the template directly to the generated
document, and only processes code that is identified by markers. Most
ERB templates only use a combination of two tag markers, each of which
cause the enclosed code to be handled in a particular way.

A tag with an equals sign indicates that enclosed code is an
*expression*, and that the renderer should substitute the code element
with the result of the code (as a string) when it renders the template.
Use an expression to embed a line of code into the template, or to
display the contents of a variable:

~~~ruby
Hello, <%= @name %>.
Today is <%= Time.now.strftime('%A') %>.
~~~

Tags without the equals sign denote that the enclosed code is a
*scriptlet*. Each scriptlet is caught and executed, and the final result
of the code is then injected in to the output at the point of the
scriptlet.

Scriptlets are most commonly used for embedding loops or conditional
logic into templates:

~~~ruby
<% for @item in @shopping_list %>
  <%= @item %>
<% end %>
~~~

Notice that the scriptlets in this example enclose an expression. The
scriptlets produce no text themselves, but cause the enclosed expression
to run multiple times, and the result of the expression is written to
the output each time.

Comment markers use a hash sign:

~~~ruby
<%# This is just a comment %>
~~~

By default, a newline character is added to the page after the position
of each tag. To suppress this newline, use the optional parameter of
*ERB.new()*, as explained below.

Rails extends ERB, so that you can suppress the newline simply by adding
a trailing hyphen to tags in Rails templates:

~~~ruby
<% for @item in @items -%>
  <%= @item %>
<% end -%>
~~~

## Using Text Transformation Methods ##

ERB provides optional methods for transforming text.

This will be HTML escaped:

~~~ruby
<%= h(this & that) %>
~~~

This will be JSON encoded:

~~~ruby
<%= j(this & that) %>
~~~

This will be converted to Textile markup:

~~~ruby
<%= t(this & that) %>
~~~

This will be URL encoded:

~~~ruby
<%= u(this & that) %>
~~~

To use these features your code must *include* the module *ERB::Util*.

## Conventions for Template Files ##

A file that contains an ERB template may have any name, but it is the
convention that the name of file should end with the *.erb* extension.
Rails requires template files to have the extension of the output type,
followed by *.erb*, so that a name like *layout.html.erb* indicates a
HTML template. Some applications use the extension *.rhtml* for HTML
templates.

If you store templates in files, it is good practice to keep each
template in a separate file.

## Using the ERB Library ##

This is a very simple example:

~~~ruby
require 'erb'

weekday = Time.now.strftime('%A')
simple_template = "Today is <%= weekday %>."

renderer = ERB.new(simple_template)
puts output = renderer.result()
~~~

ERB only processes the template when *result* is called. This means that
the output will show the values of variables as they are at the moment
when the *result* is rendered, not when the *ERB* object was defined.

The code shown above will fail almost anywhere other than in a simple
script. ERB gets variables from a *Binding*, an object that provides
access to the instance methods and variables that are owned by another
object. If you do not specify a Binding, the *result()* method gets a
Binding from the top-level object, which will probably own very little.
Fortunately, every Ruby class has a private *binding()* instance method
to provide Bindings that points to itself, so we can easily extend any
object to provide ERB with a Binding.

If the ERB object is enclosed in a method, and we want it to use the
variables of the host object, we get a Binding for the host like this:

~~~ruby
class ShoppingList
  attr_accessor :items, :template

  def render()
    renderer.result(binding)
  end
end
~~~

To enable ERB to use the variables from a separate object, we must first
ensure that it has a public method to provide a Binding. We can then get
a Binding at any later point:

~~~ruby
class ShoppingList
  attr_accessor :items

  def initialize(items)
    @items = items
  end

  # Expose private binding() method.
  def get_binding
    binding()
  end

end

list = ShoppingList.new(items)
renderer = ERB.new(template)
puts output = renderer.result(list.get_binding)
~~~

## Running ERB in a Sandbox ##

You may protect your application from ERB by running it in a new thread.
If you specify an integer as a second parameter when you create the
renderer, then the template will be processed in a new thread which has
a *safe level* equal to the given integer:

~~~ruby
renderer = ERB.new(template, 3)
~~~

Safe level 4 provides maximum isolation. At this level, the specified
binding must be marked as trusted for ERB to use it.

If you need to set the third or fourth parameters, but do not want ERB
to run in a new thread, use 0 as the second parameter.

## Suppressing Newlines ##

The third parameter of *new* specifies optional modifiers, most of which
alter when newline characters will be automatically added to the output.
For example, ERB will not print newlines after tags if you give *\>* as
the third parameter:

~~~ruby
renderer = ERB.new(template, 3, '>')
~~~

## A Longer Example ##

~~~ruby
require 'erb'

def get_items()
  ['bread', 'milk', 'eggs', 'spam']
end

def get_template()
  %{
        Shopping List for <%= @date.strftime('%A, %d %B %Y') %>

        You need to buy:

          <% for @item in @items %>
            <%= h(@item) %>
          <% end %>
  }
end

class ShoppingList
  include ERB::Util
  attr_accessor :items, :template, :date

  def initialize(items, template, date=Time.now)
    @date = date
    @items = items
    @template = template
  end

  def render()
    ERB.new(@template).result(binding)
  end

  def save(file)
    File.open(file, "w+") do |f|
      f.write(render)
    end
  end

end

list = ShoppingList.new(get_items, get_template)
list.save(File.join(ENV['HOME'], 'list.html'))
~~~

# Running ERB from the Command-line #

The *erb* utility processes a given template and sends the result to the
standard output. This enables you to generate files directly from
templates, by redirecting the output:

    erb my-template.txt.erb > new-file.txt

The template can automatically use built-in Ruby classes, such as
*String* and *File*. To allow it to access standard or third-party
libraries, use the *-r* option. This option works in the same way as the
*require* keyword. This example processes a template that uses the
*Abbrev* and *IPAddr* libraries:

    erb -r abbrev -r ipaddr my-template.txt.erb  > new-file.txt

Use the *-S* option to specify a *safe level* that isolates the template
processing:

    erb -S 4 my-template.txt.erb > new-file.txt

Safe levels are explained above.

# Other Resources #

* [The ERB documentation](http://ruby-doc.org/ruby-1.9/classes/ERB.html)

These books explain ERB (and many other things):

* [Programming Ruby](http://www.pragprog.com/titles/ruby/programming-ruby)
* [Ruby Best Practices](http://www.rubybestpractices.com/)
