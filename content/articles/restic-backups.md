+++
Title = "Backups with restic"
Slug = "restic-backups"
Date = "2018-08-31T06:50:00+01:00"
Description = "Managing backups with restic"
Categories = ["administration"]
Tags = ["administration"]
Type = "article"

+++

The [restic](https://restic.net/) utility provides a convenient and well-designed command-line tool for backing up files and directories. 

<!--more-->

# Overview

For efficiency and de-deplication, restic creates and manages snapshots, which are stored in a set of data files, known as a repository. The repository can be in a directory on the same computer as the source files, or on remote storage, such as AWS S3. The files in a restic repository are automatically encrypted with a passphrase. Once the repository has been initialised and a backup has been made, you can view and restore files with the command-line utility.

To use restic you need these things:

1. A copy of restic. The restic tool itself is a single executable file.
2. The address or location of the repository. This can be provided as an environment variable.
3. Any secret(s) that are needed for accessing the remote storage that holds the repository
4. The password for decrypting the repository. This can be provided as an environment variable or in a file.

Since restic only handles the back up and restoration of files, we will need to set up other tools to handle database exports, scheduling, logging, and notifications.

# Approach

For this article, we will use AWS S3 to host the repository. The built-in support for AWS S3 enables restic to use an S3 bucket to store a repository. Multiple systems can back up to the same repository, but for security, you should use separate buckets for different sets of computers.

You can install restic with the package manager of your Linux distribution, or Homebrew on macOS. To ensure that we have the latest version of restic, we will download it directly from GitHub.

The simplest way to orchestrate backups with restic is to write a script.

# Setting Up the Remote Repository

Create the S3 bucket. We need to do this first, because the current version of restic will check whether the specified bucket exists, and if it does not, restic will create the a new bucket with that name on AWS in the US East region.

# Installing restic Into A Home Directory

Download the file for restic from GitHub, and then set permissions on it:

    mkdir -p $HOME/.restic/bin
    curl -L https://github.com/restic/restic/releases/download/v0.9.2/restic_0.9.2_linux_amd64.bz2 | bunzip2 > $HOME/.restic/bin/restic
    chown -R $USER:$USER $HOME/.restic/bin
    chmod -R 750 $HOME/.restic/bin

# Installing restic for System-Level Use  

Download the file for restic from GitHub. Once the file is downloaded, set the permissions to limit who can use it, and then give it the capabilities to access the whole system:

    curl -L https://github.com/restic/restic/releases/download/v0.9.2/restic_0.9.2_linux_amd64.bz2 | bunzip2 > restic
    mkdir -p /opt/restic/bin
    mv restic /opt/restic/bin
    chown -R root:$USER /opt/restic/bin
    chmod -R 750 /opt/restic/bin
    setcap cap_dac_read_search=+ep /opt/restic/bin/restic

All of these commands apart from the first require administrative privileges.

# Environment Variables

Set environment variables in the *.profile* for your account, or in the script.

~~~bash
export AWS_ACCESS_KEY_ID="XXX"
export AWS_SECRET_ACCESS_KEY="XXX"

export RESTIC_REPOSITORY=s3:s3.amazonaws.com/YOUR-BUCKET-NAME
export RESTIC_PASSWORD=YOUR-REPOSITORY-PASSWORD
~~~

# Running restic

> Before you run restic, ensure that the hostname for the system is set correctly. Each restic snapshot includes the hostname of the source.

Run this command to set up the repository in the S3 bucket:

restic init

A simple example script:

~~~bash
#!/bin/bash

restic backup --exclude={.aws,.ssh} --tag test1 /home
~~~

To view the snapshots that are in the repository:

    restic snapshots

# Resources

* [Fedora Magazine article: Use restic on Fedora for encrypted backups](https://fedoramagazine.org/use-restic-encrypted-backups/)
* [Official documentation: Setting up restic with Amazon S3](https://restic.readthedocs.io/en/stable/080_examples.html#setting-up-restic-with-amazon-s3) - Official restic documentation for using S3 storage
* [System Backups with restic](https://kula.tproa.net/lnt/computers/backups/restic-systems-backups/) - Blog series on using restic for centralized server backup, by Thomas A. Kula
* [GoTime episode on restic](https://changelog.com/gotime/48) - Audio of interview with Alexander Neumann, the developer of restic
