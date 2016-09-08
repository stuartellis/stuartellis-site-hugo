+++
Title = "Using PostgreSQL on Debian and Ubuntu"
Slug = "postgresql-setup"
Date = "2016-07-01T01:00:00+01:00"
Description = ""
Categories = ["databases"]
Tags = ["linux", "postgresql"]
Type = "article"

+++


PostgreSQL is the most capable Open Source database server available, with functionality that can complete or even exceed proprietary SQL database products.

<!--more-->

# Product Versions #

These instructions assume that you are using either Debian or Ubuntu,
but should be adaptable to other operating systems. Ubuntu provides
versions of the Debian PostgreSQL packages, and so has the same
maintenance facilities as Debian.

The current releases of Ubuntu (12.04 and above) includes version 9.1 of
PostgreSQL, rather than PostgreSQL 8.1, so amend the commands below
accordingly.

> *Privileged Commands*: Commands that require root (administrative)
> privileges are shown with the prefix \#. On Ubuntu, simply replace the
> \# with *sudo*.

# Overview #

The setup process installs the PostgreSQL server software and configures
a *cluster* - a group of databases managed by a common service. The
default cluster is called *main*, and the service for it runs on TCP
port 5432. If you need additional clusters you may create them at any
time.

The *main* cluster initially has three databases: *postgres* (for
management purposes), *template0* (a template database without any
customizations) and *template1* (a template database that you may
customize). When you create your own databases they are generated as
copies of *template1*.

Each PostgreSQL cluster uses a set of accounts, known as *login roles*,
which are independent of the users and groups on the host system. For
security and accountability, each user and application should have an
individual login role to access the databases in the cluster. Login
roles may belong to *group roles*, in the same way that system accounts
may belong to groups.

The default configuration rejects all connections from other systems,
and uses *ident* authentication to manage access from users on the same
system. Ident security means that users are not prompted for a password
when they login from the local system, instead they are either
connected, with the login role that has the same name as their system
account, or their connection is rejected if no login role exists to
match their account.

You may easily enable secure remote access, if you require it, and
instructions are below. Current versions of PostgreSQL also support
Kerberos and LDAP, which allows clusters to use the central
authentication and security facilities of more complex networks.
Kerberos and LDAP integration are not covered here.

Like most SQL server products, PostgreSQL groups tables and other
objects held in the databases into *schemas*. Only assign an object to
the *public* schema if that object must be accessible to every user and
application. Typically, you create schemas with the same names as login
roles or group roles, and then assign database objects to the
appropriate schemas.

To manage your PostgreSQL databases, the *psql* utility provides a
command-line shell, and the *pgAdmin III* application offers a graphical
interface. You must use separate utilities to create and upgrade
clusters (see below).

PostgreSQL is highly standards-compliant, and also provides the
additional features that you would expect from a enterprise SQL
database. You may use popular programming languages within PostgreSQL
functions, as well as standard SQL. Version 8.3 includes XML support and
full-text search as part of the core system, and these features were
available as extensions in previous releases.

Version 9.0 of PostgreSQL includes support for single-master
replication. Use Bucardo, Slony-I, or a commercial replication product
to support more advanced scenarios or older versions of PostgreSQL.

The development team prefer more specialized features to remain
separate, rather than simply being bundled with the main software in the
form of one preset solution. For example, the PostGIS extension adds
support for spatial data. Similarly, database drivers and the extensions
for third-party programming languages are maintained separately.

For community add-ons and extensions to PostgreSQL, refer to the
PGFoundry Web site:

<http://pgfoundry.org/>

# Installing the PostgreSQL Server #

On a Debian server:

    # apt-get install postgresql-8.1 postgresql-client-8.1 postgresql-contrib-8.1

On an Ubuntu server:

    # apt-get install postgresql-9.1 postgresql-client-9.1 postgresql-contrib-9.1

Ubuntu also has packages for Slony-I replication and the PostGIS spacial
data extensions:

    # apt-get install postgresql-8.3-slony1

    # apt-get install postgresql-8.3-postgis

# Installing the PostgreSQL Management Tools #

To manage a PostgreSQL service from an Ubuntu workstation, install these
packages:

    # apt-get install pgadmin3 postgresql-client-9.1 postgresql-doc-9.1

This installs the graphical management tool pgAdmin III, the
command-line utilities, and the official documentation in HTML format.

Enter this URI in your Web browser to read the documentation:

<file:///usr/share/doc/postgresql-doc-9.1/html/index.html>

If you use Debian stable, install these packages:

    # apt-get install pgadmin3 postgresql-client-8.1 postgresql-doc-8.1

# Configuring the PostgreSQL Server #

First, set a strong password for the postgres role. This role
automatically has unrestricted access to the cluster and everything held
within those databases, so set a password for this role. To avoid
potential risk, do this as soon as you have installed PostgreSQL, even
if you do not currently intend to enable remote access, and are sure
that no other users can login on the local system.

As the configuration defaults to ident authentication for local access,
we must use the system account *postgres* to login with the *postgres*
role. Enter this command at the server:

    sudo -u postgres psql

Once logged in to the SQL interface, set a password for the *postgres*
role:

~~~sql
ALTER ROLE postgres WITH ENCRYPTED PASSWORD 'mypassword';
~~~

You need this password to connect to the PostgreSQL server remotely with
the postgres role, as described below.

To exit the PostgreSQL shell, type:

    \q

To enable some of the functions of the pgAdmin utility, you must run a
script against the *postgres* database:

    sudo -u postgres psql -d postgres < /usr/share/postgresql/8.1/contrib/admin81.sql

Use /usr/share/postgresql/8.3/contrib/adminpack.sql on current versions
of Ubuntu.

# Enabling Remote Access #

If you wish to enable remote access, modify the cluster settings. The
configuration files for each cluster are in the directory
/etc/postgresql/version/clustername/, e.g. /etc/postgresql/8.1/main/.

Edit the file postgresql.conf, and remove the comment marker on the line
for the listen\_addresses setting, so that it reads:

    listen_addresses = '*'

Open the file pg\_hba.conf:

    # nano /etc/postgresql/8.1/main/pg_hba.conf

To permit users to connect from remote systems on your network with any
role, add this line:

    host all all 192.168.1.0/24  md5

Replace 192.168.1.0/24 with the appropriate subnet definition for your
network.

This enables *md5* authentication, which means that login roles are
secured with passwords that PostgreSQL itself stores in an encrypted
form, and that PostgreSQL will require a valid password for any remote
connection to use a role. After you make this change, ident
authentication remains enabled for local logins.

You may, of course, change the *local* line in pg\_hba.conf to disable
ident authentication. Make sure that you can actually login to your
PostgreSQL cluster with the postgres role and a password first!

To make your changes take effect, restart the service:

    # /etc/init.d/postgresql-8.1 restart

Once the service restarts, you may access your PostgreSQL service from
remote systems, either using tools such as psql or pgAdmin III, or with
applications that support SQL. The Debian version of PostgreSQL is
configured to automatically protect network connections with SSL, so
that all communication between the server and remote clients is
encrypted.

By default, the postgres system account on Debian is locked, and you
should not unlock it. Cracking tools now try to use postgres, root, and
other well-known system account names when they attempt to gain access
to UNIX-like operating systems.

Under no circumstance should you enable PostgreSQL ident authentication
for any remote access. The ident system cannot safely verify or
guarantee the identity of any user on a remote system.

# Creating Databases #

You may either use the createdb command-line utility to create new
databases, or enter the appropriate SQL statement.

Remember that PostgreSQL does not create databases with UTF-8 by
default. If you require Unicode support you must explicitly specify the
UTF-8 encoding when you create the database:

    # sudo -u postgres createdb my_database -u -E UTF-8 --password

The corresponding SQL statement is:

~~~sql
CREATE DATABASE my_database WITH ENCODING 'UTF-8';
~~~

# Database Maintenance #

You must manually set up an appropriate backup routine (see below).

The standard configuration enables the PostgreSQL auto-vacuum service by
default, to ensure that the health of your databases is maintained. This
typically just works without any intervention or extra configuration
being required. If very large volumes of data are frequently added to or
removed from your databases you may adjust the auto-vacuum settings to
be more aggressive, in order to keep your clusters well optimized.

The Debian packages also install a scheduled task to automatically
update the database statistics and run a standard vacuum each day if the
auto-vacuum service is not running on the system (for whatever reason).
In this case, edit /etc/cron.d/postgresql-common/ to enable a weekly
full VACUUM. These tasks use the utility /usr/sbin/pg\_maintenance,
which you may also run manually. Refer to the man page for
pg\_maintenance for more information.

# Database Backups #

The correct backup strategy for your databases depends on their size and
rate of change. For smaller databases, the best solution is to simply
use the supplied pg\_dumpall utility. Refer to the documentation for a
detailed explanation of backup options:

<http://www.postgresql.org/docs/9.1/static/backup.html>

# Using Multiple PostgreSQL Clusters #

Debian includes additional facilities to support multiple PostgreSQL
clusters on the same system. Refer to the file
/usr/share/doc/postgresql-common/architecture.html for a brief
explanation, and the relevant man pages for more details:

* pg\_createcluster - utility to create new clusters
* pg\_lsclusters - utility to display the clusters on the system
* pg\_ctlcluster - utility to manage clusters
* pg\_upgradecluster - utility to upgrade clusters
* pg\_dropcluster - utility to remove clusters
* user\_clusters - configuration file to specify the default cluster
    for users and groups

Clusters may use different versions of PostgreSQL. Install the packages
for the appropriate PostgreSQL versions, and specify the version that
you require when you make a new cluster with pg\_createcluster.

# Upgrading PostgreSQL #

To safely upgrade a PostgreSQL cluster, use the pg\_upgradecluster
utility. This command actually creates a new cluster with the data and
configuration from the specified cluster. The utility also automatically
reconfigures the existing database cluster to use a different network
port. The original copy of the specified cluster is not altered in any
other way.

What To Do If You Have An Encoding Error {#encoding-mismatch}
----------------------------------------

If there is a problem with your PostgreSQL installation, you may see an
error like this one when you try to create a database:

    PG::Error: ERROR: encoding UTF8 does not match locale en_US
    DETAIL: The chosen LC_CTYPE setting requires encoding LATIN1.

The problem is that the locale for a PostgreSQL cluster is set on
creation, and by default it will be the locale of the user account that
creates the cluster. If the locale for the user is not a Unicode locale,
such as **en\_US** rather than **en\_US.utf8**, then the entire
PostgreSQL cluster will use that locale, and will not be compatible with
Unicode.

To fix this, you have to do two things. First, you need to ensure that
the locale is set correctly. Second, you will need to replace the
cluster, because the locale for a cluster cannot be changed once it has
been created.

Before you make any changes, find out why the locale for the user is not
a Unicode locale. This is likely to be because the system locale is not
a Unicode locale, and the user accounts are using the default locale for
the system. Either the system is old, or this is due to an administrator
error. If the problem is that the system has the wrong locale due to
administrator error, then change the locale by editing the configuration
file (/etc/default/locale on Debian and Ubuntu), and then restarting the
system.

To replace a cluster on a Debian or Ubuntu system, back up any databases
that you need to keep, then use the pg\_dropcluster utility to remove
the cluster and the pg\_createcluster utility to create a new one. The
new cluster will have the locale of your user account.

Simply reinstalling the PostgreSQL software will have no effect, because
removing the software leaves the files for the cluster in place, and
installing the software again will not overwrite an existing cluster.
