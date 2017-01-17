+++
Categories = ["administration"]
Tags = []
Description = ""
Date = "2017-01-16T06:40:00Z"
Title = "Frozen Moments (Database Snapshots)"
Type = "post"
Draft = true

+++


Systems that never stop make it more challenging to capture portable snapshots of databases for particular moments in time.

<!--more-->

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
