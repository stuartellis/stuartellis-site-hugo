+++
Title = "Using Apache Maven"
Slug = "java-language"
Date = "2018-11-08T08:10:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["java"]
Type = "article"
Draft = true

+++

Notes on the Maven tool.

# Maven

## Concepts

Maven uses a *Project Object Model* (POM) to describe the project that it manages. This is stored as an XML file in the root directory of the project.

Maven supports project templates, known as *archetypes*. This means that you can create a POM file for your project from an existing template.

*goals* are tasks.

A phase is a step in the build lifecycle, which is an ordered sequence of phases. When a phase is given, Maven will execute every phase in the sequence up to and including the one defined. 

The *default* lifecycle has these phases:

- validate: validate the project is correct and all necessary information is available
- compile: compile the source code of the project
- test: test the compiled source code using a suitable unit testing framework. These tests should not require the code be packaged or deployed
- package: take the compiled code and package it in its distributable format, such as a JAR.
- integration-test: process and deploy the package if necessary into an environment where integration tests can be run
- verify: run any checks to verify the package is valid and meets quality criteria
- install: install the package into the local repository, for use as a dependency in other projects locally
- deploy: done in an integration or release environment, copies the final package to the remote repository for sharing with other developers and projects.

There are two other standard Maven lifecycles. These are:

- clean: cleans up artifacts created by prior builds
- site: generates site documentation for this project

Maven plugins are collections of goals.

Maven downloads dependencies from a *remote repository*. By default, it uses the Maven public repository. Use the [Maven Package Search](https://search.maven.org/) page to see what is available. Downloads are cached in a *local repository* directory.

## Setup

Install [Maven](https://maven.apache.org/) for managing builds and dependencies. This is a Java tool, so the same package will run on any operating system that has a JDK installed.

1. Download the latest version of Maven
2. Unzip the download
3. Copy the Maven directory to /usr/local/lib
4. Add /usr/local/lib/<MAVEN_DIRECTORY> to your PATH environment variable

## Online Resources

- https://www.tutorialspoint.com/maven

