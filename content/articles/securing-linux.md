+++
Title = "Securing a Linux System"
Slug = "securing-linux"
Date = "2016-07-01T01:00:00+01:00"
Description = ""
Categories = ["devops"]
Tags = ["devops", "linux", "security"]
Type = "article"
Toc = true

+++


A tutorial on how to configure a fresh Linux installation for greater
security.

<!--more-->

# Before You Install a System #

The facilities provided by the installation system offer the most
convenient way to configure many of the features described here. For
this reason, consider how you will secure and update the system before
you install it. Popular distributions install tools to update individual
systems by default.

If you will be installing more than one copy of a distribution, carry
out a trial run, and use the test installation to create an *answer
file* that contains the settings for the final systems. The installation
software may take the setup options from your answer file, rather than
prompting you for every option. This enables you to decide the best
possible options at your leisure, and then have the installation
software automatically use them.

Many distributions support answer files, and include tools to generate
them. Debian uses the term *preseeding*. The equivalent facility for Red
Hat Enterprise and Fedora is known as *Kickstart*.

# Keeping Your System Updated #

> *Update Your System Immediately After Installation*: Software
> development moves so rapidly that updates will exist for any operating
> system. To ensure that your system does not include any known
> vulnerability, run the update process immediately after you have
> completed the installation.

To carry out a full system update on Linux systems, follow the
instructions in the documentation. Each distribution provides specific
tools for installing and updating software.

If you manually install software without using the supplied tools, you
must check and update those products yourself. To ensure that you have
the latest versions of any manually installed software, subscribe to
email or *RSS* services that notify you when new versions are released.
Most software providers now offer such an announcement service for their
products.

# Enabling BIOS Security #

Always use the security options in your computer
BIOS (Basic Input/Output System). These ensure that attackers may not
quickly circumvent security by booting the computer with another
operating system:

1. Set the BIOS, or firmware, of your machine to boot from the drive
that holds the Linux system.
2. Disable booting from all other devices.
3. Enable the option in the BIOS to require a password for access to
BIOS settings.
4. For portable systems, enable the option in the BIOS to require a
password to boot the machine.

# Securing the GRUB Boot Loader #

If you specify a password for GRUB (Grand Unified Bootloader), users
must *unlock* the boot menu and give the correct password before they
may access the maintenance utilities built in to the boot loader. You
can also restrict access to the options on the menu itself, so that
users may only choose particular boot options after successfully
unlocking.

The best time to set a boot loader password is during the installation
process. Some distributions also include tools to configure GRUB after
installation. On all systems you may set a password for GRUB with the
following procedure:

1. In a terminal window, type /sbin/grub-md5-crypt.
2. When prompted, specify the password that you wish to use.
3. Note the *MD5* hash that appears. This holds the password that you
specified in an encoded format.
4. Add the following line to the file /boot/grub/menu.lst:

    password --md5 MD5-HASH

Replace *MD5-HASH* with the hash that you generated with grub-md5-crypt.

You must have root access to edit /boot/grub/menu.lst.

Reboot the system for the change to take effect.

To protect a specific boot configuration, add the *lock* option after
the *title*. For example:

    title Fedora (2.6.17-1.2157_FC5)
    lock
    root (hd0,0)
    kernel /vmlinuz-2.6.17-1.2157_FC5 ro root=/dev/VolGroup00/LogVol00 rhgb quiet

Debian and Ubuntu systems enable you to lock all of the recovery mode
and custom boot options with one setting. To lock all non-standard boot
options, edit /etc/boot/grub/menu.lst, and change *lockalternative* to
*true*. Leave the comment marker in place.

    # lockalternative=true

Then run the update-grub utility to update the active boot
configuration:

    # update-grub

Refer to the project Web site for more information about the facilities
provided by GRUB:

<http://www.gnu.org/software/grub/>

## Enabling Password Security for Recovery Mode ##

Recovery mode (or *single-user mode*) boots the system without
activating a network connection, using only the minimum processes needed
to allow a login. If the sulogin facility is enabled on the system,
users must enter the root password in order to access a system that is
in recovery mode. Debian systems enable sulogin by default.

To enable password security for single-user mode on other Linux systems,
add the following line to the file /etc/inittab:

    ~~:S:wait:/sbin/sulogin

You must have root access to edit /etc/inittab.

This change takes effect the next time that you boot the system.

> *Ubuntu and sulogin*: Ubuntu configures sulogin by default, but
> actually permits unrestricted access with single-user mode unless you
> have enabled the root account. To enhance the security of Ubuntu
> systems, consider locking the non-standard boot options, as described
> in the previous section.

## Disabling Special Key Combinations ##

Linux systems support several key combinations that may override the
normal running of the system. The well-known *Ctrl-Alt-Delete* key
combination triggers a graceful shutdown of the system. Linux also
supports *Magic SysRq*, a set of key combinations that send instructions
directly to the kernel.

These enable users to control an unresponsive system, but may also be
used by malicious users to bring down a running system. For this reason,
you may wish to disable them on publicly accessible computers.

## Disabling Ctrl-Alt-Delete ##

To disable the *Ctrl-Alt-Delete* key combination, add a comment marker
(#) to the start of the relevant line in /etc/inittab:

    # ca:12345:ctrlaltdel:/sbin/shutdown -t1 -a -r now

You must have root access to edit /etc/inittab.

This change takes effect the next time that you boot the system.

## Disabling SysRq ##

To disable the *Magic SysRq* facility, add this to /etc/sysctl.conf:

    kernel/sysrq=0

You must have root access to edit /etc/sysctl.conf.

This change takes effect the next time that you boot the system.

# Managing User Accounts #

Create one account per user, with a strong password. If possible,
configure your systems to use the accounts provided by a centralized
authentication service, rather than creating accounts on each system.
Centralized services enable you to enforce strong passwords and other
security policies across the systems on the network. They also ensure
that the logins for your systems remain current and easy to verify.

The section below explains strong passwords.

> *Manage Local Accounts with the Tools Provided*: Use the tools
> supplied with your distribution to manage the local accounts, rather
> than editing the account files directly. Errors in these files may
> prevent you from logging in to the system.

Each user should log in to the system with their own account. A user may
cause configuration and data files in their own home directory to be
damaged or deleted, but they may not modify system files, nor may they
alter the files in the home directories of others. Use su or sudo to
safely obtain root privileges when carrying out administrative tasks.

## Avoid Generic and Shared Accounts ##

Automated cracking programs use standard and generic account names like
admin and guest for their login attempts. Only enable remote access to
uniquely identifiable accounts that are associated with a named
individual.

## Understanding Strong Passwords ##

Automated password cracking programs include multiple dictionaries for
one or more languages, in order to be able to identify any password that
is based on a standard word or name. Password cracking programs are also
often able to identify a word even if characters are substituted.

* *Use Phrases Instead of Single Words*: To produce a long and
    memorable password, use a phrase instead of a single word.
* *Create Unique Passwords*. Avoid using the same password or key for
    more than one system.
* *Use a combination of upper case letters, lower case letters,
    numbers, and punctuation.* This ensures that your passwords may not
    be easily identified.
* *Use at least 8 characters in your passwords.* Each character in the
    password multiplies the difficulty of guessing the complete
    password. Avoid passwords with less than 6 characters, as these are
    too weak.

> *Obsolete Software May Limit Password Length*: Modern systems support
> extremely long passwords. Obsolete software may reject or truncate
> passwords that are longer than 8 characters.

Configure PAM (Pluggable Authentication Modules) modules to enforce
password requirements for local user accounts on the system.

If possible, use authentication keys rather than passwords for
SSH (Secure SHell) remote access. SSH keys are considerably more complex
than passwords. By default, the *OpenSSH* service on Linux prompts the
user for a password if they do not provide a key, but you may configure
it to require keys for all logins.

The well-known tool John the Ripper demonstrates how vulnerable weak
passwords are to modern cracking techniques. Administrators commonly use
this utility to audit the accounts on their network. For more
information about the capabilities of John the Ripper, refer to the Web
site:

<http://www.openwall.com/john/>

## Securing Home Directories on Debian and Ubuntu ##

Debian and Ubuntu systems create world-readable home directories by
default. This allows users on a shared system to conveniently access
files in each other’s home directories. In many cases, administrators
may wish to change this default.

To disable world-readable home directories, enter this command in a
terminal window:

    # dpkg-reconfigure adduser

Choose *No* to world-readable home directories. This changes the default
permissions for home directories from *0755* to *0751*.

> *Existing Home Directories Remain Accessible*: This change affects how
> adduser creates new home directories. Existing home directories remain
> accessible.

# Managing Access to Administrator Privileges (root) #

To perform administrative tasks at the command-line, log in to your
system with a standard user account, and use either su or sudo to run
commands in a terminal with the privileges of the root account. The
graphical administrative tools supplied with your Linux distribution
automatically prompt for a password as required.

Ubuntu systems lock the root account, and configure sudo by default.
Most distributions require you to manually configure sudo.

## root Access with su ##

The su utility enables you to acquire the privileges of another account.
By default, su switches your terminal session to root privileges. This
means that all of the commands executed in that session run with
unrestricted access to the system, until the session is restored back to
normal status. If possible, use su -c or sudo to run individual commands
with root access, rather switching the privileges of the whole session.

To give a terminal session root privileges and settings with su, enter
the following command:

    su -

Specify the root password when prompted.

To return the session to unprivileged status, type exit:

    exit

To use su to run a command with root privileges, type su -c, followed by
the command. Enclose the command in quotes. For example, this line runs
the command /sbin/shutdown -h now:

    su -c '/sbin/shutdown -h now'

Specify the root password when prompted.

Read the info manual on your system for details of the su command:

    info su

## Controlled root Access with sudo ##

If you have several administrators for a system, configure sudo to
enable each administrator to carry out commands with root access.

> *Only One Administrator Needs the root Password*: Authorized sudo
> users use their own password to run root commands with sudo. For this
> reason, only one administrator needs to know the root password for a
> system that runs sudo.

Administrators may also use the sudo facility to grant groups or user
accounts root privileges for specific applications. This enables you to
delegate certain administrative tasks without giving either the root
password, or unrestricted access to root privileges.

More importantly, sudo logs all of the commands that it executes to
/var/log/auth.log. This ensures that every administrative command is
recorded, and may be traced to an individual user account. In the event
of a system problem this audit trail may provide valuable information.

As a convenience, sudo prompts a user for their password only once
within a certain time period. If the user runs runs sudo again within
that period the command is automatically authorized. By default, the
period is 15 minutes.

> *Use visudo to Edit the sudo Configuration*: Use the visudo command to
> edit the configuration file for sudo. This utility ensures that the
> modified configuration is consistent before it becomes active.

To grant full root access to all members of the admin group, use the
following line in the sudo configuration file:

    %admin         ALL = (ALL) ALL

Once you configure privileges for groups you may manage access to sudo
by adding or removing accounts from the designated groups.

To grant an individual account full root access, specify the name of the
account. This line grants full privileges to the exampleuser account:

    exampleuser    ALL = (ALL) ALL

To use sudo to run a command with root privileges, type sudo, followed
by the command. For example, this line runs the command
/sbin/shutdown -h now:

    sudo /sbin/shutdown -h now

If prompted, enter the password for your account.

To edit a file with root privileges, type sudoedit, followed by the name
of the file. For example, to edit /etc/nsswitch.conf, enter the
following:

    sudoedit /etc/nsswitch.conf

If prompted, enter the password for your account.

> *Use gksu for Graphical Applications*: To run graphical applications
> in the GNOME desktop environment with the sudo facilities, use the
> gksu utility.

Refer to the man page for sudoers for detailed information on
configuring the sudo facility. The man page for sudo explains how to use
the sudo utility.

    man sudoers
    man sudo

# Setting Login Restrictions #

Linux systems use the pam_unix or pam_unix2 module to authenticate
users with the local account files. Many distributions also enable some
other PAM modules by default. For example, Red Hat Enterprise Linux and
Fedora systems use pam_cracklib by default. Debian and Ubuntu systems
automatically use pam_motd for the login service.

The relevant PAM modules for account security are:

* pam_cracklib - enforces password quality checks
* pam_limits - enforces resource limits on user accounts
* pam_motd - prints a message on the screen after the user logs in
* pam_tally - enforces a maximum number of unsuccessful login attempts
* pam_time - limits access to services by time

*Debian Supplies Cracklib Separately*: Debian provides pam_cracklib as
a separate package: libpam-cracklib. Install either pam_cracklib or the
stronger pam_passwdqc module. The package libpam-passwdqc provides
pam_passwdqc.

## Configuring PAM ##

On many distributions, the PAM configuration file for each service
imports settings from a central set of files. This enables you to
configure PAM for all of the services on the system by editing the main
configuration.

Red Hat and Fedora provide /etc/pam.d/system-auth for central PAM
configuration.

Debian-based systems use four files:

* /etc/pam.d/common-account - modules that restrict access by valid
    users
* /etc/pam.d/common-auth - modules that handle user authentication and
    group membership
* /etc/pam.d/common-password - modules that handle password changes
* /etc/pam.d/common-session - modules that set up facilities for valid
    users during the login process

## Ensuring Strong Passwords with PAM ##

Red Hat and Fedora systems include the pam_cracklib password complexity
check in their default configuration. For Debian and Ubuntu systems,
install either pam_cracklib or pam_passwdqc.

Use pam_cracklib to provide simple password checks. To ensure extremely
strong passwords, install pam_passwdqc. Non-technical users may find
the default settings for pam_passwdqc too demanding.

To enable password complexity checks on Debian and Ubuntu systems with
pam_passwdqc, use these settings in /etc/pam.d/common-password:

    password required pam_unix.so use_authtok md5
    password required pam_passwdqc.so

Alternatively, to enable checks with pam_cracklib, use these settings
in /etc/pam.d/common-password:

    password required pam_unix.so use_authtok md5
    password required pam_cracklib.so retry=1 minlen=6 difok=3

## Enforcing Resource Limits with PAM ##

The pam_limits module applies the hardware resource limits set in
/etc/security/limits.conf to each account that logs in. Set resource
limits to ensure that users cannot slow down or crash the system by
running programs that consume all of the available computer resources.

> *root is Exempt From All Resource Limits*: Resource limits do not
> apply to the root account, or any program that it runs.

Several distributions enable pam_limits by default for the login
services, but define no limits in the supplied configuration file. The
site administrator sets appropriate limits for the system. Red Hat,
Fedora, Debian and Ubuntu enable pam_limits by default.

For other distributions, add the following line to the PAM configuration
files for cron, login, ssh and su:

    session required pam_limits.so

The relevant files are:

* /etc/pam.d/cron
* /etc/pam.d/login
* /etc/pam.d/ssh
* /etc/pam.d/su

Once pam_limits is active, edit the configuration file to define
resource limits. The configuration file explains the format. Below is a
simple configuration:

    # —- Resource Limits for an Application Server —-
    #

    1.  “Soft” limits are defaults that users may change.
    2.  “Hard” limits may not be altered by users.
        #
    3.  Note that the root account is always exempt from all resource
        limits.

    # Disable core dumps

    * hard core 0

    # Restrict sessions to 20Mb each

    * hard rss 20000

    # Maximum of 20 processes per user

    * hard nproc 20

    # Allow upto 2 logins per user, in case a session crashes

    * - maxlogins 2

Resource limits take effect for logins immediately after the
configuration file is saved.

> *The cpu Limit Eventually Terminates Sessions*: The *cpu* limit
> defines the maximum amount of CPU time that a session may use before
> it is forced to log out.

## Protecting Network Services from Attack ##

Every system connected to the Internet is eventually checked by
automated cracking programs. Such programs frequently run on systems
that have already been compromised by crackers, or infected with a
virus. Compromised systems constantly check thousands of Internet
addresses for active systems that use specific network services, and
attack those that they find. These attacks may be defeated by simple
countermeasures.

> *Security is Built on Good Decisions*: You may significantly reduce
> the number of issues that you deal with, simply by carefully selecting
> the services and Web applications that run on your systems.

## Selecting Services ##

Expose the minimum number of services possible. Certain types of service
are inherently unsafe, and if possible you should avoid them:

* *FTP*: Use SSH or HTTP (with *WebDAV* for write access) instead
* *NFS*: Use version 4 between trusted systems on private networks,
    and avoid previous versions
* *NIS*: Use LDAP with SSL or Kerberos instead
* *The “r” suite of utilities* (e.g. rexec, rlogin): Superseded by SSH
* *Telnet*: Superseded by SSH

To block the installation of unsafe services on Debian and Ubuntu
systems, add the harden-servers package.

Use the forwarding features of SSH, or separate
VPN (Virtual Private Networking) software, to *tunnel* remote access to
any unsafe services through more secure connections. For example, you
must protect *syslog* and VNC (Virtual Network Computing), as neither
facility encrypts their communications.

The popular DNS server BIND requires extra caution, due to a history of
security problems. For this reason Debian provides a package to run BIND
in a chroot environment. Current versions of Fedora and Red Hat
Enterprise Linux automatically use SELinux (Security Enhanced Linux) to
restrict BIND. If you use BIND, ensure that your distribution uses
version 9 rather than any earlier version, and enable the distribution
security features. Alternatively, use a different Open Source DNS
server, such as Dnsmasq, MaraDNS, or PowerDNS.

## Choose Web Applications with Care ##

By their nature Web applications may be exposed to the public Internet,
accept information from remote systems, and often have access to
valuable data. Research a Web application carefully before you deploy
it. Some applications have a history of security problems that may stem
from poor design or development practices.

For each application that you choose to run, apply all of the security
recommendations that the documentation describes. If you install a Web
application manually, rather than from packages provided by your
distribution, subscribe to a relevant email or *RSS* service to receive
news of security alerts and product updates.

## Configuring Services ##

Unless a particular service is intended for public or global access,
configure it to only accept connections from the specific networks or
systems that should have access to it. For information on how to secure
a service, refer to the documentation for the product. Although
attackers may configure their systems to falsely claim to have another
name or IP address, access restrictions defeat casual attacks.

> *Remote Access to Email and Printers*: By default, the email, logging,
> and printing services provided by Linux distributions reject
> connections from remote systems. Only enable remote access to these
> services if you intend the system to provide facilities for other
> systems.

You should not assume that every system on your network is trustworthy,
nor should you disable security features for internal clients. Many
legitimate products exist that can conveniently reach internal systems
by traversing NAT, and bypass standard firewalls by using HTTP. The
spread of wireless access and laptops also mean that systems may be
connected to your network without actually being authorized or
maintained.

In all cases, only provide remote users with write access to files or
databases if it is necessary. Certain services, like HTTP file transfer,
provide read-only access by default. If a file sharing or database
service permits users to edit the data that it provides, ensure that
access is protected by key-based authentication or strong passwords.

## Ensure That The Security Features are Enabled! ##

The OpenSSH service automatically encrypts all of the communications
between SSH clients and the server, as well as providing a means for
clients to verify the identity of remote servers.

You must configure most other services to use a security facility for
identification and encryption. Use either SSH, Kerberos, or TLS (also
known as SSL), as the product documentation describes.

## Apply New Updates Rapidly ##

Many attacks attempt to exploit known vulnerabilities in Web
applications or network services, and may be defeated by running current
versions with a safe configuration.

Once a new vulnerability is known, providers modify their software to
address the issue and release a new version. Attackers also quickly
begin to run automated tests for vulnerable systems, in order to make
use of the delay between the announcement of a vulnerability and the
application of updates.

To avoid becoming vulnerable, you must plan to apply important updates
to your publicly accessible systems within a period of hours, rather
than days. Do not hesitate to restrict access to non-critical services
until they are updated. If a system becomes compromised it may not only
affect your own data, but that system could also be used to carry out
attacks on others.

## Understand Firewalls and Their Limitations ##

The *netfilter* framework included in the Linux kernel restricts
incoming and outgoing network connections according to a set of rules
that have been defined by the administrator. Fedora, Mandriva, Red Hat,
and SUSE automatically configure netfilter to act as a firewall, and
supply their own graphical configuration utilities. You must manually
configure and enable the firewall on Debian and Ubuntu systems. Current
releases of Ubuntu include a command-line utility called *ufw* for
firewall configuration.

You may also manage the firewall rules on any Linux system with the
standard *iptables* and *ip6tables* command-line utilities, or with
third-party utilities such as
[Firestarter](http://www.fs-security.com/). If you decide to use
iptables, remember that it only configures restrictions for IP version 4
connections, and that you will need to use ip6tables to setup rules for
IP version 6 as well.

A correct firewall configuration blocks incoming connections to all
services, except those that should be available over the network, and
all outgoing connections, except those needed for clients to operate.
Treat the firewall as a fail-safe measure to protect you against human
error, as no service should accept network connections unless it has
been specifically configured for the required purpose, and you should be
aware of all of the network client software installed on the system.

Once a service has been configured for remote connections then a
firewall can only offer two defenses: it can restrict access to ports
based on the source, and it can rate-limit connections to prevent
attackers overloading the server. Whether you configure access
restrictions on the service or through the firewall is a matter of
choice.

# Configuring a Backup System #

You must select a backup system that best matches your particular
circumstances. The programs listed here are widely-used and well
maintained, but you may find other applications that better suit your
needs.

## Popular Backup Software ##

The command-line tool rdiff-backup provides simple backup and recovery
facilities:

<http://www.nongnu.org/rdiff-backup/>

This utility may backup to either local storage, or other systems over a
network connection. To further customize the backup process to your
needs, write a script and add it as a scheduled job for cron.

BackupPC enables you to backup multiple computers to a central server
over the network, and incorporates a Web interface for easy management:

<http://backuppc.sourceforge.net/>

Client computers may run Windows, macOS, or any Linux distribution.

If you need advanced backup facilities for a larger network, use
[Bacula](http://www.bacula.org/) or [Amanda](http://www.amanda.org/).
Both of these provide a central backup service that may be accessed by
multiple clients over a network, and can manage tape media.

> *Database Backups Require Specialized Tools*: Always use dedicated
> tools to backup your LDAP and SQL databases. Simply copying the
> transaction logs and storage files for an active database service may
> produce inconsistent data.

Configure backups to run automatically on a schedule. If you rely on
manual backups you may later find that you do not have copies of
important versions of your files.

## Important Files to Backup ##

Configuration files:

* /boot/grub/menu.lst - Boot loader menu configuration file
* /etc/ - Main directory for configuration files
* /var/backups/ - Backup copies of key files (Debian and Ubuntu only)

Log files:

* /var/log/ - Main directory for log files

Data files:

* /root/ - Home directory for the root account
* /home/ - Main directory for all user home directories
* /var/spool/mail/ - Directory that holds all mailboxes
* /var/www/ - Directory for the main Web site

> *Applications May Use Non-Standard Locations*: Some applications may
> default to non-standard locations for their configuration, data, or
> log files. Always check the locations of the key files when you
> install a new application or service, especially if the software was
> not provided by your distribution.

## Enabling Email Reports ##

Automated processes on your Linux system use the email (SMTP) service to
send reports to the system administrator. If installed, the logwatch
script sends an overall status report each day at 4am. Fedora and Red
Hat Enterprise Linux systems include logwatch by default.

> *Ubuntu Has No Email Service by Default*: Ubuntu does not include an
> email service by default. To enable system reports from an Ubuntu
> system, install the logwatch package, and an email service of your
> choice. The nullmailer and postfix packages both provide efficient and
> secure email services.

Follow the instructions below to configure the email service on your
system to deliver these messages to a remote email address, rather than
a local mailbox:

Edit the file /etc/aliases. Change the line:

    root: root

Replace the second root with your email address. For example:

    root: me@example.com

Save the file, and close the text editor.

You must have root access in order to edit the aliases file.

To update the email server configuration with the new alias, run the
newaliases command.

    # newaliases

The newaliases command requires root privileges.

> *Exim Does Not Require newaliases*: The Exim mail service
> automatically registers changes to the aliases file. You do not need
> to run the newaliases command on systems that use Exim as their email
> service. Debian systems include Exim by default.

## Restricting Task Scheduling ##

Current Linux systems include four mechanisms for users to schedule
tasks. You may wish to disable user access to these on your servers.

The task schedulers are:

* at - runs a task once, at a specific time in the future
* batch - runs a particular task when the system load drops below a
    specified value
* cron - runs tasks at specific times according to a schedule
* anacron - periodically runs specified tasks when the system is
    available

> *The atd Service Manages Both at and batch*: The cron and anacron
> facilities each use a separate service. Both at and batch both rely on
> the atd service.

## Restricting Access to at and batch ##

All accounts listed in /etc/at.deny may not use the at and batch
facilities. To block all user access to these facilities, create an
/etc/at.allow file:

    # touch /etc/at.allow

If an /etc/at.allow file exists, then no user may access at or batch
unless their account is explicitly listed in that file. Each facility
checks for an at.allow file before reading at.deny.

## Restricting Access to cron ##

To restrict user access to cron, create a file called /etc/cron.allow.
If this file exists, cron limits access to specific users. Only those
users listed in the file may schedule tasks with cron.

Use the touch command to create an empty cron.allow file:

    # touch /etc/cron.allow

If a /etc/cron.deny file exists it provides the reverse of cron.allow.
It enables all users to access cron, *except* those whose usernames are
listed in cron.deny.

> *Choose One Restriction File*. To avoid confusion, use either a
> cron.allow file or a cron.deny file, but not both.

Debian and Ubuntu do not provide either a cron.allow file or a cron.deny
file. Fedora and Red Hat Enterprise Linux systems include a cron.deny
file by default.

# Subscribing to Security Announcement Services #

## Distribution Announcement Services {#announce-distros}

Each distribution vendor notifies users of security issues through email
announcements or *RSS feeds*. For example, the Debian project announces
all security issues on this dedicated mailing list:

<http://lists.debian.org/debian-security-announce/>

To subscribe to email security announcements for Ubuntu distributions,
visit this Web page:

<http://lists.ubuntu.com/mailman/listinfo/ubuntu-security-announce>

Red Hat provide security updates and information to their customers
through the Red Hat Network service.

## US-CERT Bulletins {#announce-cert}

US-CERT provide security advisories for all commonly used operating
systems and software. If you administer a range of systems, subscribe to
the weekly *Cyber Security Bulletin*:

<https://forms.us-cert.gov/maillists/>

# Adding Anti-Virus Software #

Install anti-virus software if you provide network services for users
that work on Microsoft Windows systems, or regularly exchange files with
unprotected Windows systems.

Your distribution may include packages for ClamAV software. ClamAV scans
files for viruses and malware, and may be used by applications and
network services such as email servers. The ClamAV project provide free
updates for new malware as it is discovered.

The clamtk desktop virus scanner uses ClamAV:

<http://clamtk.sourceforge.net/>

Refer to the ClamAV project Website for more information on the ClamAV
software:

<http://www.clamav.net/>

Several commercial vendors offer a range of anti-virus products for
Linux systems. Refer to their Web sites for details.

# Additional Security Measures for Servers #

These facilities provide specific defenses against attempts to
compromise a server:

* [Samhain](http://www.la-samhna.de/samhain/index.html) - Host
    integrity monitoring for single systems and groups of servers
* [Fail2Ban](http://fail2ban.sourceforge.net/) - Dynamically modifies
    system firewall rules to block attacks

# Security Checklists #

## Securing the Boot Process ##

* Set the BIOS, or firmware, of your machine to boot from the drive
    that holds the Linux system
* Disable booting from all other devices
* Enable the option in the BIOS to require a password for access to
    BIOS settings
* For portable systems, enable the option in the BIOS to require a
    password to boot the machine
* Lock the GRUB boot loader by setting a password
* Ensure that access to single-user mode requires a password

## Using Your System Safely ##

* Use strong passwords for your accounts
* Log in with a standard user account
* Perform administrative tasks that require root access with su, sudo,
    or the supplied configuration tools
* Only install software or plug-ins from trusted sources
* Discard emails if you do not recognize the source
* Only keep or copy a file if you know the original source of that
    file

## Secure System Configuration ##

* Create one system account per active user
* Configure password complexity checking, to ensure strong passwords
* Set reasonable resource limits
* Enable email reports
* If a number of users require some form of administrative access,
    configure sudo rather than distributing the root password
* Use SSH for remote access to the system
* If possible, require SSH keys rather than passwords for remote
    access
* Only enable additional network services if they are necessary
* If possible, configure services to allow connections only from
    specific IP addresses that you know
* Only configure a network service to allow write access to files if
    it is necessary
* If you expect to receive infected files, install and configure
    anti-virus software
* Consider limiting access to task scheduling

## Routine Security Tasks ##

Linux distributions include tools for all of the tasks below. Much of
this work can, and should, be automated. Human administrators must of
course check that the scheduled scripts and processes are operating
correctly.

* Check your RSS and email subscriptions for relevant security
    announcements
* Update the system regularly
* If you install anti-virus software, update the virus signature data
    at least once a day
* Create backups of data and configuration files
* Lock user accounts that are no longer required
* Deactivate any network services that are no longer required
* Check the log files for unusual activity
