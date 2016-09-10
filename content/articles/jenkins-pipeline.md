+++
Title = "Using Jenkins CI Pipeline"
Slug = "jenkins-pipeline"
Date = "2016-09-10T12:00:00+01:00"
Description = "Using the Pipeline feature of Jenkins CI"
Categories = ["administration"]
Tags = ["administration", "jenkins"]
Type = "article"
Draft = true

+++


The [Pipeline Plugin](https://jenkins.io/solutions/pipeline/) for the  [Jenkins](https://jenkins.io) Continuous Integration system enables you to define job  configurations in code, and store them as files within your source code repositories, rather than entering them directly into the Web interface. Version 2 of Jenkins includes Pipeline as standard, and this is now the recommended way to set up your Jenkins jobs.

<!--more-->

# Overview #

Jenkins uses the [Groovy](http://www.groovy-lang.org/) scripting language for defining jobs with Pipeline, but you can write configurations without learning the details of Groovy. In most cases, you store the definition in a file (called *Jenkinsfile* by default), and add this to the version control repository for your project. This means that each job only need a minimal configuration on the Jenkins server, which specifies the Jenkinsfile.

You can write Pipeline configurations directly into the Web interface of Jenkins, but should only use this feature for development and testing.

Your job code can call functions from any Jenkins plugin that supports Pipeline. If you work with Bitbucket, GitHub or Docker, use the specific plugins for Pipeline support. Check the [compatibility list](https://github.com/jenkinsci/pipeline-plugin/blob/master/COMPATIBILITY.md) for the status of other plugins. You do have to ensure that all of the plugins that you reference are installed on every Jenkins instance that you use for that job.

If you maintain Jenkins 1 systems you can install the Pipeline Plugin through the usual process. It is automatically included in all new installations of Jenkins 2.

# Learning Pipeline #

The [tutorial for Pipeline](https://jenkins.io/doc/pipeline/) explains how to install and use it. Rather than repeat the tutorial, I will assume that you have read it.
