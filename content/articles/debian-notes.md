+++
Title = "Notes on Debian"
Slug = "using-debian"
Date = "2018-11-25T10:45:00+01:00"
Description = ""
Categories = ["devops"]
Tags = ["debian"]
Type = "article"
Toc = true
Draft = true

+++

Notes on Debian Linux.

<!--more-->

# Documentation and Help

### Web Sites

Refer to this Web site for the Debian official documentation:

- [http://www.debian.org/doc/](http://www.debian.org/doc/)

The Debian Wiki may also be useful:

- [http://wiki.debian.org/FrontPage](http://wiki.debian.org/FrontPage)

The _debianhelp.co.uk_ site provides a good reference:

- [http://www.debianhelp.co.uk/](http://www.debianhelp.co.uk/)

The _Debian Administration_ site has tutorials for a wide range of topics:

- [http://www.debian-administration.org/](http://www.debian-administration.org/)

### Security Announcements

To subscribe to email security announcements from the Debian project, visit this Web page:

- [http://lists.debian.org/debian-security-announce/](http://lists.debian.org/debian-security-announce/)

### Supplied Documentation

Debian packages install their documentation to /usr/share/doc/package-name/. The standard files are compressed to save space. To unpack a compressed README.Debian.gz, use gunzip -c:

    gunzip -c /usr/share/doc/package-name/README.Debian.gz | less

The dwww and dhelp packages provide support for browsing the installed documentation as HTML.

### Books

_The Debian System_, by Martin F. Krafft, is highly recommended. It is available as PDF or hard-copy.

It assumes that you already have a basic familiarity with Linux, and focuses on the distinctive features of the Debian project and operating systems.

# Debian Statistics and Data

The _popularity-contest_ package sends an anonymous summary of the software currently installed on each system to the Debian project each week. This also indicates the computer architecture of the systems as well. As users may disable popularity-contest the information is not complete, but it is interesting.

Go to [http://popcon.debian.org/](http://popcon.debian.org/) to see the statistics gathered by the popularity-contest system.
