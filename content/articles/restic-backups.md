+++
Title = "Backups with Restic"
Slug = "restic-backups"
Date = "2018-04-11T16:49:00+01:00"
Description = "Managing backups with Restic"
Categories = ["administration"]
Tags = ["administration"]
Type = "article"
Draft = true

+++

The [restic](https://restic.net/) utility provides a convenient and well-designed command-line tool for backing up files and directories. This article shows how to use restic with other utilities to create a data backup facility.

<!--more-->

# Overview

Restic creates and manages snapshots in a repository, which can be either a local directory, or on remote storage, such as AWS S3. The files in a restic repository are automatically encrypted with a passphrase. Once the repository has been initialized and a backup has been made, you can view and restore files with the command-line utility.

Versions of restic are provided as a single file. You do not need to install anything else to use it. Since restic only handles the back up and restoration of files, we will need to set up other tools to handle database exports, scheduling, logging, and notifications.

# Approach

The simplest way to orchestrate backups with restic is to write a script.

For this article, we will use AWS S3 to host the repository. The built-in support for AWS S3 enables restic to use an S3 bucket to store a repository. Multiple systems can back up to the same repository, but for security, you should use separate buckets for different sets of computers.

You can install restic with the package manager of your Linux distribution, or Homebrew on macOS. To ensure that we have the latest version of restic, we will download it directly from GitHub.

# Installing restic

You can install the current version of restic by downloading the correct release from GitHub. Once the file is downloaded, set the permissions to limit who can use it, and then give it the capabilities to access the whole system:

    curl -L https://github.com/restic/restic/releases/download/v0.8.3/restic_0.8.3_linux_amd64.bz2 | bunzip2 > restic
    chown root:$USER restic
    chmod 750 restic
    setcap cap_dac_read_search=+ep restic

# Setting Up the Remote Repository

First, create the S3 bucket. We need to do this first, because the current version of restic will check whether the specified bucket exists, and if it does not, restic will create the a new bucket with that name on AWS in the US East region.

# Running restic

Before you run restic, ensure that the hostname for the system is set correctly. Each restic snapshot includes the hostname of the source.

Run this command to set up the repository in the S3 bucket:

restic -r s3:s3.amazonaws.com/$RESTIC_REPOSITORY init

Example script:

~~~bash
#!/bin/sh

AWS_ACCESS_KEY_ID="XXX"
AWS_SECRET_ACCESS_KEY="XXX"
RESTIC_REPOSITORY=staging-stuartellis-org-backups-eu-west-1
RESTIC_PASSWORD_FILE=restic-password.txt

restic -r s3:s3.amazonaws.com/$RESTIC_REPOSITORY backup --exclude-file restic-exclusions.txt --password-file $RESTIC_PASSWORD_FILE --tag test1 /
~~~

To view the snapshots that are in the repository:

    restic -r s3:s3.amazonaws.com/$RESTIC_REPOSITORY --password-file $RESTIC_PASSWORD_FILE snapshots

You currently need to be careful to avoid [issue 549](https://github.com/restic/restic/issues/549).

# Resources

* [Fedora Magazine article: Use restic on Fedora for encrypted backups](https://fedoramagazine.org/use-restic-encrypted-backups/)
* [Official documentation: Setting up restic with Amazon S3](https://restic.readthedocs.io/en/stable/080_examples.html#setting-up-restic-with-amazon-s3) - Official restic documentation for using S3 storage
* [System Backups with restic](https://kula.tproa.net/lnt/computers/backups/restic-systems-backups/) - Blog series on using restic for centralized server backup, by Thomas A. Kula
* [GoTime episode on restic](https://changelog.com/gotime/48) - Audio of interview with Alexander Neumann, the developer of restic