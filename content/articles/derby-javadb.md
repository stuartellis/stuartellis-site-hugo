+++
Title = "Getting Started with Apache Derby (Java DB)"
Slug = "derby-javadb"
Date = "2016-07-01T01:00:00+01:00"
Description = ""
Categories = ["databases"]
Tags = ["java", "sql"]
Type = "article"
Toc = true

+++

Apache Derby (or Java DB) provides a small set of libraries that can be
added directly to any Java program that needs database storage
capabilities, such as a desktop application, network service, or Web
application.

<!--more-->

# More on Derby #

Generated Derby databases can be bundled with your
application, to remove the need for any separate installation or
configuration. In *embedded* mode, the Derby libraries can directly read
database files that are held in JAR archives.

Used as a stand-alone network server, Derby supports online backup,
replication between a master and multiple slaves, XA transactions, LDAP
user authentication, and SSL/TLS for encrypted connections. The standard
distribution includes a Web interface for Derby services in the form of
a Java servlet for you to install on your preferred applications server.
You may, of course, control Derby instances with your own code through
the APIs. Derby also complies with the Java Management Extensions (JMX)
standard for remote monitoring and management.

In either server or embedded mode, Derby has all of the features that you would
expect from a modern SQL database including transactions, stored procedures,
views, triggers, and XML data types. Derby supports encrypted database files.

You can access Derby database files and servers from any external JRuby
or Java application, by using the bundled JDBC drivers. Command-line
utilities are provided for developers and administrators. The supplied
documentation is comprehensive.

Java DB is simply the brand name for versions of Apache Derby that are
packaged and supported by Oracle. The software is the same as
that released by the Derby project of the Apache Software Foundation.
Apache Derby and Java DB are covered by the Apache Software License, an
open source license that permits the product to be freely used in both
open source and proprietary applications.

As a historical note, Derby was originally released as a commercial
product called Cloudscape. IBM bought it, and subsequently donated it to
the Apache Foundation for development as an Open Source project.

# Installing Java DB #

For convenience, this section only gives instructions for Java DB, the
Oracle build of Derby.

## Installing Java DB on Windows ##

Oracle bundles Java DB with their Java Development Kit (JDK), and this JDK
is the simplest way to install a JRE and Java DB on Microsoft Windows.
You can download the JDK from the Oracle web site.

If you want to use Java DB to provide databases for your applications,
choose the Java DB component from the list of options when you install
the Oracle JDK.

Remember to add the JDK to the beginning of your PATH environment
variable. To do this, choose Start \> Control Panel \> System \>
Advanced \> Environment Variables, find *path* in the System Variables
list, and Edit it to add:

    C:\Program Files\Java\jdk1.6.0_06\bin\

Substitute jdk1.6.0\_06 with the correct directory name for your JDK
version.

Items in the PATH must be separated by semi-colons.

To test this, open a Command Prompt window and type:

    java -version

To use Java DB, add the directory for the Java DB program files to your
PATH:

    C:\Program Files\Sun\JavaDB\bin\

Java DB also requires a separate DERBY\_HOME environment variable that
points to the root directory for your Java DB installation:

    C:\Program Files\Sun\JavaDB

To test your Java DB installation, open a terminal (command prompt)
window, and type:

    sysinfo

## Installing Java DB on Linux ##

For Linux, Oracle collaborates with other vendors and the community on a
fully open source JDK (the OpenJDK). All of the major Linux
distributions include packages for the OpenJDK.

To install the OpenJDK on an Ubuntu system:

     sudo apt-get install openjdk-6-jdk

The OpenJDK does not include Java DB. To install the correct version of
Java DB on Ubuntu:

    sudo apt-get install sun-javadb-client sun-javadb-core

Note that the Ubuntu repositories include other, older Java DB packages.
Use the sun-javadb-\* packages with the OpenJDK, not the
sun-java6-javadb or sunwderby packages.

To enable Java DB, add the *bin* directory for Java DB to your PATH
environment variable, and set a new DERBY\_HOME environment variable. On
Ubuntu and Debian systems, add these lines to the end of the *.bashrc*
file in your home directory:

    export PATH=\$PATH:/usr/share/javadb/bin/
    export DERBY\_HOME=/usr/share/javadb

This will take effect the next time that you login or open a new
terminal window.

# Administration Tools #

Three command-line administration utilities are supplied with Derby:

* *dblook*, for exporting schema information
* *ij*, an interactive SQL command shell
* The *sysinfo* diagnostics utility

If you have added the environment variables, you may run any of these
commands by typing the name of the utility in a terminal window.

Derby also includes built-in system procedures for administrative tasks,
such as backup, consistency checking, and bulk import and export. All of
these are provided in the SYSCS\_UTIL schema, so that you may run them
from any SQL connection.

This article includes some brief notes on *ij* below, but the supplied
Guides are the definitive resource on using the applications and system
procedures.

# Creating and Using Derby Databases #

Derby databases are stored as a directory with several subdirectories.
You use a standard URL syntax to refer to either local or remote
databases in commands and connection strings. The supplied *ij*
command-line utility can connect to both local and remote databases.

For a local database, the syntax looks like this:

    jdbc:derby:databaseName;URLAttributes

By default, Derby will simply check the current working directory for a
subdirectory with the specified name. You may override this, and
explicitly set the default parent directory that Derby should check with
the property (Java setting) *derby.system.home*.

Alternatively, you can specify a relative or absolute path to the
database directory itself in the JDBC string:

    jdbc:derby:/srv/databases/thisdb
    jdbc:derby:../databases/thisdb

The recommended practice is to define a root databases directory for
your application and place all of the databases for that application in
it. Configure your application to use the *embedded* Derby JDBC driver
when the databases will be part of that application and executed by the
same instance of the Java runtime (the JVM).

To access a database via a Derby network server:

    jdbc:derby://host:port/databaseName;URLAttributes

Configure your applications to use the *network client* JDBC driver when
they connect to a separate Derby database service. By default,
stand-alone Derby services uses TCP port 1527.

Derby does not require or support a CREATE DATABASE statement. To create
a new database, simply append *create=true* to the connection string.
For example, if you start *ij* and run this statement, it automatically
creates a new database in the current working directory:

    CONNECT 'jdbc:derby:mydb;create=true';

Once your connection is active, you may immediately run further
statements against the new database, such as CREATE TABLE.

To create a new database for a running Derby service, include the
*create* option in the connection URL in exactly the same way:

    jdbc:derby://localhost:1527/mydb;create=true;user=myaccount;password=nocansay

There is also no separate command to drop a database. To destroy a
database, just detach it from any service that might access it, and then
delete the database files.

## Using the ij Utility ##

The *ij* utility does not connect to any database until you explicitly
specify at least one connection. You may define connections either as
part of the command, in a properties (settings) file, or with a CONNECT
statement once *ij* has started. You may have multiple open connections
and switch between them.

To specify connections or other properties as part of the command, use
the -D switch. The *ij.connection* property creates a connection that
has whatever name you specify after the period, and assigns it the JDBC
URL that you give. In the example above, the new connection has the name
*myconnection*.

    ij -Dij.connection.myconnection=jdbc:derby:mydb
    ij -Dij.connection.myconnection=jdbc:derby:mydb -Dderby.system.home=C:\\mydatabases
    ij -Dij.connection.mynetconnection=jdbc:derby://myserver:1527/mydb -Dij.user=me -Dij.password=nocansay

Note that there is no space between a -D switch and the property that it
sets.

A CONNECT statement in *ij* looks like this:

    CONNECT 'jdbc:derby:mydb' AS 'myconnection';

Or:

    CONNECT 'jdbc:derby:mydb' AS 'mynetconnection' USER 'myaccount' PASSWORD 'nocansay';

> *Semi-colons are mandatory:* Derby requires a semi-colon on the end of
> every statement, including statements that use the built-in *ij*
> commands.

You can set a connection without specifying a name, although it isn’t a
good habit:

    ij -Dij.protocol=jdbc:derby: -Dij.database=mydb
    CONNECT ‘jdbc:derby:mydb’;

To change which connection is used, issue a SET CONNECTION statement:


ij -Dij.connection.myconnection1=jdbc:derby:mydb1 -Dij.connection.myconnection2=jdbc:derby:mydb2
ij \> SET CONNECTION myconnection2;

To list the commands available in an *ij* session, type:

    help;

To exit a *ij* session, type:

    exit;

You may use *ij* to run scripts, and, optionally, output the results to
a text file. Simply add the names of the required files to the
command-line:

    ij myscript.sql
    ij myscript.sql output.txt

# Running Derby as a Service #

Refer to the supplied Server and Administration Guide for information on
running and maintaining a Derby service.

By default, Derby services only accept connections from the local system
(localhost). If you permit network access, note that you need to
explicitly enable TLS/SSL encryption, and also user authentication.
Derby refers to TLS/SSL protected access as *peerAuthentication*.

If you enable user authentication then you may either maintain accounts
within Derby, or work with an external directory service (such as LDAP).
The Security section of the Developers Guide provides an overview.

The Web interface is supplied as a WAR file in the *lib* subdirectory of
your Derby installation: *derby.war*. Refer to the Server and
Administration Guide for more information.

# Using Derby with JRuby on Rails #

JRuby on Rails supports both Java DB network database servers, and
embedded copies of Java DB. In the latter case, Java DB works in the
same way as SQLite works with the standard distribution of Rails -
databases are generated as required inside the application itself.

To use Java DB embedded databases, specify the Derby adapter and a path
in the config/database.yml configuration file of your JRuby on Rails
application:

~~~yaml
development:
  adapter: derby
  database: db/development.db

test:
  adapter: derby
  database: db/test.db

production:
  adapter: derby
  database: db/production.db
~~~

To configure your Rails application to use a Java DB network server,
your database.yml settings must specify the JDBC Active Record adapter,
set the Derby ClientDriver as the driver, and provide a URL. For
example:

~~~yaml
development:
  adapter: jdbc
  driver: org.apache.derby.jdbc.ClientDriver
  url: jdbc:derby://localhost:1527/myapp_development
~~~

# Finding the Documentation #

By default, the Windows version of Java DB installs to the folder:

    C:\Program Files\Sun\JavaDB\

Refer to the docs subdirectory for HTML and PDF versions of the
documentation. For example, to read the HTML version the Getting Started
guide, enter this URL in the address bar of your Web browser:

    file:///C:/Program%20Files/Sun/JavaDB/docs/html/getstart/index.html

The Ubuntu package *sun-javadb-doc* installs documentation to the
directory /usr/share/doc/javadb/. Enter this URL in the address bar of
your Web browser to see the documentation start page:

    file:///usr/share/doc/javadb/index.html

Unfortunately, the supplied documentation is somewhat poorly organized.
In particular, several topics of interest to administrators are actually
explained in the Developer Guide.
