+++
Title = "Getting Started with AWS WorkSpaces"
Slug = "aws-workspaces"
Date = "2018-07-20T21:35:00+01:00"
Description = "Notes on AWS WorkSpaces"
Categories = ["devops"]
Tags = ["devops", "windows"]
Type = "article"
Toc = true

+++

This is a set of notes for setting up [AWS WorkSpaces](https://aws.amazon.com/workspaces/), a service for running one or more desktops on the AWS cloud.

<!--more-->

# Technical Details #

Each Windows workspace uses a copy of a Windows Server operating system. This means that
you cannot use applications that specifically require a Windows desktop
operating system. For example, Microsoft Edge is not available in a workspace.

All workspaces automatically use SSD storage. The capacity of a workspace is
determined by the bundle.

AWS WorkSpaces uses the proprietary
[PCoIP](http://www.teradici.com/pcoip-technology) protocol, which is developed
by [Teradici](http://www.teradici.com/). You connect to a
workspace with either a AWS WorkSpaces client application, or another system
that uses PCoIP, such as a thin client unit.

# Before You Start, Request a New Service Limit #

AWS limit your account to just 1 workspace, until you request a larger limit.

# Networking and Directories #

### The VPC ###

A directory requires a VPC with at least 2 subnets. You can have multiple directories on the same VPC.

Each workspace is tied to one user account in one directory. A workspace will exist in one subnet.

Remember that you cannot expand a VPC. If you destroy a VPC you will lose all of the directories,  workspaces and images.

### Directories ###

For many scenarios, you need to use the full *AWS Directory Service for Active
Directory*. The Simple AD does not support features such as Group Policy and trust relationships between Active Directory domains.

Use [Group Policy](https://technet.microsoft.com/en-us/library/hh831791.aspx) to
manage settings. For example, you can [manage the Settings app with Group
Policy](https://docs.microsoft.com/en-us/windows/client-management/manage-settings-app-with-group-policy).
AWS provides a [policy
template](http://docs.aws.amazon.com/workspaces/latest/adminguide/group_policy.html)
for settings that are specific to WorkSpaces. The AWS documentation explains [how to install AD administration tools](http://docs.aws.amazon.com/workspaces/latest/adminguide/directory_administration.html).

# Managing Images and Bundles #

An image can be attached to multiple bundles. For safety, you cannot delete a bundle with active workspaces.

At the time of writing, you cannot create an image from a workspace that has encrypted drives. This means that the simplest way to create images for your bundles is to follow this process:

* Create a clean user account
* Launch a workspace for the new user, without disk encryption
* Update the workspace and add any management agents
* Create an image from this workspace
* Create a custom bundle that uses the new image
* Destroy the original workspace
* Ensure that you only create workspaces from your custom bundles

# Resources #

* [Administration guide for AWS WorkSpaces](http://docs.aws.amazon.com/workspaces/latest/adminguide/amazon-workspaces.html)
* [Official list of resources for AWS WorkSpaces](https://aws.amazon.com/workspaces/resources/)

### Videos ###

* [Move your desktops to the cloud with Amazon WorkSpaces](https://youtu.be/r2Bh1hc-fak?list=PLufobnmLAUEygUaDDci7JT2JkGX7slDPA)
* [Best Practices from the Trenches: Deploy Amazon WorkSpaces Like a Pro](https://www.youtube.com/watch?v=9Q-ahnw2Lsc)
* [Managing WorkSpaces at Scale](https://www.youtube.com/watch?v=iAkkuuUJVUk)
* [Using Microsoft Active Directory across On-premises and Cloud Workloads](https://www.youtube.com/watch?v=fQf_GD39T2c)
* [How to connect to a workspace with RDP](https://www.youtube.com/watch?v=Of9NAz0ze6Q)
