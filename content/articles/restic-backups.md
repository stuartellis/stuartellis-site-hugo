+++
Title = "Backups with restic"
Slug = "restic-backups"
Date = "2019-04-27T15:00:00+01:00"
Description = "Managing backups with restic"
Categories = ["automation", "devops"]
Tags = ["ansible", "automation", "devops"]
Type = "article"
Toc = true

+++

The [restic](https://restic.net/) utility provides a convenient and well-designed command-line tool for backing up files and directories.

<!--more-->

# Overview

The restic utility is a single executable file that provides all of the features to backup and restore data. The restic developers publish versions of the utility for Linux, macOS and Windows.

To backup your data, restic creates and manages snapshots. Each snapshot records a set of files and directories. These snapshots are stored in a set of data files, known as a repository. The data in each snapshot is de-duplicated before it is stored in the repository.

A restic repository can be in a directory on the same computer as the source files, or on remote storage, such as AWS S3. For security, each restic repository is always encrypted with a passphrase.

You also view and restore files from a repository with the restic command-line utility. This means that you can restore files from a repository to any computer that has a copy of restic.

Since restic only handles the back up and restoration of files, you will need to use other tools to handle database exports, scheduling, logging, and notifications. You can [pipe the output of commands to restic](https://restic.readthedocs.io/en/stable/040_backup.html#reading-data-from-stdin), which enables you to turn data exports directly into snapshots.

To use restic you only need these things:

1. A copy of the restic utility. It is a single file, so there is no setup or installation process
2. The address or location of the repository. This can be provided as an environment variable.
3. Any secret(s) that are needed for accessing the remote storage that holds the repository
4. The password for decrypting the repository. This can be provided as an environment variable or in a file.

# Setting Up restic

### Creating a Remote Repository on S3

The built-in support for AWS S3 enables restic to use an S3 bucket to store a repository. Multiple systems can back up to the same repository, but for security, you should use separate buckets for different sets of computers.

Create the S3 bucket first, before you setup restic. We need to do this, because the current version of restic will check whether the specified bucket exists, and if it does not, restic will create the a new bucket with that name on AWS in the US East region.

> Multiple systems can back up to the same repository, but for security, you should use separate buckets for different sets of computers.

### Installing restic

You can install restic with the package manager of your Linux distribution, or Homebrew on macOS. To ensure that you have the latest version of restic, you should download it directly from GitHub instead.

The simplest ways to orchestrate backups with restic are to write a shell script or [systemd unit files](https://fedoramagazine.org/automate-backups-with-restic-and-systemd/).

Alternatively, use this [Ansible role for restic](https://galaxy.ansible.com/paulfantom/restic), which can install restic for system-wide use, and set up scheduled backups.

### Manually Installing restic Into A Home Directory

Download the file for restic from GitHub, and then set permissions on it:

    mkdir -p $HOME/.restic/bin
    curl -L https://github.com/restic/restic/releases/download/v0.9.5/restic_0.9.5_linux_amd64.bz2 | bunzip2 > $HOME/.restic/bin/restic
    chown -R $USER:$USER $HOME/.restic/bin
    chmod -R 750 $HOME/.restic/bin

### Manually Installing restic for System-Level Use

Download the file for restic from GitHub. Once the file is downloaded, set the permissions to limit who can use it, and then give it the capabilities to access the whole system:

    curl -L https://github.com/restic/restic/releases/download/v0.9.5/restic_0.9.5_linux_amd64.bz2 | bunzip2 > restic
    mkdir -p /opt/restic/bin
    mv restic /opt/restic/bin
    chown -R root:$USER /opt/restic/bin
    chmod -R 750 /opt/restic/bin
    setcap cap_dac_read_search=+ep /opt/restic/bin/restic

All of these commands apart from the first require administrative privileges.

### Environment Variables for restic

Set environment variables in the _.profile_ for your account, or in the script.

If you use S3 for the remote repository, you will need to provide four variables:

```bash
export AWS_ACCESS_KEY_ID="XXX"
export AWS_SECRET_ACCESS_KEY="XXX"

export RESTIC_REPOSITORY=s3:s3.amazonaws.com/YOUR-BUCKET-NAME
export RESTIC_PASSWORD=YOUR-REPOSITORY-PASSWORD
```

# Running restic

> Before you run restic, ensure that the hostname for the system is set correctly. Each restic snapshot includes the hostname of the source.

Run this command to set up the repository:

    restic init

A simple example script:

```bash
#!/bin/sh

restic backup --exclude={.aws,.ssh} --tag test1 /home
```

> If you use S3, restic create objects with the _STANDARD_ storage class by default. Use the _s3.storage-class_ option to specify a different storage class for objects.

To view the snapshots that are in the repository:

    restic snapshots

# Resources

- [Fedora Magazine article: Use restic on Fedora for encrypted backups](https://fedoramagazine.org/use-restic-encrypted-backups/)
- [Fedora Magazine article: Automate backups with restic and systemd](https://fedoramagazine.org/automate-backups-with-restic-and-systemd/)
- [Official documentation: Setting up restic with Amazon S3](https://restic.readthedocs.io/en/stable/080_examples.html#setting-up-restic-with-amazon-s3) - Official restic documentation for using S3 storage
- [System Backups with restic](https://kula.tproa.net/lnt/computers/backups/restic-systems-backups/) - Blog series on using restic for centralized server backup, by Thomas A. Kula
- [GoTime episode on restic](https://changelog.com/gotime/48) - Audio of interview with Alexander Neumann, the developer of restic
- [Ansible role for restic](https://galaxy.ansible.com/paulfantom/restic), by Paul Fantom
