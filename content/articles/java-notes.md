
+++
Title = "Notes on the Java Language"
Slug = "java-language"
Date = "2018-08-26T19:38:00+00:00"
Description = ""
Categories = ["programming"]
Tags = ["java"]
Type = "article"
Draft = true

+++

Notes on the Java programming language.

# Java

## Tools

The *javac* compiler turns _.java_ source files into _.class_ files.

The *jar* tool works with _.jar_ files, which contain _.class_ files.

The *jarsigner* tool is for digitally signing JAR files.

## Language Basics

Every application must have a *main()* method as an entry point.

If a package is marked as *sealed*, then all of the classes must be in the same JAR file.

### Exceptions

The exceptions that a method can throw are part of the public API.

A checked exception is an error that can reasonably be excepted to occur in the application. An unchecked exception is an error that the application cannot reasonably recover from. 

Exceptions are instances of *Error* or *RuntimeError* classes, or subclasses of these. Both *Error* and *RuntimeError* are subclasses of *Throwable*.

Nulls cause a NullPointerException, which is a subclass of RuntimeError.

Code that might throw certain exceptions must either be:

1. Enclosed in a _try_ statement with a handler for that kind of exception
2. In a method that specifies that it can throw the exception

This applies to *checked exceptions*. It does not apply to *unchecked exceptions*.

Use *try-with-resources* for things like I/O.

You can have a *finally* statement without an *except* statement.
