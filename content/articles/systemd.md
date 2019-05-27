+++
Title = "Notes on systemd"
Slug = "systemd"
Date = "2016-09-01T17:20:00+01:00"
Description = "Notes on systemd"
Categories = ["administration"]
Tags = ["administration", "systemd"]
Type = "article"
Toc = true
Draft = true

+++


The *systemd* project provides an integrated set of tools and services that form the basis of a Linux-based operating system. Originally, *systemd* only offered a service management framework, but current releases of the suite include job scheduling, console management, a network name resolver, a logging service, and a utility for using containers.

<!--more-->

# Overview #

The networking services in the systemd suite are relatively new, and not fully used by most Linux distributions yet. For this reason, they are not covered in this article.

## Service Management with systemd ##

## Scheduled Jobs with systemd ##

## Logging with The systemd Journal ##

## Simple Containers with systemd-nspawn ##

The *systemd-nspawn* utility provides a convenient interface for running containers, using the underlying facilities that are built into systemd and modern Linux kernels. You can use it as either a modern replacement for *chroot* to run individual processes in a sandbox, or to have complete alternate Linux-based operating systems within managed containers.

## Resources ##

* [Fedora Magazine series on systemd](https://fedoramagazine.org/what-is-an-init-system/)
