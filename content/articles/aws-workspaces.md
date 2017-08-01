+++
Title = "Notes on AWS WorkSpaces"
Slug = "aws-workspaces"
Date = "2017-08-01T18:20:00+01:00"
Description = "Notes on AWS WorkSpaces"
Categories = ["administration", "cloud"]
Tags = ["administration", "aws", "cloud", "windows"]
Type = "article"
Draft = true

+++


This is a set of notes for setting up AWS WorkSpaces, a service for running one
or more Windows desktops on the AWS cloud.

<!--more-->

# Technical Details #

Each workspace uses a copy of a Windows Server operating system. This means that
you cannot use applications that specifically require a Windows desktop
operating system. For example, Microsoft Edge is not available in a workspace.

All workspaces automatically use SSD storage. The capacity of a workspace is
determined by the bundle.

AWS WorkSpaces uses the proprietary
[PCoIP](http://www.teradici.com/pcoip-technology) protocol, which is developed
by [Teradici](http://www.teradici.com/). You connect to a
workspace with either a AWS WorkSpaces client application, or another system
that uses PCoIP, such as a thin client unit.

# Networking and Directories #

A directory requires a VPC with at least 2 subnets. You can have multiple directories on the same VPC.

Each workspace is tied to one user account in one directory. A workspace will exist in one subnet.

Remember that you cannot expand a VPC. If you destroy a VPC you will lose all of the directories,  workspaces and images.

# Creating a Template Desktop #

At the time of writing, you cannot create an image from a workspace that has encrypted drives.

An image can be attached to multiple bundles.

You cannot delete a bundle with active workspaces.

Create new images frequently.

Keep a log of your changes!

Use Group Policy to manage settings. AWS provides a [policy template](http://docs.aws.amazon.com/workspaces/latest/adminguide/group_policy.html)
for settings that are specific to WorkSpaces.

# Request a New Service Limit #

AWS limit your account to 1 workspace, until you request a larger limit.

# Limitations #

At the time of writing, Windows 10 workspaces do not support Web access.

# Resources #

* [Administration guide for AWS WorkSpaces](http://docs.aws.amazon.com/workspaces/latest/adminguide/amazon-workspaces.html)
* [Official list of resources for AWS WorkSpaces](https://aws.amazon.com/workspaces/resources/)

## Videos ##

* [Move your desktops to the cloud with Amazon WorkSpaces](https://youtu.be/r2Bh1hc-fak?list=PLufobnmLAUEygUaDDci7JT2JkGX7slDPA)
* [Best Practices from the Trenches: Deploy Amazon WorkSpaces Like a Pro](https://www.youtube.com/watch?v=9Q-ahnw2Lsc)
* [Managing WorkSpaces at Scale](https://www.youtube.com/watch?v=iAkkuuUJVUk)
* [How to connect to a workspace with RDP](https://www.youtube.com/watch?v=Of9NAz0ze6Q)
