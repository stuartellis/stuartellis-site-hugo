+++
Title = "Notes on the Java Language"
Slug = "java-language"
Date = "2018-09-29T12:36:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["java"]
Type = "article"
Draft = true

+++

Notes on the Java programming language.

# Java

## Tools

The _javac_ compiler turns _.java_ source files into _.class_ files.

The _jar_ tool works with _.jar_ files, which contain _.class_ files.

The _jarsigner_ tool is for digitally signing JAR files.

The _jshell_ command-line shell was introduced in Java 9.

## Language Basics

Every application must have a _main()_ method as an entry point.

If a package is marked as _sealed_, then all of the classes must be in the same JAR file.

### Exceptions

The exceptions that a method can throw are part of the public API.

A checked exception is an error that can reasonably be excepted to occur in the application. An unchecked exception is an error that the application cannot reasonably recover from.

Exceptions are instances of _Error_ or _RuntimeError_ classes, or subclasses of these. Both _Error_ and _RuntimeError_ are subclasses of _Throwable_.

Nulls cause a NullPointerException, which is a subclass of RuntimeError.

Code that might throw certain exceptions must either be:

1. Enclosed in a _try_ statement with a handler for that kind of exception
2. In a method that specifies that it can throw the exception

This applies to _checked exceptions_. It does not apply to _unchecked exceptions_.

Use _try-with-resources_ for things like I/O.

You can have a _finally_ statement without an _except_ statement.

# JVM Implementations

- [AdoptOpenJDK](https://adoptopenjdk.net/) - Pre-built versions of the OpenJDK

# Build Tools

- [Gradle](https://gradle.org/)
- [Maven](https://maven.apache.org/)
- [Jib](https://github.com/GoogleContainerTools/jib) - Containerization

# Testing Tools

- [JUnit 5](https://junit.org/junit5/) - Unit testing
- [Hamcrest](http://hamcrest.org/JavaHamcrest/) - Matchers

# Frameworks

- [Dropwizard](https://www.dropwizard.io) - Framework for REST APIs
- [Ratpack](https://ratpack.io/) - Toolkit for lean, asynchronous HTTP services
- [Spring Batch](https://spring.io/projects/spring-batch) - Batch processing
- [Spring Boot](https://spring.io/projects/spring-boot) - Opinionated Web framework

# HTTP Servers

- [Apache Tomcat](https://tomcat.apache.org/) - De-facto standard Web server for Java
- [Eclipse Jetty](https://www.eclipse.org/jetty/) - Often embedded in applications

# Libraries

- [Google Guice](https://github.com/google/guice) - Dependency injection framework
- [Hibernate](http://hibernate.org/) - Database toolkit and ORM
  [Hystrix](https://github.com/Netflix/Hystrix) - Fault tolerance
- [OpenPDF](https://github.com/LibrePDF/OpenPDF)
- [Thymeleaf](https://www.thymeleaf.org/) - Templating

# Resources

- [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)
- [Maven Package Search](https://search.maven.org/)
- [MVP Java YouTube channel](https://www.youtube.com/channel/UCrgOYeQyZ_V62XDYKCfh8TQ)
