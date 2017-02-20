+++
Categories = ["administration"]
Tags = []
Description = ""
Date = "2017-01-26T07:20:00Z"
Title = "Frozen Moments (Database Snapshots)"
Type = "post"
Draft = true

+++


Systems that never stop make it more challenging to capture portable snapshots of databases for particular moments in time.

<!--more-->

The aim is to have the ability to restore a database as it existed at a previous point in time.

Note that this is necessary for disaster recovery, but not sufficient. To restore the complete state of an application from a previous point in time, you must be able to co-ordinate the restoration of the application code, and the static data files as well as all of the databases.

## Database consistency

Snapshots must deal with logging

Why just grabbing the files doesn't work

## Which offline format to use

binary formats are more efficient but not portable

## Compression

tar simply combines many files into one. gzip or zip compresses

## Integrity testing

## Encrypting Snapshots

## Metadata

Type and version of database. Different databases uses different data types and SQL dialects. PostgreSQL explicitly does not guarantee compatibility between versions.

What format do we use for timestamps

## RDS Snapshots

## Restoring

Restoring to a different database type and version is risky.
Consider using Docker to run specific versions of products

AWS resources on backups

## Capturing Snapshots from a Remote Computer

Install the database client on a remote computer

Enable secure remote access (SSL)

* MySQL user account with full read access
* IAM user with S3 read and write access
* Run-time environment for Backup (CI) ?
* Backup environment needs configuration
* Backup needs scheduling
