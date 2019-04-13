+++
Title = "Using Apache Maven"
Slug = "apache-maven"
Date = "2019-04-13T07:53:00"
Description = ""
Categories = ["programming"]
Tags = ["java"]
Type = "article"

+++

Notes on the [Maven](https://maven.apache.org/) tool for Java projects.

<!--more-->

# Concepts

Maven uses a _Project Object Model_ (POM) to describe the project that it manages. This is stored as an XML file in the root directory of the project. The POM file will have the name _pom.xml_.

Maven supports project templates, known as _archetypes_. This means that you can create a POM file for your project from an existing template.

## Phases, Lifecycles and Goals

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

## Profiles

A build _profile_ is a set of configuration values, which can be used to set or override default values.

## Repositories

Maven downloads dependencies from the _central repository_, and from your _remote repository_. The central repository is the Maven public repository. Use the [Maven Package Search](https://search.maven.org/) page to see what is available. Downloads are cached in a _local repository_ directory. This means that Maven looks for dependencies in the local repository first, then the central repository, and then the remote repository.

You may also specify _external dependencies_ in the POM. These are dependencies that are not available from any repository. The files for external dependencies should be in the _lib_ directory of your project.

_SNAPSHOT_ is a special version that indicates a current development copy. Maven checks for a new SNAPSHOT version in a remote repository for every build.

## Documentation Generation

Maven includes [Doxia](https://maven.apache.org/doxia/index.html), a framework for generating documentation from a set of plain-text files. It supports various formats, including Markdown. Doxia is mainly for maintaining project Websites, rather than API documentation from JavaDoc annotations in the source code.

# Setup

Maven is a Java tool, so the same package will run on any operating system that has a JDK installed.

1. Download the latest version of Maven
2. Unzip the download
3. Copy the Maven directory to /usr/local/lib
4. Add /usr/local/lib/<MAVEN_DIRECTORY> to your PATH environment variable

# Project Structure

Maven assumes a specific project structure:

- Source code: _src/main/java/_
- Resources: _src/main/resources/_
- Tests: _src/test/_
- Compiled byte code: _target/_
- Distributable JAR: _target/classes/_

# Online Resources

- [Maven tutorial for beginners](https://www.tutorialspoint.com/maven)
- [Maven project documentation](https://maven.apache.org/)
