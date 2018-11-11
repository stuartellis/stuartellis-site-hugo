+++
Title = "Notes on the Java Language"
Slug = "java-language"
Date = "2018-11-11T16:37:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["java"]
Type = "article"
Draft = false

+++

Notes on the Java programming language.

# Overview

These are notes on the Java language and platform. 

# The Java Virtual Machine

Each _Java Virtual Machine_ runs compiled binary Java _bytecode_. This bytecode is platform-independent.

The bytecode is enclosed in _.class_ files. _Java ARchive (JAR)_ files enable you to ship many class files in a single package.

The JVM does not find classes itself. Instead, _Java Class Loaders_ look for the appropriate class file when the class is first used. By default, a JVM will use three class loaders: the _boot class loader_ (for core libraries supplied with the JVM), the _extension class loader_ (for libraries in the extensions directory), and a _system class loader_ , which looks on the _classpath_, a list of directories and JARs. A classpath can specify any combination of directories, paths to individual JARs, and paths with wildcards to load multiple JARs. Web application servers use additional class loaders. The _boot class loader_ is written in platform-specific native code, and all other class loaders are written in Java.

_Agents_ are plugins for the JVM. For example, _JRebel_ is an agent that enables hot-code reloading.

## Packaging Java Code

Java compiled classes are packed into _Java ARchive (JAR)_ files. A JAR is a ZIP file archive that should contain a directory named _META-INF_, and inside that a file named _MANIFEST.MF_.

The Java runtime loads classes from JAR files. Java automatically reads JAR files in the directories that are specified by the CLASSPATH environment variable.

## Monitoring and Debugging

Java Virtual Machines accept connections from debuggers, which may either be on the same system, or connecting from a remote system. The OpenJDK includes _jdb_, a command-line debugger, and IDEs for Java include graphical debuggers.

## Standard Tools

OpenJDK packages include a JVM (such as HotSpot or OpenJ9), a standard library (the _Java Class Library_), and various tools, including:

- _javac_ compiler turns _.java_ source files into _.class_ files.
- _javap_ de-compiler reads the contents of class files.
- _jar_ tool works with _.jar_ files, which contain the compiled _.class_ files.
- _jarsigner_ tool is for digitally signing JAR files.
- _jdb_ is a command-line debugging client for the JVM
- _jshell_ command-line shell, which was introduced in Java 9.
- _jlink_ tool create image files that include both code modules and a Java run-time. This was introduced in Java 9.

## Java Implementations

Each implementation of Java includes a Java Virtual Machine (JVM), and a Java Developers Kit (JDK) which provides the tools and class libraries. Most JVMs are now distributed with versions of the OpenJDK.

- [AdoptOpenJDK](https://adoptopenjdk.net/) - Pre-built versions of the OpenJDK with HotSpot or OpenJ9 Java Virtual Machines
- [OpenJ9](https://www.eclipse.org/openj9/) - Open Source JVM maintained by IBM and the Eclipse Foundation
- [JamaicaVM](https://www.aicas.com/cms/en/JamaicaVM) - Proprietary JVM for real-time systems
- [Zing](https://www.azul.com/products/zing/) - High-performance proprietary JVM maintained by Azul Systems
- [Zulu](https://www.azul.com/downloads/zulu/) - OpenJDK builds maintained by Azul Systems

Android uses the Java language, but Android software development kits (SDKs) are not fully compatible with the OpenJDK.

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

# Language Basics

Every application must have a _main()_ method as an entry point.

If a package is marked as _sealed_, then all of the classes must be in the same JAR file.

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

# Popular Software

## Build Tools

- [Gradle](https://gradle.org/)
- [Maven](https://maven.apache.org/)
- [Jib](https://github.com/GoogleContainerTools/jib) - Containerization

## Testing Tools

- [JUnit 5](https://junit.org/junit5/) - Unit testing
- [Hamcrest](http://hamcrest.org/JavaHamcrest/) - Matchers
- [Mockito](https://site.mockito.org/) - Mocking

## Code Quality

- [CheckStyle](https://checkstyle.org/) - Code style checks
- [JaCoCo](https://www.jacoco.org/jacoco/) - Test coverage
- [PMD](https://pmd.github.io/) - Code quality checks for Java and Salesforce.com
- [SonarQube](https://www.sonarqube.org/) - Code analysis framework
- [SpotBugs](https://spotbugs.github.io/) - Static analysis of code

## Frameworks

- [Dropwizard](https://www.dropwizard.io) - Framework for REST APIs
- [Ratpack](https://ratpack.io/) - Toolkit for lean, asynchronous HTTP services
- [Spring Batch](https://spring.io/projects/spring-batch) - Batch processing
- [Spring Boot](https://spring.io/projects/spring-boot) - Opinionated Web framework

## HTTP Servers

- [Apache Tomcat](https://tomcat.apache.org/) - De-facto standard Web server for Java
- [Eclipse Jetty](https://www.eclipse.org/jetty/) - Often embedded in applications

## Libraries

- [Google Guice](https://github.com/google/guice) - Dependency injection framework
- [Hibernate](http://hibernate.org/) - Database toolkit and ORM
- [Hystrix](https://github.com/Netflix/Hystrix) - Fault tolerance
- [Micrometer](http://micrometer.io/) - Metrics collection agent library
- [OpenPDF](https://github.com/LibrePDF/OpenPDF)
- [Thymeleaf](https://www.thymeleaf.org/) - Templating

# Online Resources

- [Official Java Tutorials](https://docs.oracle.com/javase/tutorial/)
- [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)
- [Maven Package Search](https://search.maven.org/)
- [MVP Java YouTube channel](https://www.youtube.com/channel/UCrgOYeQyZ_V62XDYKCfh8TQ)
- [Java with Visual Studio Code](https://code.visualstudio.com/docs/java/java-tutorial)
- [DZone Java Zone](https://dzone.com/java-jdk-development-tutorials-tools-news) - News and tips
