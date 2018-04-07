+++
Title = "Managing Server Backups with Borg"
Slug = "borg-backups"
Date = "2018-04-07T09:59:00+01:00"
Description = "Managing server backups with Borg"
Categories = ["administration"]
Tags = ["administration"]
Type = "article"
Draft = true

+++

[Borg](https://borgbackup.readthedocs.io) provides a convenient and well-designed command-line utility for backing up files and directories. This article shows how to use Borg with other tools to create a data backup service.

<!--more-->

# Overview

Versions of Borg for Linux and macOS are provided as a single file. You do not need to install anything else to use it.

Since Borg only handles the back up and restore of files, we will need to use other tools to handle database exports, scheduling, logging, and notifications.

# Installing Borg

You can install the current version of Borg on any Linux or macOS system by downloading the correct release from GitHub.

FIXME
