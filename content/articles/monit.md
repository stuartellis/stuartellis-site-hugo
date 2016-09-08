+++
Title = "Monitoring and Self-Healing Services with Monit"
Slug = "monit"
Date = "2016-07-01T01:00:00+01:00"
Description = ""
Categories = ["administration"]
Tags = ["linux", "monitoring"]
Type = "article"

+++


There are many service monitoring products, but
[Monit](http://mmonit.com/monit/) is unusual. It tests for specific
conditions and carries out actions when they occur, rather than
collecting for analysis and graphing. Monit is frequently used to
improve the robustness of systems.

<!--more-->

# Overview #

Monit can monitor several kinds of resources: the running system itself,
individual processes (such as network services), filesystems, or
particular files and directories. If none of these are appropriate, you
can configure it to run custom scripts to test the conditions that you
are interested in.

In each case, Monit’s default action is to send an email alert if the
condition is met - the service has stopped, the file does exist, or
whatever you have configured. If you specify a different type of
response, Monit sends an email alert and performs the response that you
have specified.

Monit itself runs as a small background service. The built-in HTTP
server is both provides a Web interface for remote access, and supports
the command-line utility. Several of the features of the command-line
utility only function if the HTTP server is enabled. By default, the
Monit Web server listens on TCP port 2812.

# Installing Monit #

The quickest way to install Monit is to use the package manager for your
system. For example, on Debian and Ubuntu systems, install the **monit**
package with APT:

    sudo apt-get install monit

You can install Monit on Mac OS X with [Homebrew](http://mxcl.github.com/homebrew/):

    brew install monit

# Example Configuration #

Below is an example configuration file for Debian and Ubuntu.

    # Perform checks every 2 minutes
    set daemon 120

    # Log to a file
    set logfile /var/log/monit.log

    # Locations of files used by Monit itself
    set statefile /var/lib/monit/state
    set idfile /var/lib/monit/id

    # If possible, use a remote mail server instead
    set mailserver localhost

    # Queue unsent alerts
    set eventqueue
    basedir /var/lib/monit/events
    slots 100

    # Global defaults for email alerts
    set mail-format { from: monit@myserver.mydomain.com }
    set alert me@mydomain.com

    # Username and password pair to enable command-line client.
    # This also allows Web access to users from the “adm” local group,
    # but only from localhost
    set httpd port 2812 and use address localhost
      allow localhost
      allow admin:“A-PASSWORD”
      allow @adm

    # Include any files in the conf.d directory
    include /etc/monit/conf.d/*

An example configuration for monitoring the health of the system:

    # check system localhost
    if loadavg (1min) \> 4 then alert
    if loadavg (5min) \> 3 then alert
    if memory usage \> 75% then alert
    if cpu usage (user) \> 70% then alert
    if cpu usage (system) \> 30% then alert
    if cpu usage (wait) \> 20% then alert

    # check filesystem root-filesystem with path /
    if space usage is greater than 75% for 5 cycles then alert

Some example configurations for common services:

    # Monitors the cron task scheduling service
    check process cron with pidfile /var/run/crond.pid
      start program “/etc/init.d/cron start”
      stop program “/etc/init.d/cron stop”
      if 5 restarts within 5 cycles then timeout

    # Monitors the rsyslog logging service
    check process rsyslog with pidfile /var/run/rsyslogd.pid
      start program “/etc/init.d/rsyslog start”
      stop program “/etc/init.d/rsyslog stop”
      if 5 restarts within 5 cycles then timeout

    # Monitors the SSH remote access service
    check process sshd with pidfile /var/run/sshd.pid
      start program “/etc/init.d/ssh start”
      stop program “/etc/init.d/ssh stop”
      if failed port 22 protocol ssh then restart
      if 5 restarts within 5 cycles then timeout

    # Monitors the MySQL database service
    check process mysql with pidfile /var/run/mysqld/mysqld.pid
      start program “/etc/init.d/mysql start”
      stop program “/etc/init.d/mysql stop”
      if failed port 3306 protocol mysql then restart
      if 5 restarts within 5 cycles then timeout

    # Monitors the PostgreSQL database service
    # This uses the “root” PostgreSQL role and database.
    # PostgreSQL will record errors if these do not exist.
    check process postgresql with pidfile /var/run/postgresql/9.1-main.pid
      start program “/etc/init.d/postgresql start”
      stop program “/etc/init.d/postgresql stop”
      if failed unixsocket /var/run/postgresql/.s.PGSQL.5432 protocol pgsql then restart
      if 5 restarts within 5 cycles then timeout

    # Monitors the Nginx HTTP server
    check process nginx with pidfile /var/run/nginx.pid
      start program “/etc/init.d/nginx start”
      stop program “/etc/init.d/nginx stop”
      if failed port 80 protocol http then restart
      if 5 restarts within 5 cycles then timeout

    # Monitors the Postfix mail server
    check process postfix with pidfile
      /var/spool/postfix/pid/master.pid
      start program “/etc/init.d/postfix start”
      stop program “/etc/init.d/postfix stop”
      if failed port 25 protocol smtp then restart
      if 5 restarts within 5 cycles then timeout

Debian and Ubuntu both provide a directory called */etc/monit/conf.d/*,
so that you do not need to edit the main configuration file. If you add
configuration files into this directory, remember to change their
permissions:

    sudo chmod 600 /etc/monit/conf.d/*
