+++
Title = "Using Apache Maven"
Slug = "apache-maven"
Date = "2019-05-27T16:49:00+01:00"
Description = ""
Categories = ["automation", "programming"]
Tags = ["automation", "java", "maven"]
Type = "article"
Toc = true

+++

Notes on using the [Maven](https://maven.apache.org/) tool for Java projects.

<!--more-->

## Concepts

Maven uses a _Project Object Model_ (POM) to describe the project that it manages. This is stored as an XML file in the root directory of the project. The POM file will have the name _pom.xml_.

Maven supports project templates, known as _archetypes_. This means that you can create a POM file for your project from an existing template.

### Phases, Lifecycles and Goals

A _phase_ is a step in a _lifecycle_, which is an ordered sequence of phases. If you specify a phase with the _mvn_ command, Maven will execute every phase in the sequence up to and including the one defined.

The _default_ lifecycle has these phases:

- validate: validate the project is correct and all necessary information is available
- compile: compile the source code of the project
- test: test the compiled source code using a suitable unit testing framework. These tests should not require the code be packaged or deployed
- package: take the compiled code and package it in its distributable format, such as a JAR.
- integration-test: process and deploy the package if necessary into an environment where integration tests can be run
- verify: run any checks to verify the package is valid and meets quality criteria
- install: install the package into the local repository, for use as a dependency in other projects locally
- deploy: done in an integration or release environment, copies the final package to the remote repository for sharing with other developers and projects.

There are two other standard Maven lifecycles. These are:

- _clean_: cleans up artifacts created by prior builds
- _site_: generates site documentation for this project

_Goals_ are tasks or targets. Each goal is associated with one or more phases of a lifecycle. Maven _plugins_ are collections of goals.

### Profiles

A build _profile_ is a set of configuration values, which can be used to set or override default values.

### Repositories

Maven downloads dependencies from the _central repository_, and from your _remote repository_. The central repository is the Maven public repository. Use the [Maven Package Search](https://search.maven.org/) page to see what is available. Downloads are cached in a _local repository_ directory. This means that Maven looks for dependencies in the local repository first, then the central repository, and then the remote repository.

You may also specify _external dependencies_ in the POM. These are dependencies that are not available from any repository. The files for external dependencies should be in the _lib_ directory of your project.

_SNAPSHOT_ is a special version that indicates a current development copy. Maven checks for a new SNAPSHOT version in a remote repository for every build.

### Documentation Generation

Maven includes [Doxia](https://maven.apache.org/doxia/index.html), a framework for generating documentation from a set of plain-text files. It supports various formats, including Markdown. Doxia is mainly for maintaining project Websites, rather than API documentation from JavaDoc annotations in the source code.

## Setup

Maven is a Java tool, so the same package will run on any operating system that has a JDK installed.

1. Download the latest version of Maven
2. Unzip the download
3. Copy the Maven directory to /usr/local/lib
4. Add /usr/local/lib/<MAVEN_DIRECTORY> to your PATH environment variable

## Project Structure

Maven assumes a specific project structure:

- Source code: _src/main/java/_
- Resources: _src/main/resources/_
- Tests: _src/test/_
- Compiled byte code: _target/_
- Distributable JAR: _target/classes/_

## Project Object Model (POM)

Each POM file must have these properties defined:

- _modelVersion_ - The version of the POM that the file uses
- _groupId_ - The identifier for the team or group that maintains the project
- _artifactId_ - The identifier for the project
- _version_ - The version of the project

Maven 2 and Maven 3 both use _modelVersion_ 4.0, which means that every POM file should use this version.

Maven always uses an _effective POM_. This is a combination of the settings from:

- The project pom.xml
- All parent POMs
- The Super POM
- Any user-defined settings
- The active profiles

To see the effective POM for a project, run this command:

    mvn help:effective-pom

Each POM uses the _Super POM_ that is provided by Maven, unless you declare a different Super POM.

## Maven Plugins

- [Assembly](https://maven.apache.org/plugins/maven-assembly-plugin/) - Packs multiple outputs into a single compressed archive, such as a JAR, WAR, or ZIP file
- [FMT](https://github.com/coveo/fmt-maven-plugin) - Reformats Java code to [Google Java Style](https://google.github.io/styleguide/javaguide.html)
- [Jib](https://github.com/GoogleContainerTools/jib) - Container builder

## Online Resources

- [Maven tutorial for beginners](https://www.tutorialspoint.com/maven), by Tutorials Point
- [Official Maven project documentation](https://maven.apache.org/)
- [Maven By Example](https://books.sonatype.com/mvnex-book/reference/index.html), by Sonatype
- [Maven: The Complete Reference](https://books.sonatype.com/mvnref-book/reference/index.html), by Sonatype
