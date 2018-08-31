+++
Title = "Notes on the Java Language"
Slug = "java-language"
Date = "2018-08-31T21:10:00+01:00"
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

# JVM Implementations

* [AdoptOpenJDK](https://adoptopenjdk.net/) - Pre-built versions of the OpenJDK

# Build Tools

* [Gradle](https://gradle.org/)
* [Maven](https://maven.apache.org/)
* [Jib](https://github.com/GoogleContainerTools/jib) - Containerization

# Testing Tools

* [JUnit 5](https://junit.org/junit5/) - Unit testing
* [Hamcrest](http://hamcrest.org/JavaHamcrest/) - Matchers

# Frameworks 

* [Dropwizard](https://www.dropwizard.io) - Framework for REST APIs
* [Ratpack](https://ratpack.io/) - Toolkit for lean, asynchronous HTTP services 
* [Spring Batch](https://spring.io/projects/spring-batch) - Batch processing
* [Spring Boot](https://spring.io/projects/spring-boot) - Opinionated Web framework

# HTTP Servers

* [Apache Tomcat](https://tomcat.apache.org/) - De-facto standard Web server for Java
* [Eclipse Jetty](https://www.eclipse.org/jetty/) - Often embedded in applications

# Libraries

* [Google Guice](https://github.com/google/guice) - Dependency injection framework 
* [Hibernate](http://hibernate.org/) - Database toolkit and ORM
* [Hystrix](https://github.com/Netflix/Hystrix) - Fault tolerance
* [Thymeleaf](https://www.thymeleaf.org/) - Templating

# Resources

* [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)
* [Maven Package Search](https://search.maven.org/)
* [MVP Java YouTube channel](https://www.youtube.com/channel/UCrgOYeQyZ_V62XDYKCfh8TQ)
