+++
Title = "Notes on the Python Language"
Slug = "python-language"
Date = "2018-09-12T07:18:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["python"]
Type = "article"
Draft = true

+++

Notes on the Python programming language.

# Python

## Language Basics

- Python is case-sensitive.
- In Python, everything is an object.
- Python is [pass-by-object-reference]([https://robertheaton.com/2014/02/09/pythons-pass-by-object-reference-as-explained-by-philip-k-dick/]), rather than pass-by-value or pass-by-reference
- Python uses carriage returns to mark the end of statements.
- To continue lines, use the "\" character.
- Python automatically handles line continuation inside bracketed items like lists and function definitions. To explicitly continue a line, add a \ as the last character.
- Use "=" to assign values.
- Use "==" for comparison.
- Python uses the colon ":" to denote the beginning of code block.
- Python uses indentation to define the end of code blocks! The first line whose indentation does not match the line before is outside the code block.
- Best practice is to use 4 spaces for each level of indentation, rather than a tab.
- There are no explicit "begin" or "end" statements.
- Python can evaluate almost anything as boolean: empty strings, lists, tuples and dictionaries return False, otherwise boolean tests on them return the value True. Zero (0) returns False, any other numeric value is True.
- Double quotes and single quotes are equivalent
- To make a function, class method, etc. private, start the name with two underscores, e.g. \_\_secret.
- Builtin classes, attributes etc. have two underscores before _and after_ the name.
- The null value for Python is the string "None".
- Use "pass" to do nothing. Useful for safely building stubs!

```python
    def myFunction:
    pass
```

## Documentation

You need to install the python-doc package on Debian and Ubuntu to add a copy of the Python documentation to your system.

To read the documentation, open the documentation in your Web browser. Alternatively, run pydoc.

Use the -k option of pydoc to search the documentation by keyword:

bc. pydoc -k KEYWORD

To launch pydoc with a graphical interface for controlling the built-in Web server:

bc. pydoc -g

Ubuntu provides both the text and example programs of the _Dive Into Python_ book with the standard Desktop installation. To read _Dive Into Python_, open the location file:///usr/share/doc/diveintopython/html/index.html in your Web browser. The example programs are in the directory /usr/share/doc/diveintopython/examples/.

To install _Dive Into Python_ on Debian systems, use the package diveintopython.

## Variables

- Variables are declared by being assigned a value, and are automatically destroyed when they go out of scope.
- In Python variables are not explicitly typed - Python works out the data type itself.
- Python raises an error if you reference a variable that has no value assigned to it.
- By default, variables inside a function are private to that function, whilst variable outside a function are global by default. To make a variable inside a function global, prepend it with the keyword global.
- You may assign multiple values as variables in one pass:

```python
    v = ('1', '2', '3')
    (x, y, z) = v
```

The variable "x" now has the value "1", the variable "y" is "2", etc.

_Numeric coercion_ means that if you perform an operation with integers and floating point numbers then the integers are normalized to floats, and the result is a float. Python 2 returns integers from division operations involving integers (_floor division_).

## Functions

All code that does work should be enclosed within a function. Code outside of a function is not handled as quickly.

Arguments are declared after the function name. To provide a default value, specify it with an = after the argument itself:

```python
    def info(object, spacing=10, collapse=1):
```

If you feed arguments to a function by name then you can put those arguments in any order:

```python
    info(odbchelper, collapse=0)
```

With the above, the "space" argument takes the default value of 10.

The first thing that you define in each function is the "doc string" - a triple quoted (""") multi-line comment. This becomes an queryable attribute of the function!

To return a value from a function, simply use a "return" statement within a function. If a functions does not include any "return" statement, it automatically returns "None" (Python's null value).

To define an arbitrary number of positional parameters, create an input parameter whose name is prefixed by an asterisk (\*). The parameters will be collected as a tuple. Similarly, prefix a parameter with \*\* to accept an arbitrary number of keyword parameters: they will be collected in a dictionary.

## Lambda Functions

A lambda function is an in-line function that you can include within code to get a value, rather than having to call out to a separate function. This gives you the ability to create _closures_ that work like _blocks_ in Ruby.

## Built-in Functions

- Python provides it's built-in functions through the module called **builtin**.
- The **builtin** module is automatically available: you do not need to explicitly import it.
- Like all Python functions, the functions in **builtin** have doc strings that you can call as properties of the function.
- The "type" function returns the datatype of any object.
- The "dir" function returns the attributes and methods of an object.
- The "callable" function returns True if the object specified is callable, or False otherwise.
- The "str" function turns an object of any datatype into a string. This includes modules!
- Note that str on a null returns "None", the Python null value.
- The "getattr" function returns the value of the specified attribute of the specified object. If it fails it returns the specified default value.

```python
    getattr(object,attribute,default)
```

## Modules and Packages

A module is just a file that contains Python code. You refer to modules by then name of their file, without the extension.

To import a module, simply use an import statement:

```python
    import mymodule
```

You may import C extensions (.pyd files) in the same way.

A package is a module that contains other modules. To create a package, make a directory with a file called **init**.py (this name is mandatory). The **init**.py file may be empty.

A package directory may contain other packages.

Python automatically checks directories on the sys.path list for the specified module or package.

Once imported, you must use full notation to specify properties or methods from a module, e.g. to specify the doc string from buildConnectionString in the odbchelper module:

```python
    print odbchelper.buildConnectionString.__doc__
```

Similarly:

```python
    from some.package import mymodule
```

Use _as_ to alias long names:

```python
    import modulewithlongname as foo
```

The other forms of import are not recommended. For example, don't import individual functions.

All modules have the built-in attribute **name**.

The **future** module contains experimental features that may become available in future versions of Python.

## Lists

Python lists equate to arrays: they are an ordered set of elements. The items in a list are indexed numerically, starting with 0. So the second item in a list has the index of 1. Each list element may be of any data type, including a list!

To define a list:

```python
    lista = ["a", "b", "c"]
```

To specify an item in a list:

```python
    lista[2]
```

Specify a negative position to start from the end of the list. In other words, -1 is always the last item on a list, -2 the second-to-last item, etc.

To find an item, use the "index" method:

```python
    lista.index("c")
```

This returns the index value of the specified item.

To specify a range of items in a list (a "slice" of the list):

```python
    lista[1:4]
```

This returns a new list that contains the specified elements. You may use negative values when specifying a slice.

To test whether an item is in a particular list, use the "in" method:

```python
    "c" in lista
```

This returns either true or false.

The "append" method adds a single value to the end of a list:

```python
    lista.append("new")
```

The "insert" method adds a single value at the specified position of the list:

```python
    lista.insert(2, "new")
```

The existing values move up to make room.

The "extend" method concatenates an existing list and another list. This statement adds "new", "old", "borrowed", and "blue" to "lista":

```python
    lista.extend(["new", "old", "borrowed", "blue"])
```

To delete a item from a list, use the "remove" method:

```python
    lista.remove("new")
```

The "pop" method deletes the last item on a list, and returns that value:

```python
    lista["new", "old", "borrowed", "blue"]
    lista.pop()
```

The above returns "blue", and removes it from the list.

The "count" method of a list returns the number of occurances of a specified value in the list:

```python
    [elem for elem in li if li.count(elem) == 1]
```

You may use "in" to return whether or not a value exists in the tuple or list:

```python
    "example" in lista
```

h3(#list-comprehension). List Comprehension

You may perform tasks with or on all of the elements in a list.

The basic syntax is:

```python
    [OPERATION for ELEMENTS in LIST]
```

This creates a new list with values double those of in listb:

```python
    listc = [number *2 for number in listb]
```

To filter the list operation, use "if":

```python
    [elem for elem in li if len(elem) > 1]
```

Note that the "is None" filter is faster than "== None" for finding nulls.

Use the _else_ keyword to define behaviour for a loop that will happen if the code in the _for_ loop does not execute a _break_.

```python
l = [2 ,4 , 5, 8,]
for i in l:
  if i % 2 == 0:
    print('Even!')
  else:
    print('Odd!')
    break
else:
  print('No odd numbers in list!')
```

## Dictionaries

Python dictionaries are central to the language. Dictionaries are key:value lists. Each key/value pair is separated by a comma. For example, this defines the dictionary "d":

```python
    d = {'server': 'mpilgrim', 'database': 'master'}
```

To add or modify a key to a dictionary:

```python
    d["uid"] = "sa"
```

Specifying an existing key updates the value. If the key does not exist then Python adds it.

To delete a single key:

```python
    del d[uid]
```

- To wipe a dictionary, use the clear() method:

```python
    d.clear()
```

- To create a dictionary from a list of keys and a list of values, use _zip_:

```python
    k = ['a', 'b', 'c']
    v = [1, 2, 3]
    d = zip(k, v)
```

Python 3.6 and above maintain the items in each dictionary in a consistent order. Older versions did not guarantee that the order would be maintained.

- To link several dictionaries together, use a _ChainMap_.
- If you need to access dictionary items by index number, use a _Counter_, rather than a dictionary.
- If you want to add or remove items at the start or end (e.g. a queue), use a _deque_ (double-ended queue) object, rather than a dictionary or a list.

## Tuples

A tuple is an immutable list: it cannot be changed once created. Tuples are faster to read than lists.

You define a tuple like a list, except that you use round brackets:

```python
    t = ('a', 'b', 'mpilgrim', 'z', 'example')
```

Tuples have no methods or properties. This means that you can't use "index" to search them!

You may use "in" to return whether or not a value exists in the tuple:

```python
    "example" in lista
```

The "tuple" function takes a list and returns a tuple with the same elements.

The "list" function takes a tuple and returns a list with the same elements.

## Comparators

- The "and" comparator returns the first false value.
- If all values are true, "and" returns the last value.
- The "or" comparator returns the first true value.
- If all values are false, "and" returns the last value.
- An empty string is false in Python boolean, so add a value to a list if you want to ensure that "or" "and" statements against it will return a value, rather than an empty string.

## Classes

Use CamelCase for class names.

Python supports classes. The built-in _**init**_ function is the constructor:

```python
    class Foo(object):
        def __init__(self, frob, frotz):
            self.frobnicate = frob
            self.frotz = frotz
```

To call the constructor of a parent class inside the constructor of a sub-class, use the _super()_ function to return the parent:

```python
    class Bar(Foo):
        def __init__(self, frob, frizzle):
            super(Bar, self).__init__(frob, frizzle)
            self.frotz = 34
            self.frazzle = frizzle
```

To create an instance of a class, call the class:

```python
    bar = Bar(1,2)
```

Every user-created class is either directly or indirectly a subclass of the built-in _object_ class. Specify the parent class as object if you do not need your class to inherit from a particular class.

For classes that are strings, lists or dictionaries, subclass from "string", "list", or "dict", rather than "object". These built-in classes subclass from the object class, and include methods for the recommended special methods.

To subclass from multiple ancestor classes, specify each ancestor:

```python
     class MySubClass(MyClass, MyOtherClass):
     """An example class that inherits from multiple classes"""
     def __init__(self):
        pass
```

If a method or attribute in a class has the same name as an item inherited from an ancestor class then the item from the current class _completely_ and totally replaces (overrides) the item inherited from the ancestor.

The "self" keyword stands in for the name of the _instance_ of the class. You only use it within the code of the class itself.

To create an attribute for an instance of the class, use this syntax:

```python
    self.attribute_name = None
```

You also specify class attributes which belong to the class itself. These are available from both the class object, and from any instance of that class.

To declare a method, use "def". The self keyword is always the first parameter, to attach the method to the instance. Otherwise the method would be created as an independent function!

The first method for every class should be **init**. This method runs automatically each time that an instance of the class is created. Use it to instantiate any attribute that an instance of that class must have.

Use the "super" function to run the **init** method for each ancestor class when you create a new instance of a class:

```python
    super().__init__()
```

Otherwise the **init** method for the class overrides the **init** method for ancestor classes, and those ancestor class methods don't run when an instance is created!

When you call a method of an ancestor class from within your class, you must include the self argument.

Every instance of a class has a **class** attribute, which returns the name of the class that it came from.

To get and set instance variables, simply call them in the usual way.

If you need to call custom methods when getting or setting a variable, define a _property_. This aliases the getting and setting actions to the methods that you specify.

If you need a class private variable, prepend the variable with two underscores, e.g. \_\_myvariable.

## File Management

File management functions come from the "os" module. Remember to import this module.

```python
    import os
```

The "glob" module takes a wildcard and returns the full path of all files and directories matching the wildcard.

```python
    import glob
    glob.glob('c:\\music\\*\\*.mp3')
```

Notice that glob lets you have wildcards in both the paths and the filenames.

h3(#handing-paths). Handling Paths

- "os.path" functions enable you to handle pathnames in an OS independent manner.
- "os.listdir" lists the files in a given directory.
- The "os.path" has "join" and "split" functions. Join automatically adds an extra backslash to a pathname before joining it to a filename.
- "os.path.normcase" normalizes the case of the path to OS norms.
- The "splitext" function divides a filename into a name and the extension.
- This returns the home directory of the current user:

```python
    os.path.expanduser("~")
```

## Working with Strings

### Taking Input

The input command takes the input _as a Python expression_. For this reason use "raw_input" instead for string provided by the user:

```python
x = raw_input(value to calculate: )
```

h3(#string-conversion). Converting Other Data Types Into Strings

To convert variables of other data types into strings, either enclose them in str("item"), or in backticks ():

```python
    temp = 42
    print str("temp")

    temp = 42
    print `temp`
```

### Special String Types

Raw strings keep the characters exactly as they were inputed, rather than interpreting escape characters. To make a raw string prefix it with "r":

```python
    windowspath = r'C:\Windows'
```

To specify a string as Unicode, prefix it with "u":

```python
    pagetitle = u'Title'
```

### Joining and Splitting Strings

- Use the split() method on a string to return a list. By default split() uses whitespace to separate values.
- The join method creates a string from a list of values.
- The join method is a method of the separator character, _not_ either of the strings involved:

```python
    stringa = "\n".join(["a","b"])
```

As the split default for split() is any kind of whitespace, use split() and join to normalize separation between values or words within a string. For example, this normalizes "stringa" to single spacing:

```python
print " ".join(stringa.split())
```

## Regular Expressions

Regular expressions use the "re" module.

- The "re.search" function checks a string and returns either "None" (no match) or an object.
- The "re.sub" function carries out search and replace on a string.
- "^" matches the beginning of a string.
- "$" matches the end of a string.
- The "\b" marker means "word boundary".
- The "\d" signifies "any numeric digit".
- "\D" signifies any character that is not a numeric digit.
- Use the "+" character to indicate one or more instances.
- Use the " \*" character to indicate zero or more instances.
- Use {} to designate the number of instances, e.g. "M{1,3}" indicates between 1 and 3 instances of the character "M".

Prefix the regular expression by "r" to enable "raw strings". In "raw strings" characters are taken literally, so that "\n" is read as "\" and "n", rather than a carriage return:

```python
    import re
    re.sub(r'\bROAD\b', 'RD.', strTarget)
```

With "verbose" regular expressions whitespace and comments are ignored. Add the "re.VERBOSE" option to enable verbose regular expressions:

```python
    re.search(pattern, 'M', re.VERBOSE)
```

Bracket a search term to make the search term a "remembered group". You can get the values of what matched by using the groups() method of the object returned by "re.search":

```python
    phonePattern = re.compile(r'^(\d{3})-(\d{3})-(\d{4})-(\d+)$')
    phonePattern.search('800-555-1212-1234').groups()
```

Returns the matches as a tuple:

```python
    ('800', '555', '1212', '1234')
```

## Generators

TODO

## Decorators

TODO

## Descriptors

TODO

## Metaclasses

TODO
