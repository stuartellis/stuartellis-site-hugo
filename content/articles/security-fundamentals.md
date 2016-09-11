+++
Title = "Computer Security Fundamentals"
Slug = ""
Date = "2016-07-01T01:00:00+01:00"
Description = "security-fundamentals"
Categories = ["administration"]
Tags = ["administration", "linux", "security", "windows"]
Type = "article"

+++


There are many, many articles on configuring particular software or
operating systems for security. The quality varies widely, and most of
them miss out one or more important points. Perhaps a better approach
might be to start with the basic concepts, and then apply those to the
system, rather than just working with lists of tweaks. Here is an
attempt to define some of the basic technical issues of computer
security, in plain language.

<!--more-->

# Computer Security Threats #

Although new viruses and security flaws are announced daily, threats
fall into several well-understood categories. Various threats of these
types have been in existence for many years, and a wide range of
approaches have been developed to mitigate or remove the risks that they
pose. Today, developers may design applications and network services to
avoid behavior that is known to be potentially unsafe, and implement
specialized countermeasures within the main operating system itself.
Current operating systems include both technologies that can operate
with a high level of security, as well as various built-in defenses
against particular classes of attack.

The common types of threat to networked computer systems include:

* *Malicious Software Applications*, such as *viruses*, often designed
    to modify the host system or transmit data from the host to other
    systems without the approval of a user
* *Malicious Servers* created to exploit vulnerabilities in the
    software that accesses them
* *Unauthorized Access through Network Services* by specialized
    cracking tools that are designed to gain access to the target system
    over the network
* *Denial of Service Attacks* that make an accessible service or
    system unable to function, usually by deliberately overloading the
    target
* *Interception of Information* transmitted between systems over a
    network
* *User Behavior* such as accidental errors and, more rarely,
    deliberate attempts to compromise the system

# Encryption and Verification are Central #

All data encryption software provides one or both of these separate
guarantees:

* That there is no risk that data has been *disclosed* to any
    unauthorized person
* That data has not been *tainted*, or secretly modified by an
    unauthorized person

Sometimes, the potential for doubt is more significant than the actual
risks. A particularly sensitive document might have to be treated as
being compromised if there is any possibility that has been disclosed or
tampered with, even if there is no certainty that either has actually
occurred.

In many situations, the second type of guarantee is much more
significant. Even data that is meant to be public might become a risk if
it was to be modified by a malicious person. This may be prevented by
simply providing checksums for the files that you publish, or by
digitally signing each file. Many popular desktop applications on all
platforms may now verify signed files on behalf on the user. All
UNIX-like systems also include utilities for both checksums to test that
the contents of a file match the original, and for digital signatures to
associate files with a verifiable identity.

The same defenses also offer a way to protect against data corruption or
permanent loss. Once a file has been signed or a checksum has been made
for it, every copy can be tested at any time against the signature or
checksum. If a signed or checksummed file is intended to be published
then you actually improve security by making as many copies as possible.
Once the file has been distributed it cannot be lost if an individual
system fails, and any of the copies can be verified to ensure that they
are valid.

Content encryption encodes a copy of a file, so that it may not be read
at all without providing the designated passphrase or key. To be sure
that genuinely sensitive information has not been disclosed, you must
encrypt the contents of every copy. If an unencrypted copy exists, then
you cannot guarantee that the information has not been accessed.

Encrypting the stored copies of files introduces a different risk - that
users may become unable to access their own data by forgetting
passphrases or losing keys. This must be balanced against the
consequences of disclosure or tampering, and the correct trade-off
depends upon the circumstances. In some cases, the possible consequences
of a third-party obtaining the information held in a particular file are
more severe than the consequences of losing the data altogether.

HTTP and most other network protocols support the option of encrypted
transfers, so that you may ensure that information cannot be disclosed
or intercepted as it is transmitted over a network. UNIX-like systems
use SSH by default, which automatically encrypts all communications
between the sender and the receiver. Such encrypted transfers only
protect information whilst it is being transmitted, and cannot safeguard
the cached or stored copies on each system.

Every program and piece of data that a system actively uses must be
loaded into memory (RAM), and these in-memory copies must also be
protected from attack.

# Systems Must Protect Memory As Well As Storage #

An attacker with access to a system can bypass many defenses by leaving
the stored copies of programs and data untouched, and attempting to
modify the copies that are in memory instead. Current versions of most popular
operating systems all use memory protection features by default, and so
there is now no reason to accept an operating system that does not
automatically provide them. Look for *buffer overflow* defenses
(commonly known as *stack-smashing protection*),
ASLR (Address Space Layout Randomization), and *executable space
protection*.

> *Executable Space Protection May Require a 64-bit Operating System*:
> Executable space protection works best with the support built-in to
> 64-bit processors, and for backward-compatibility, several Linux
> distributions disable the feature when they run on 32-bit
> Intel-compatible machines. To ensure that executable space protection
> functions correctly, you must run a 64-bit version of the operating
> system on a 64-bit computer.

Unfortunately, many operating systems weaken security by not enabling
their swap security features by default. Every mainstream operating
system today extends the amount of memory available by configuring
*virtual memory*, also known as *swap*. This ensures that a system will
keep functioning if it uses all of the physical memory available, as
some of the contents of the memory will simply be *swapped out* to the
virtual memory area on disk, and *swapped in* again when required. It
also means that sensitive data may be written from memory to the swap
file or partition. If the swap area is not either wiped or encrypted
when the system shuts down then an attacker with access to the system
can read any information still in the virtual memory.

# The Importance of Physical Security #

Data encryption and verification actually provide the only effective
defenses against an attacker with physical control over the system. An
attacker with physical access to a machine can ignore network security,
and may eventually circumvent any other software security measure in
place, regardless of the operating system. There is no substitute for
restricting physical access to systems and data.

In practice, though, many computers today must be physically accessible.
A laptop or smart phone is a portable computer by definition. For this
reason, always store copies of your data on systems that are held in
secure locations. Where possible, avoid keeping sensitive information on
portable or easily accessible computers.

The section below discusses encrypted storage facilities that enable you
to protect the data on systems that cannot be kept in safe locations.

> *Case Security*: To reduce the risks of casual tampering or theft, fit
> locks on machines that will be used in controlled but publicly
> accessible locations. Many computer cases include either padlock
> loops, or slots for Kensington notebook locks.

You must also protect backup media, such as tapes. Anyone with access to
a backup of a system may read or copy files that have been held on that
system, including the password databases. Again, consider using
encryption to protect the data stored on backup media from unauthorized
access.

# Vulnerabilities in the Computer Boot Process #

Standard computers use three components in their boot process, each of
which must be protected:

* The BIOS (Basic Input/Output System), or firmware, of the computer
* The *boot loader* that manages access to all of the installed
    operating systems
* The boot process for each operating system, which may load that
    system in one of several *modes*, some of which may use reduced
    security

Once a computer starts, the BIOS activates the hardware and starts the
boot loader software on either an internal hard drive, or a removable
device. The boot loader generates a menu of options, and may launch one
of the operating systems by default. Most operating systems install a
boot loader that also enables users to customize the boot process and
run built-in maintenance tools.

If the BIOS is not password protected, then anyone with physical access
to the machine may configure it to boot from a disc or removable device,
and load an operating system of their own choosing. Once this occurs,
any unencrypted file on the machine itself may be compromised.

Attackers may also gain unrestricted access to files through the boot
loader, by using custom boot options or the boot loader maintenance
utilities to access an installed operating system. These methods may
also allow them to partially boot and use an existing operating system
without having to enter a username or a password. For this reason, you
should set a boot loader password to limit boot options to predefined
choices, or your system may be compromised before any operating system
security can take effect.

Every popular operating system may be booted in one of several preset
*recovery*, *safe*, or *single-user* modes which only load a limited
version of the system. These enable you to access a partially
functioning system in order to repair it. To make system recovery more
convenient, the default configurations of several Linux distributions
also enable a system to start in a single-user mode and offer a command
prompt without requiring any password from a user. Ensure that you
enable security for the built-in single-user or recovery mode, unless
the computer is held in a restricted location, such as a server room.

# Understanding Viruses and Spyware #

Computer viruses run in an operating system or application to embed
copies of themselves into files, such as emails, documents, and
programs. These infected files may be transferred to other systems by
users. Some viruses also trigger email or file sharing features to
directly copy themselves to other systems.

Almost all computer viruses today use, and require, specific features in
Microsoft products in order to reproduce themselves. Some spyware
programs also use features of Microsoft products to install themselves
on Windows systems without the consent of a user. Other spyware products
for Windows claim to provide useful features, in order to convince users
to install them. Products from other vendors do not have the legacy
design flaws that have made automated malware so common on Microsoft
products. This does not mean that other software is immune to malware -
no popular operating system today can protect itself against software
that a user deliberately chooses to install.

OpenSolaris and most Linux systems have some defense against malicious
software, in the form of approved software distribution channels. All of
the software initially installed on these systems is supplied by the
distribution provider, and a range of additional software is also
packaged by the provider, and offered from known sites. Administrators
may choose to only install software that has been packaged and tested by
the distribution provider, and avoid the need to trust any software that
is offered by third-parties.

> *Avoid Copying or Sending Suspicious Emails and Files*: All operating
> systems may store or forward files that are infected with viruses. Any
> virus will remain within an infected file even if the file passes
> through a system that is immune to the enclosed virus.

# Security is Risk Management #

Software products vary widely in quality and security. In all cases, the
responsibility is on administrators to know the capabilities and
limitations of the software available to them, and consider the overall
security of the infrastructure that they maintain. The key is always to
consider the whole system and environment, in the light of the points
described above.

Beyond that, the most effective way to further reduce risk is to
minimize the amount of software on any system. Current versions of
popular operating systems offer options for *minimal* installations,
which provide the least software needed for a functional system. This
can be combined with the automated installation options to guarantee
that every system starts with a known, low risk configuration. Further
software can then be added in a controlled manner.

A large number of security problems today arise from a small number of
products that are known to be higher risk, and you may significantly
improve the security of your systems simply by knowing these, and
minimizing your use of them. When you evaluate new products, look at the
security alerts that have been issued. A high risk product will have a
history of security problems, often involving variations of the same
class of vulnerability.

As most users do not evaluate the security of their software, you should
not assume that either the popularity of any individual product or the
size of the provider are any measurement of security. History has proven
that even severe security lapses have little long-term effect on the
popularity of a product, or the financial success of vendors.
Unfortunately, unsafe products may remain extremely popular and widely
used even after superior alternatives have become available.

The final risk factor is the responsiveness of the software maintainer.
No software is risk-free, and the most secure configuration may be
compromised at any time by a newly uncovered bug in one of the software
components. Where possible, choose software whose maintainers disclose
issues and fixes promptly and responsibly. Again, vendors vary widely,
and the best insurance is good research by the system administrators.
