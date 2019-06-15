+++
Title = "An Overview of the Java Platform"
Slug = "java-platform"
Date = "2019-06-15T12:07:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["java"]
Type = "article"
Toc = true

+++

The modern Java platform, with OpenJDK 11 and above.

<!--more-->

## Specifications

The [Java Community Process](https://www.jcp.org) defines standards for these areas:

- The Java Language
- The Java Virtual Machine
- Java Platform

Each Java Specification Request (JSR) includes a Technology Compatibility Kit (TCK) that enables developers to test that an implementation meets the specifications of the JSR.

Similarly, the [Java Compatibility Kit](https://openjdk.java.net/groups/conformance/JckAccess/) (JCK) tests that Java Platform implementations are compatible with standards.

## The Java Virtual Machine

Each _Java Virtual Machine_ (JVM) runs compiled binary Java _bytecode_. This bytecode is platform-independent. Bytecode is enclosed in _.class_ files.

### Components of the JVM

- Compiler - Interprets bytecode, and automatically applies JIT compilation (using the C1 fast compiler, and the C2 optimized compiler)
- Runtime - Loads class files into memory, concurrency, interacts with the operating system (threads, memory allocation, sockets), works with external monitoring, handles logging
- Garbage Collector - Memory management

### Garbage Collector

[G1](https://www.oracle.com/technetwork/tutorials/tutorials-1876574.html) is now the default garbage collector for OpenJDK 10 and above. It implements a parallel mark-sweep-compact algorithm. The default pause time goal for G1 is 200 milliseconds, but this is adjustable.

### Java ARchives (JARs)

_Java ARchive (JAR)_ files enable you to ship many class files inside a single compressed file. A JAR can also contain other types of files, such as the HTML, CSS and JavaScript for a Web application.

A JAR is a ZIP file archive that should contain a directory named _META-INF_, and inside that a manifest file, which will be named _MANIFEST.MF_. The manifest file provides data about the files that are contained in the JAR.

### Java Class Loaders

The JVM does not find classes itself. Instead, _Java Class Loaders_ look for the appropriate class file when the class is first used. By default, a JVM will use three class loaders: the _boot class loader_ (for core libraries that are supplied with the JVM), the _extension class loader_ (for libraries in the extensions directory), and a _system class loader_, which looks on the _classpath_, a list of directories and JARs. A classpath can specify any combination of directories, paths to individual JARs, and paths with wildcards to load multiple JARs. Web application servers use additional class loaders. The _boot class loader_ is written in platform-specific native code, and all other class loaders are written in Java.

### The Classpath

The system class loader looks for class files in the locations that are specified by the classpath. Each location can either be a directory, the path to a specific JAR file, or a directory with a wildcard. In the last case, the loader uses all of the JAR files in the specified directory.

The classpath is either defined by a CLASSPATH environment variable, or set by a command-line option to the _java_ run-time, or specified in a manifest file. It is a colon-separatedlist on UNIX-like systems, a semi-colon separated list on Windows, and space separated list in manifest files. This example sets the classpath at the command-line on a UNIX-like system:

    java -classpath ".:../java-classes/*:/usr/local/lib/java-classes/*"

The default value of classpath is _._ (the period character), which means that it checks the current directory.

### Properties

Java uses the concept of [Properties](https://docs.oracle.com/javase/tutorial/essential/environment/properties.html) objects to hold configuration information. A Properties object is an instance of the _java.util.Properties_ class. Each Properties object can hold multiple properties. A _property_ is a key-value pair that is held within a Properties object.

Properties objects are stored as _.properties_ files, usually alongside the the _.class_ files for the application. Developers write code in the application to load properties objects from the appropriate properties files when the application starts.

The Java platform itself uses a Properties object for global configuration. This object provides [system properties](https://docs.oracle.com/javase/tutorial/essential/environment/sysprop.html). The system properties are accessed through methods on the _System_ class.

### Agents

_Agents_ are plugins for the JVM. For example, _JRebel_ is an agent that enables hot-code reloading.

## Java Distributions

Each distribution of Java includes a Java Virtual Machine (JVM), and a Java Developers Kit (JDK), which provides the tools and class libraries. Compatibility tests verify whether a distribution complies with Java standards.

Most distributions use the [HotSpot](https://openjdk.java.net/groups/hotspot/) JVM. For example, both Amazon Corretto and Azul Zulu include versions of the HotSpot JVM. [OpenJ9](https://www.eclipse.org/openj9/) is an alternative Open Source JVM that is maintained by IBM and the Eclipse Foundation.

Almost every Java distribution now uses versions of the OpenJDK tools and libraries.

> Android uses the Java language, but Android software development kits (SDKs) are not fully compatible with Java standards.

### Free, Open Source Distributions

- [AdoptOpenJDK](https://adoptopenjdk.net/) - Provides free versions of the OpenJDK with either HotSpot or OpenJ9 Java Virtual Machines. [IBM offers commercial support contracts](https://www-01.ibm.com/support/docview.wss?uid=ibm10741649)
- [Amazon Corretto](https://aws.amazon.com/corretto/) - OpenJDK with HotSpot Java Virtual Machine, supported by AWS
- [Eclipse OpenJ9](https://www.eclipse.org/openj9/) - OpenJDK with the OpenJ9 JVM
- [Red Hat OpenJDK](https://developers.redhat.com/products/openjdk/overview/) - OpenJDK with HotSpot Java Virtual Machine, supported by Red Hat, Linux and Windows only
- [SapMachine](https://sap.github.io/SapMachine/) - OpenJDK and JVM, provided by SAP for their customers
- [Zulu](https://www.azul.com/downloads/zulu/) - OpenJDK with the Zulu JVM, maintained by Azul Systems

### Proprietary Distributions

- [IBM Java SDK](https://www.ibm.com/developerworks/java/jdk/)
- [JamaicaVM](https://www.aicas.com/cms/en/JamaicaVM) - A proprietary Java implementation for real-time systems.
- [Oracle JDK](https://www.oracle.com/technetwork/java/javase/downloads/index.html) - Proprietary builds of HotSpot and OpenJDK, supported by Oracle
- [Pivotal Spring Runtime](https://pivotal.io/pivotal-spring-runtime) - A distribution of the OpenJDK that is supported by Pivotal
- [Zing](https://www.azul.com/products/zing/) - High-performance proprietary Java implementation maintained by Azul Systems

## Standard Tools

OpenJDK packages include a JVM (such as HotSpot or OpenJ9), a standard library (the _Java Class Library_), and various tools, including:

- _javac_ compiler turns _.java_ source files into _.class_ files.
- _javap_ de-compiler reads the contents of class files.
- _jar_ tool works with _.jar_ files, which contain the compiled _.class_ files.
- _jarsigner_ tool is for digitally signing JAR files.
- _jdb_ is a command-line debugging client for the JVM
- _jshell_ command-line shell, which was introduced in Java 9.
- _jlink_ tool create image files that include both code modules and a Java run-time. This was introduced in Java 9.

JDK 9 introduced _jaotc_, an experimental alternative compiler to _javac_ that produces Ahead Of Time Compiled code, rather than generic bytecode. This is based on [Graal](https://openjdk.java.net/projects/graal/).

## Monitoring and Debugging

### Debugging

Java Virtual Machines accept connections from debuggers. The debugger may either be on the same system, or connecting from a remote system. The OpenJDK tself includes _jdb_, a command-line debugger. Each IDE for Java includes a graphical debugger.

### Monitoring

[Java Flight Recorder and Java Mission Control](https://www.oracle.com/technetwork/java/javaseproducts/mission-control/java-mission-control-1998576.html) provide a data collection and profiling system for the OracleJDK.

The OpenJDK also includes these tools for monitoring and diagnostics:

- _jconsole_ - Graphical utility for monitoring and managing Java applications
- _jinfo_ - Provides configuration information for a specified Java process
- _jps_ - Java process viewer
- _jstat_ - Java statistics monitoring

### Performance Testing

The OpenJDK includes [JMH](https://openjdk.java.net/projects/code-tools/jmh/), the Java Micro-benchmark Harness.

## Popular Third-Party Software

### Development Tools

- [jEnv](https://www.jenv.be/) - Convenient switching between JDKs
- [Maven](https://maven.apache.org/) - The standard project management tool
- [Gradle](https://gradle.org/) - Powerful build system
- [Jib](https://github.com/GoogleContainerTools/jib) - Container builder
- [JBake](https://jbake.org/) - Static site generator
- [Swagger](https://swagger.io/tools/open-source/) - [OpenAPI](https://www.openapis.org/) code generation for clients and servers

### Testing Tools

- [AssertJ](https://joel-costigliola.github.io/assertj/) - Test assertions
- [JUnit 5](https://junit.org/junit5/) - Unit testing
- [Hamcrest](http://hamcrest.org/JavaHamcrest/) - Matchers
- [Mockito](https://site.mockito.org/) - Mocking

### Code Quality Tools

- [CheckStyle](https://checkstyle.org/) - Code style checks
- [Google Java Format](https://github.com/google/google-java-format) - Reformats Java code to [Google Java Style](https://google.github.io/styleguide/javaguide.html), can be automated with the [Maven plugin](https://github.com/coveo/fmt-maven-plugin)
- [JaCoCo](https://www.jacoco.org/jacoco/) - Test coverage
- [PMD](https://pmd.github.io/) - Code quality checks for Java and Salesforce.com
- [SonarQube](https://www.sonarqube.org/) - Code analysis framework
- [SpotBugs](https://spotbugs.github.io/) - Static analysis of code

### Application Frameworks

- [Dropwizard](https://www.dropwizard.io) - Framework for REST APIs
- [Ratpack](https://ratpack.io/) - Toolkit for lean, asynchronous HTTP services
- [Spring Batch](https://spring.io/projects/spring-batch) - Batch processing
- [Spring Boot](https://spring.io/projects/spring-boot) - Opinionated Web framework

### HTTP Servers

- [Apache Tomcat](https://tomcat.apache.org/) - De-facto standard Web applications server for Java
- [Eclipse Jetty](https://www.eclipse.org/jetty/) - Often embedded in applications
- [Undertow](http://undertow.io) - High performance, embeddable Web server

### Databases

- [Flyway](https://flywaydb.org/) - Schema management
- [H2](https://h2database.com) - SQL database in pure Java
- [Hibernate](http://hibernate.org/) - Most popular SQL database toolkit and ORM
- [Liquibase](http://www.liquibase.org) - Older schema management tool
- [MyBatis](http://www.mybatis.org) - Powerful SQL database framework

### Other Libraries

- [Ehcache](https://www.ehcache.org/) - In-memory caching
- [Google Guava](https://github.com/google/guava) - A set of utility libraries
- [Google Guice](https://github.com/google/guice) - Dependency injection framework
- [Jackson](https://github.com/FasterXML/jackson) - Libraries for JSON and other data formats
- [JavaPoet](https://github.com/square/javapoet) - Java code generation
- [jsoup](https://jsoup.org/) - HTML parser
- [Logback](https://logback.qos.ch/) - Logging
- [Micrometer](http://micrometer.io/) - Metrics collection agent library
- [OpenPDF](https://github.com/LibrePDF/OpenPDF)
- [Quartz](https://www.quartz-scheduler.org/) - Job scheduler
- [resilience4j](https://github.com/resilience4j/resilience4j) - Fault tolerance
- [Thymeleaf](https://www.thymeleaf.org/) - Templating

## Online Resources

### Finding Packages

- [Maven Package Search](https://search.maven.org/)
- [Awesome Java](https://github.com/akullpp/awesome-java) - A curated list of frameworks, libraries and software for Java

### Tutorials

- [Official Java Tutorials](https://docs.oracle.com/javase/tutorial/)
- [Google Java Style Guide](https://google.github.io/styleguide/javaguide.html)
- [Java with Visual Studio Code](https://code.visualstudio.com/docs/java/java-tutorial)

### News

- [DZone Java Zone](https://dzone.com/java-jdk-development-tutorials-tools-news) - News and tips
- [Baeldung](https://www.baeldung.com/) - Articles and a weekly newsletter on Java and Spring topics

### Videos

- [Official Java YouTube channel](https://www.youtube.com/user/java)
- [Spring YouTube channel](https://www.youtube.com/user/SpringSourceDev) - Official YouTube channel for Spring
- [Devoxx YouTube channel](https://www.youtube.com/channel/UCCBVCTuk6uJrN3iFV_3vurg) - Talks from the largest independent annual Java conference
- [Virtual Java User Group](https://www.youtube.com/user/virtualJUG) - YouTube channel with a variety of talks
- [MVP Java YouTube channel](https://www.youtube.com/channel/UCrgOYeQyZ_V62XDYKCfh8TQ)
