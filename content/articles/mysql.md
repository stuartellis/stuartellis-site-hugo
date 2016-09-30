+++
Title = "Notes on MySQL"
Slug = "mysql"
Date = "2016-07-01T01:00:00+01:00"
Description = ""
Categories = ["databases"]
Tags = ["database", "mysql", "sql"]
Type = "article"

+++


MySQL provides all of the essential functionality required for a SQL
database service. Although it is most frequently used to provide data
storage for Web applications on the same system, MySQL supports
replication and clustering across networks.

<!--more-->

## Understanding MySQL User Accounts ##

MySQL uses a separate set of user accounts to the operating system. The
MySQL accounts are independent of the accounts used by the host system,
even where they share the same name. Unlike other database systems,
MySQL does not include roles or groups for applying sets of privileges
to multiple user accounts.

Each MySQL user account is identified by a network address, in addition
to a username. Accounts may only access the MySQL service from systems
that match the network address. Accounts with the same username but
different network addresses are totally separate. For example, the
account **bill@mycomputer.example.com** identifies a user account called
**bill**, who may only access MySQL from the system
**mycomputer.example.com**, whilst **bill@%.example.com** would be a
completely separate account that identifies the user **bill**, who
should be permitted access from any system on the **example.com**
domain.

Ubuntu installs MySQL with three user accounts:

* **root@localhost** - for administrative access
* **root@yourhostname** - for administrative access
* **debian-sys-maint@localhost** - enables access to MySQL by operating system processes

For security, always create a separate user account for each application
or user that will access MySQL, and only grant these accounts the
minimum necessary privileges. Once additional accounts have been created
for the administrators, reserve the root accounts for emergency use
only.

Specify **localhost** as the network address for each account, unless
that account specifically requires remote access.

MySQL stores all account information in the database named **mysql**.
This enables you to manage your MySQL accounts with SQL commands from
any script or application. The database service uses a copy of the
necessary tables. You may force the service to refresh the user account
information that it uses with the *FLUSH PRIVILEGES* SQL command.

## Understanding Storage Engines ##

MySQL may use several types of *storage engine* for tables. Each engine
uses a different set of file formats to support particular capabilities.
Use *InnoDB* for all of the tables that you create, unless you need
specific features provided by another storage engine. The *InnoDB*
engine provide the best protection for your data, and the performance
difference between InnoDB and MyISAM may not be significant for most
applications.

> *The System Database Must Use MyISAM:* Current versions of MySQL use
> and require *MyISAM* tables for the mysql database. Do not attempt to
> convert this database to *InnoDB*.

## Understanding SQL Modes ##

MySQL 5 provides several optional *mode* settings, which enable you to
configure it to emulate the behavior of other database systems, or
modify the way that it interprets SQL commands. For example, the ANSI
mode causes MySQL to interpret SQL in ways that more closely follow the
ANSI SQL specification. You may use as many modes as you wish.

By default, MySQL attempts to correct invalid data, rather than
rejecting it. To configure MySQL to reject invalid data, use the
*TRADITIONAL* mode and *InnoDB* databases.

## MySQL Administration Tools ##

MySQL provides sets of graphical and command-line utilities. The
command-line utilities are automatically installed along with the MySQL
server. You may install both the graphical and command-line utilities on
any system, without installing a MySQL instance.

> *macOS:* The MySQL distributions for macOS install it into a
> subdirectory within the /usr/local/ directory. In addition, a symlink
> of /usr/local/mysql is created to point to the most recent version of
> MySQL. For convenience, add /usr/local/mysql/bin to your PATH.

To access MySQL, either use the graphical [MySQL
Workbench](http://wb.mysql.com/) application, or the mysql command-line
utility. The mysql utility provides a shell interface that enables you
to enter any SQL statement and see the results. You may carry out user
and data management functions simply by entering the correct SQL
statements. The mysql utility is also referred to as *MySQL monitor*.

The command-line mysqladmin utility provides a range of functions for
maintaining the MySQL database service.

> *Remote Access:* For security, MySQL is not accessible from remote
> systems with the default configuration.

# Installing MySQL Server on Linux #

Install the *mysql-server* package, using whichever software management
tool you prefer. This automatically causes the MySQL command-line
utilities to be installed.

To install MySQL Proxy, use the package *mysql-proxy*.

> *MySQL on Linux Depends on an Email Service:* The MySQL service uses
> the local email service to dispatch messages. For this reason,
> installing MySQL on an Ubuntu system also install an email service.

# Installing MySQL Tools on a Linux Development Workstation #

To use MySQL on a Debian or Ubuntu workstation, install the mysql-client
package, which provides the command-line tools for MySQL. This package
automatically installs if you install the server.

Install the appropriate MySQL driver package for your preferred
programming languages:

* libdbd-mysql-perl - Perl 5 driver for MySQL
* libmysql-java - Java database (JDBC) driver for MySQL
* libdbd-mysql-ruby - Ruby/DBI driver for MySQL
* libmysql-ruby - MySQL module for Ruby
* python-mysqldb - Python driver for MySQL

The MySQL Reference Manual and the MySQL Workbench desktop application
are offered as free downloads from the MySQL Website.

# Configuring the MySQL Server #

To ensure that the data on your system remains secure and consistent,
perform these tasks after the installation completes:

1.  Set a password for the administrative (*root*) accounts
2.  Configure MySQL for higher data protection
3.  Activate the query cache
4.  Disable anonymous access
5.  Set up scheduled backups

## Securing the root Accounts ##

The Debian installer automatically prompts you for a root password
before it configures a MySQL service.

If you installed MySQL from source code, run install\_mysql\_db to set
up the system databases and then run the mysql\_secure\_installation
script. This enables you to set the root passwords, and drops the *test*
database.

Alternatively, you can set the root passwords with standard SQL
statements. Enter this command to login to MySQL from the console for
the first time:

    mysql -u root

To set the passwords for both root accounts, enter the following SQL
statements:

~~~sql
UPDATE mysql.user SET password = PASSWORD('yourpassword') WHERE user LIKE 'root';
FLUSH PRIVILEGES;
EXIT;
~~~

In the *UPDATE* statement shown above, replace *yourpassword* with the
password that you wish to use for the account.

After you exit mysql, use echo to empty the MySQL command history:

    echo > .mysql_history

All root access to MySQL now requires a password. To confirm this, login
to MySQL again, with the *-p* option:

    mysql -u root -p

Enter your MySQL root password when prompted.

## Configuring Stronger Data Protection ##

In many cases, stronger data protection is more important than maximal
performance. To enable the key features, edit the [mysqld] section of
the global option file. This file is /etc/mysql/my.cnf on Linux. If you
installed MySQL from source code, create the file as
/usr/local/var/mysql/my.cnf.

> *Configure These Settings Before You Create a Database:* To ensure
> that your databases are consistent, apply the settings that are
> described below before you create any databases in MySQL.

By default, MySQL uses the latin1 character set, rather than UTF-8
(Unicode). Enable UTF-8, to ensure that your databases store and
interpret characters correctly.

MySQL also uses no SQL modes by default. To specify the modes, add a
sql-mode option. MySQL recommend the following modes for new
installations:

    sql-mode="STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"

For new systems with no backwards-compatibility requirements, configure
TRADITIONAL mode instead. Despite the name, this setting provides the
strongest level of protection.

If the service is running with STRICT\_ALL\_TABLES,
STRICT\_TRANS\_TABLES, or TRADITIONAL mode, it is said as be in *strict
mode*.

    [mysqld]

    # Set this server to use UTF-8 with case-insensitive collation
    character-set-server=utf8
    collation-server=utf8_general_ci

    # Ignore the character set specified by the client
    # This forces all clients to use the character set specified above
    skip-character-set-client-handshake

    # Use InnoDB storage by default for new databases
    default-storage-engine=InnoDB

    # Enable the binary log
    log-bin

    # Delete obsolete binary logs after a period of time
    expire_logs_days=14

    # Prevent logins from clients that use the obsolete password hashing
    # No supported client software now requires the old, pre MySQL 4.1 style
    secure-auth

    # Disable LOCAL INFILE unless you need it
    # INFILE enables compromised MySQL accounts a route into the host system
    local-infile=0

    # Disable remote access
    bind-address=127.0.0.1

    # Ensures that users must have the SHOW DATABASE privilege to see a list of databases
    skip_show_database

    # TRADITIONAL mode provides the strongest safety measures of the SQL modes
    # This may break incorrectly written applications
    sql-mode=TRADITIONAL

Restart the MySQL service to make the changes take effect.

## Activating the Query Cache ##

The query cache contains both statements and the result set returned. If
MySQL can match a statement in the query cache then it can return the
result set without using any storage engine or disk access at all.

You must specify a maximum size for the query cache for MySQL to use it.
The query cache will only be used if it is both enabled **and** it has
been assigned a size. By default, it is enabled but not assigned a size,
so it will not be used at all.

This specifies a query cache of 16 megabytes:

    [mysqld]
    # Set query cache size in megabytes
    query_cache_limit       = 1M
    query_cache_size        = 16M

## Blocking Anonymous Access ##

The anonymous account in MySQL enables some access without
authentication. If you use the mysql\_secure\_installation script,
accept the option to delete the anonymous account. Otherwise, delete it
yourself:

~~~sql
DROP USER '';
~~~

The quotes must be empty.

## Configuring Backups ##

To backup MySQL fully, you must both create copies of the following:

* The global options file
* The databases
* The binary logs

There are many tools available for backing up MySQL databases, most of
which work in one of three ways:

* **Dump export:** Exporting the databases into text files, as SQL, XML or another format. Simple and produces highly portable backups.
* **Hot copy:** Copies the binary files that MySQL uses for storage, without disrupting the running service.
* **Filesystem snapshot:** Uses the snapshot capabilities of the host system. Very efficient, but tied to the host operating system.

The standard MySQL command-line tools include mysqldump and mysqlhotcopy
utilities. Use mysqldump for dump exports and imports, as it has proven
fast and reliable. The supplied mysqlhotcopy tool only works for MyISAM
tables, which makes it effectively useless on modern MySQL installations.

The simplest backup method for small databases is to use a shell script
to run mysqldump, and schedule it to run daily with the system task
scheduler. Several scripts are freely available, or you can write your
own. If the database grows then full dump exports become too slow, and
you must move on to hot copy or snapshot backup methods.

> *Check The Active Character Set:* You will see strange characters if
> your backups use a different character set to the server that you
> restore to. To avoid this issue, ensure that you use UTF-8 (Unicode)
> on all of your MySQL clients and servers.

For security, create a dedicated user account on the system itself for
backups, and add a matching account within MySQL. On Debian and Ubuntu
systems the backup account must be a member of the adm group. To create
this user from the command-line, enter the following:

    .. sudo adduser backup-user\
sudo usermod -G adm backup-user

This SQL statement creates a new MySQL user account called backup-user,
with a password of passwd, and sufficient privileges to backup all
databases on the system:

~~~sql
GRANT LOCK TABLES, RELOAD, REPLICATION CLIENT, SELECT
ON *.*
TO  'backup-user'@'localhost'
IDENTIFIED BY 'apassword';
~~~

To enable the system account to access MySQL, create a .my.cnf file in
the home directory of the user to hold the MySQL username and password.
This is an example .my.cnf file:

    [client]
    host    = localhost

    # MySQL user account
    user    = backup-user

    # MySQL password
    password    = apassword

    socket    = /var/run/mysqld/mysql.sock

This is a simple example of a backup script for MySQL, using a .my.cnf
file:

~~~shell
#!/bin/bash

#  Backup Script for MySQL
# This creates a file each day

# umask ensures that created files are only accessible by administrators, and this account.
umask 077

WEEKDAY=`date +%a`
LOGSDIR=~/logs
MYSQLBACKUPSDIR=~/mysql-backups
CURRENTBACKUPDIR=$MYSQLBACKUPSDIR/$WEEKDAY
CURRENTBACKUPFILE=$BACKUPDIR/$WEEKDAY.sql
CURRENTLOGFILE=$LOGSDIR/$WEEKDAY.log

# Create necessary directories, if they don't exist.
for DIR in $LOGSDIR $MYSQLBACKUPSDIR $CURRENTBACKUPDIR
do
    {
        if [ ! -e $DIR ]
        then
            {
                mkdir $DIR
                chown $USER $DIR
                chmod 700 $DIR
            }  
        fi
    }
done

# Dump MySQL databases, writing errors to the script log.
# The routines option means that stored procedures and functions are included
mysqldump --delete-master-logs --all-databases --single-transaction --flush-logs --flush-privileges --routines > $CURRENTBACKUPFILE 2>>$CURRENTLOGFILE

# Copy the contents of the binary log directory, writing errors to the script log.
cp /var/log/mysql/* $CURRENTBACKUPDIR 2>>$CURRENTLOGFILE
~~~

To add this script to the list of scheduled jobs for the user account,
run crontab:

    sudo crontab -u backup-user -e

Add the following line, and save the file:

    0 2 * * * /home/backup-user/mysql-backup.sh

This specifies that the script /home/backup-user/mysql-backup.sh should
run at 2am every day.

## Other Security Measures ##

-   Restrict access to mysql.user table
-   Run MySQL as an unprivileged user
-   Run MySQL with chroot
-   Consider encrypting the data directory
-   Linux only: ensure that you enable AppArmor (or SELinux on Red
    Hat-based systems)

    # Differences Between The Debian Version of MySQL and the MySQL Community Release #

    The MySQL configuration provided by Debian and Ubuntu differs slightly
    from the version provided and documented by MySQL AB. Specifically:

    * The service management facilities use mysqld\_safe, rather than mysqlmanager
    * A **debian-sys-maint** account is created by default, to enable management scripts to automatically access MySQL
    * The MySQL Reference Manual cannot be included in the distribution, as this document is under a proprietary license

    Ubuntu includes a package for the MySQL Reference Manual in the
    **multiverse** repository.

# Managing MySQL #

MySQL loads the data from the grant tables into memory on startup, and
uses this in-memory copy. The built-in management functions such as
GRANT, CREATE USER etc. automatically flush the in-memory privileges
data. If you manually alter data in the grant tables use FLUSH
PRIVILEGES to force MySQL to reload the privileges data from the tables.

## Starting and Stopping the MySQL Service ##

To start or stop the MySQL service on Linux, use the service management
tool provided with your distribution.

To start MySQL from the command-line on other platforms, run
**mysqld\_safe**:

    mysqld_safe &

To cleanly shutdown a running MySQL service, use mysqladmin:

    mysqladmin -u root -p shutdown

## Creating a Database ##

To create a new database, use either MySQL Workbench, the mysqladmin
command-line utility, or a *CREATE DATABASE* SQL statement:

~~~sql
CREATE DATABASE todo DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
~~~

Similarly, you may create tables either with MySQL Workbench, or with
SQL statements. For example, this command creates the table todo\_items:

~~~sql
CREATE TABLE todo.todo_items (id INT AUTO_INCREMENT KEY, item_name VARCHAR(100), item_desc TEXT, item_due DATE, item_updated TIMESTAMP);
~~~

For convenience and portability, use lowercase for objects such as
database and tables. MySQL is case-sensitive when it handles database
and table names. The Windows version of the *InnoDB* storage engine also
internally stores all object names in lowercase.

## Creating MySQL User Accounts ##

To create a new user account, either use MySQL Workbench, or issue a SQL
statement. Current versions of MySQL include a SQL *CREATE USER*
command, but this is not available in previous versions. All versions
allow you to create a new user with the *GRANT* command. As always,
specify lowercase usernames, that do not include spaces or special
characters. *MySQL* usernames may be upto 16 characters long.

> *CREATE USER Grants No Privileges:* If you add an new account with
> *CREATE USER* it has no privileges until you specify some by either
> using *GRANT*, or MySQL Administrator.

If you specify a user account that does not exist in a *GRANT* statement
then MySQL creates the account and sets the specified privileges for it.
This example creates the named user account, and gives the new account
the ability to edit all of the tables within the specified database:

~~~sql
GRANT SELECT,INSERT,UPDATE,DELETE
ON adatabase.*
TO  'newuser'@'localhost'
IDENTIFIED BY 'passwd';
~~~sql

The *GRANT* statement automatically encrypts the password that you
specify. Use the *PASSWORD ('passwd')* function to specify passwords
when using other SQL statements to edit passwords.

> *Avoid Granting the FILE Privilege:* Avoid granting the *FILE*
> privilege to non-administrative accounts: this privilege enables the
> account to read and write files on the server using the mysqld system
> account.

To create an account that can manage privileges for other accounts, use
the *WITH GRANT OPTION*. For example, this command creates a MySQL
account called bill that has all privileges for all databases, may login
from any system in the domain, and may set privileges for others:

~~~sql
GRANT ALL ON * TO 'bill'@'%.mydomain.com' IDENTIFIED BY 'passwd' WITH GRANT OPTION;
~~~

## Resetting Account Passwords ##

To remove the accounts *bob* and *jim* on current versions of MySQL,
*REVOKE* the privileges for the account and then carry out a *DROP USER*
operation:

~~~sql
REVOKE ALL PRIVILEGES ON * FROM 'bob'@'localhost', 'jim'@'localhost';
DROP USER 'bob'@'localhost', 'jim'@'localhost';
~~~

The *REVOKE* statement removes the *GRANT* privilege, and all other
privileges that the user has. *DROP USER* removes the record for the
account in the mysql database.

## Removing Obsolete Accounts {#remove-account}

To remove the accounts *bob* and *jim* on current versions of MySQL,
*REVOKE* the privileges for the account and then carry out a *DROP USER*
operation:

~~~sql
REVOKE ALL PRIVILEGES ON * FROM 'bob'@'localhost', 'jim'@'localhost';
DROP USER 'bob'@'localhost', 'jim'@'localhost';
~~~

The *REVOKE* statement removes the *GRANT* privilege, and all other
privileges that the user has. *DROP USER* removes the record for the
account in the mysql database.

## Upgrading MySQL ##

Run the mysql\_upgrade utility after you upgrade your server. This
checks your tables, and upgrades the system tables used by MySQL itself:

    mysql_upgrade

# Good Practices for MySQL #

## Good Practices for Queries ##

* Unless you are sure about the server, always specify the character set: SET NAMES ‘utf-8’
* Always use prepared statements for better performance and security.
* Write queries to keep indexed field on just one side of each statement.
* Avoid starting strings with wildcards, as this prevent the server from using any index on that field.
* Avoid putting nondeterministic functions such as NOW or CUR\_DATE into queries, as they disable the query cache.
* Use JOINs rather than subqueries - they can massively increase the number of operations the server must do.
* Use derived tables in complex queries, rather than applying the condition to every row.
* Use CHAR\_LENGTH instead of LENGTH with UTF-8, as LENGTH returns the number of bytes.
* Remember to check complex queries with EXPLAIN, to ensure that you have optimised correctly.
* Consider using *unbuffered queries* with large result sets - these enable MySQL to start returning rows immediately, rather than waiting until the complete set has been constructed.

## Good Practices for Database Design ##

* Create tables in a test instance, load in some data, and then run PROCEDURE ANALYSE to get optimisation suggestions.
* Always specify NOT NULL for columns unless you specifically need to allow NULL values.
* Use the ENUM type instead of VARCHAR for columns that should contain one of a set of alternatives - MySQL then internally stores values as TINYINTs.
* Use the UNSIGNED INT type for IP addresses, and use the functions INET\_ATON and INET\_NTOA to convert addresses to numbers and back.
* If a table contains no fields of the types VARCHAR, TEXT, or BLOB then MySQL handles it as a *fixed-length* table, which boosts performance.

## Other Good Practices ##

-   Never use the PASSWORD function for your own applications, use the
    SHA1 function instead.

# Reference: Recovery #

First, import the latest SQL script generated by mysqldump:

    sudo mysql < example.sql

You may then restore subsequent changes from incremental binary backups:

    mysqlbinlog gbichot2-bin.000007 gbichot2-bin.000008 | mysql

Refer to this page for details:

[http://dev.mysql.com/doc/refman/5.1/en/recovery-from-backups.html](http://dev.mysql.com/doc/refman/5.1/en/recovery-from-backups.html)

# Reference: A Note on Time and Date Data Types #

MySQL stores internally dates for the local timezone. Timestamps are
stored in UTC format.

# Performance Tuning #

The biggest performance boosts come from:

* Effective indexing
* Writing optimal SQL queries
* Providing sufficient memory
* Enabling the query cache

Poor indexing will harm performance more than anything else! Adjusting
server parameters is likely to have much less impact than any of the
items above.

> Use clean normalized schema, unless you have a specific need for
> denormalized schema. Denormalized schemas harm performance for normal
> workloads.

Allocate 50%–80% of available memory to innodb\_buffer\_pool\_size
parameter. Remember that all parameters that affect a particular storage
engine will have no effect at all on queries that use other storage
engines. For example, the key\_buffer setting is for MyISAM, and is
irrelevant to the InnoDB engine.

If you adjust a server parameter, pass attention to whether it is a
global parameter, or per-thread (connection)!

## Benchmarking ##

Remember to disable the query cache before performing benchmarks, by
setting the cache size to 0.

* Use the Slow Query Log. It logs both queries that have no indexes, as well as actual slow running queries.
* Use mytop utility. This tool works on both local and remote instances of MySQL.
* The best diagnostic is EXPLAIN.
* The MySQL source distribution also includes the sql-bench benchmarking suite.

## Effective Indexing ##

* Look for opportunities to provide covering indexes.
* On multi-column indexes, be aware that the order of the columns matter, e.g. keys of join tables.
* Remember to remove redundant indexes - MySQL does not prevent multiple indexes on the same field.
* Indexes include almost full width of the data type, so use the minimum sized type possible.

Remember that InnoDB indexes always include the primary key, so you
might create redundancies. InnoDB cannot COUNT from indexes and must
scan the records, so consider maintaining counter tables if you need
large running totals.

# Resources #

* [Performance Tuning Best Practices for MySQL](http://video.google.com/videoplay?docid=2524524540025172110&q=google+engedu) - Presentation by Jay Pipes
* [Common MySQL Queries](http://www.artfulsoftware.com/infotree/queries.php?&bw=1504)
