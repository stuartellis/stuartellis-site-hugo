+++
Title = "Notes on the Java Programming Language"
Slug = "java-language"
Date = "2019-05-27T15:46:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["java"]
Type = "article"
Toc = true
Draft = true

+++

Notes on the Java programming language.

<!--more-->

# Overview

These are notes on the Java language.

# Setting Up a Development System

Install a JDK, and [Apache Maven](https://maven.apache.org/) for managing builds and dependencies. Maven is a Java tool, so the same package will run on any operating system that has a JDK installed.

[SDKMAN](https://sdkman.io/) enables you to maintain multiple versions of Java products on the same system.

To manually install a copy of the JDK:

1. Download the LTS version of the JDK from AdoptOpenJDK
2. Unzip the download
3. Copy the JDK directory to /usr/local/lib
4. Edit shell profile to add a JAVA_HOME environment variable set to /usr/local/lib/<JDK_DIRECTORY>
5. Add /usr/local/lib/<JDK_DIRECTORY/>/Contents/Home/bin to your PATH environment variable

To manually install a copy of Apache Maven:

1. Download the latest version of Maven
2. Unzip the download
3. Copy the Maven directory to /usr/local/lib
4. Add /usr/local/lib/<MAVEN_DIRECTORY> to your PATH environment variable

# Distinctive Language Features

Java follows the conventions of C-like languages, so much of the syntax will be obvious to a developer who has worked with any of these languages, such as JavaScript.

Java always passes arguments by value.

Java supports method overloading, where the same method name can be used with multiple signatures. You should avoid using theis feature, as it can confuses other developers.

Modern Java applications usually use dependency injection. For this reason, avoid static methods.

Fields can be marked as _transient_ if they should not included when the object is serialized.

## Application Entry Point

Every application must have a _main()_ method as an entry point. A _main()_ method must be public.

## The Keyword "Final"

Variables that are declared as _final_ can only have a value assigned once within the scope that they belong to, and are not accessible outside of that scope. If the scope is a loop, then the final variable can be assigned a value once per iteration.

It is good practice to declare variables as _final_ unless you have a specific reason not to do so.

A _final_ class cannot be extended. A method that has been marked as _final_ cannot be overridden in an extending class.

By convention, the name of a final variable should be in uppercase.

## Constructors

A _constructor_ is a method in the class that has the same name as the class itself. Constructors must have no return value.

The special behavior of constructors is that they work on objects whilst the object is being initialized.

Static constructors run only once, when a class is first loaded.

## Packages

A package is a namespace for classes. Packages are heirarchical, with a path of elements separated by the period (full-stop) character. The full name of a class includes the package that it belongs to.

Always specify a package for your classes. If you do not specify a package, the class will be assigned to the default package.

If a package is marked as _sealed_, then all of the classes must be in the same JAR file.

## Modules

Modules encapsulate sets of packages. Packages in a module are only available to code outside of the module if the definition of the module specifies that they should be exposed.

The Java run-time in JDK 9 and above can use modules instead of a classpath.

## Exceptions

The exceptions that a method can throw are part of the public API.

A checked exception is an error that can reasonably be expected to occur in the application. An unchecked exception is an error that the application cannot reasonably recover from.

Exceptions are instances of _Error_ or _RuntimeError_ classes, or subclasses of these. Both _Error_ and _RuntimeError_ are subclasses of _Throwable_.

Nulls cause a NullPointerException, which is a subclass of RuntimeError.

Code that might throw certain exceptions must either be:

1. Enclosed in a _try_ statement with a handler for that kind of exception
2. In a method that specifies that it can throw the exception

This applies to _checked exceptions_. It does not apply to _unchecked exceptions_.

Use _try-with-resources_ for things like I/O.

You can have a _finally_ statement without an _except_ statement.

## JavaBeans

JavaBeans are classes that encapsulate many objects into a single object (the bean). To be a valid bean, the class must be:

- Serializable
- Have a default public constructor that takes no arguments
- Allow access to properties using getter and setter methods which follow a standard naming convention

The [JavaBeans Specification](https://www.oracle.com/technetwork/java/javase/documentation/spec-136004.html) was designed to enable code reuse, by setting out standards for reusable classes.

Since the properties of a bean are accessible, beans are inherently mutable.

# Coding Style

[Google document their Java style](https://google.github.io/styleguide/javaguide.html)
