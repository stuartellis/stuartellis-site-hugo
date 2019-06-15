+++
Title = "Linux Remote Desktop Access with VNC"
Slug = "vnc-on-linux"
Date = "2016-07-01T01:00:00+01:00"
Description = ""
Categories = ["devops"]
Tags = ["devops", "linux", "VNC"]
Type = "article"
Toc = true

+++


The VNC (Virtual Network Computing) facilities provide remote access to
desktops, and allow your Linux systems to act as terminal servers,
running many network-accessible desktops simultaneously. Unfortunately
the flexibility of VNC makes it less approachable than other remote
desktop solutions.

<!--more-->

I needed to setup VNC a few years ago, and could not find a tutorial
that thoroughly explained the permutations, so I wrote this one. It is
still here, and occasionally updated, since people continue to find it
useful.

> *Privileged Commands*: Commands that require root (administrative)
> privileges are shown with the pound sign (#). On Ubuntu, simply replace the
> hash with *sudo*.

# Understanding VNC #

The X-Window graphics system used by Linux and other UNIX-like systems
creates a desktop (a *display*) for the attached monitor (or *console*),
and may also create additional desktops on demand. VNC uses this feature
to run extra desktops on the system, and makes these desktops available
to client applications over the network. VNC terminology refers to
clients as *viewers*.

> *X Displays are Identified by Numbers*: The X-Window system identifies
> each display by a number. The console is always display 0 (zero).

You may run as many simultaneous displays as you wish with the
combination of VNC and X, limited only by the RAM and CPU capacity of
the computer. UNIX-like operating systems automatically support multiple
simultaneous users, and so any Linux or UNIX-like system may act as a
graphical terminal server with VNC.

In contrast, a standard Microsoft Windows system runs only one desktop
environment. It outputs this desktop to the monitor, and may share it
over the network using Remote Assistance. A VNC server for Windows
enables viewers to access this desktop.

> *Microsoft Windows May Run Multiple Desktops*: Windows Terminal
> Services turns on the support for multiple desktops that is included
> in Microsoft Windows. This facility create an extra desktop for each
> network client that connects to the server machine. The maximum number
> of simultaneous desktops is limited by the terms of your license.

On all systems, VNC only handles the display and graphical inputs, such
as keystrokes and mouse movements. To transfer files, printing or audio
between systems requires separate services. This document only discusses
VNC.

The standard VNC software also does not provide encryption itself, and
must rely on other facilities to protect the communications between the
client and the server. Refer to the SSH section of this document for
explanation of how to use SSH (Secure SHell) to encrypt VNC connections.

Several other remote desktop products use the same network protocol that
VNC clients and servers communicate with. This means that you may use
any VNC viewer to connect to any system that offers remote access with
the VNC protocol. Products with VNC support include:

* Apple Remote Desktop
* The desktop sharing features built in to the GNOME and KDE desktop
    environments
* Networked KVM (Keyboard Video Mouse) hardware made by Adder
* The installation software used by Fedora, Red Hat Enterprise Linux,
    and SUSE distributions

Some third-party products extend the VNC protocol to provide encryption
or other features, and such features will only work with a viewer that
supports those particular vendor extensions.

### Web Browser Access ###

Users may access desktops with VNC through their Web browser, without
needing to install separate viewer applications. VNC displays a desktop
within a browser window by running a Java applet, and this facility
should work on any system that has a JVM (Java Virtual Machine)
installed.

### VNC on Linux and UNIX ###

You may use VNC on Linux and UNIX systems in one of two ways:

* To create persistent desktops for specific users
* To provide desktops on demand for VNC connections

Both types of remote access can be active on the same system at the same
time.

In the first case you explicitly configure a desktop for each user.
Users may disconnect and reconnect from their desktops at any time. When
they reconnect to a VNC desktop they find it exactly as they left it.

If you enable the second type of configuration, the system creates and
drops desktops as users connect and disconnect. With this method, any
user that has a valid account on the system may login via VNC.

> *Web Access is for Persistent Desktops*: VNC may only provide Web
> access for persistent desktops.

# Installing the Software #

All of the main Linux distributions include VNC client and server
packages. Most distributions currently use software based on that
provided by RealVNC. SUSE uses TightVNC, and Fedora now uses TigerVNC,
which behave identically to products based on RealVNC.

On Debian and Debian-based systems, such as Ubuntu, install the
packages:

* *vnc4server* - the main VNC server software
* *vnc-java* - enables access from Web browsers with Java support
* *xvnc4viewer* - a basic VNC viewer

These packages automatically install the package vnc4-common as a
dependency.

To run on-demand VNC services on Fedora and Red Hat Enterprise Linux,
you must install the package xinetd.

### VNC Clients for Microsoft Windows ###

To run VNC on Microsoft Windows, install either
[UltraVNC](http://www.uvnc.com/), or one of the
[RealVNC](http://www.realvnc.com/) products. UltraVNC is a fully Open
Source and royalty-free alternative to RealVNC.

# Restricting VNC Access #

To secure access to VNC desktops, you may either set a password for each
user, or require users to go to a login screen and enter their username
and password there. You may use both options on the same system.

If you use the password method you create a VNC password for a user that
is independent of all other system passwords. With this security method,
viewers go directly to the user’s VNC desktop, and no login screen is
run. Without a login screen, users may only access accounts that have
specifically been configured with a VNC password.

The display manager service on your system provides login screens and
manages the login process. If you enable VNC access though a login
screen any user with an account on the system may both login remotely
with VNC, and set their own desktop options at the login screen. You
must configure the display manager to enable support for remote logins,
as explained below.

### Securing VNC Access with a Password ###

To set a password for direct access to your own VNC desktops, enter this
command in a terminal window:

    vncpasswd

This prompts you to type the password twice, and then writes an
encrypted version of this password to the file .vnc/passwd in your home
directory. This VNC password is separate from the normal password for
the account.

> *VNC Password Maximum Length*: For backwards compatibility, VNC
> supports a maximum password length of 8 characters.

### Providing Login Screens with XDMCP ###

To enable VNC to generate login screens on demand you must enable
support for XDMCP (X Display Manager Control Protocol) in the display
manager.

> *XDMCP Enables X-Window Remote Access* XDMCP is not specific to VNC in
> any way. If you enable it, standard X-Window software on other systems
> may also get a login screen and access a desktop.

Enabling XDMCP also has the side effect of allowing you to launch extra
desktops on the system itself. for example, this command creates a new
desktop on the local system as display number *1*:

    X -query localhost :1

Your system uses one of these display managers:

* GDM
* KDM from the KDE project
* xdm, which is supplied with X-Window software by default

GDM is the default for Fedora, Red Hat Enterprise Linux, Ubuntu, and
OpenSolaris systems. SUSE and Mandriva systems default to KDM. Few
modern systems use xdm.

To enable XDMCP for GDM, select *System > Administration > Login
Window* in your desktop. Choose a setting from *Remote > Style*. All of
the settings apart from *Remote login disabled* will activate XDMCP on
your system.

For KDM, edit this line to the configuration file kdmrc:

    [Xdmcp]
    Enable=true

The kdmrc file resides in /usr/share/config/kdm by default. Fedora
systems hold this file in /etc/X11/xdm/.

If you use xdm, edit the file /etc/X11/xdm/xdm-config, and look for this
line, which disables XDMCP listening:

    DisplayManager.requestPort: 0

Then edit the file /etc/X11/xdm/Xaccess to permit access from the
machine running the VNC server. Remove the comment marker at the
beginning of this line:

    * # Any host can get a login window

Restart the display manager service for the new settings to take effect.

On Debian and Ubuntu systems, enter this command in a terminal window to
restart GDM:

    # /etc/init.d/gdm restart

To restart GDM on Fedora and Red Hat Enterprise systems, use
gdm-restart:

    # /usr/sbin/gdm-restart

> *Restarting the Display Manager Closes All Running Desktops*: If you
> restart the display manager service then it also terminates all of the
> running graphical desktops.

# Configuring VNC To Provide On-Demand Desktops #

Use either xinetd or inetd to start start and manage on-demand VNC
services. Both xinetd and inetd launch services as they are required.
This means that VNC only runs on the system whilst a desktop is in use.

There must be one VNC service for each set of server options. Each VNC
service uses a separate TCP port.

> *Display Resolution is Per-Service*: To offer multiple screen
> resolutions, configure separate VNC services, as shown below.

Debian installs inetd by default. You must install xinetd on Fedora and
Red Hat Enterprise Linux systems.

### Registering the VNC Services ###

Register each VNC service in the /etc/services file. For example, these
lines register two VNC services:

    # Custom VNC services
    vnc-lowres 5950/tcp # Very low resolution VNC desktops on this system
    vnc-normalres 5951/tcp # Standard VNC desktops on this system

### Configuring the VNC Services ###

The example services shown below use the *geometry* option to set the
display resolution, and the *depth* option to set the color depth.

Specify the system that runs the actual desktops with the *query*
option. Set this option to *localhost* if the desktops should run on the
same system as the VNC services.

For systems that use inetd, add a line to /etc/inetd.conf for each VNC
service with the relevant options:

    vnc-lowres stream tcp nowait nobody /usr/bin/Xvnc
    Xvnc -inetd -query localhost -once -geometry 640x480 -depth 8 securitytypes=none
    vnc-normalres stream tcp nowait nobody /usr/bin/Xvnc Xvnc -inetd -query
    localhost -once -geometry 800x600 -depth 16 securitytypes=none

To configure VNC services with xinetd create a file called vncservers in
/etc/xinetd.d/. The following definitions are equivalent to those shown
above:

    service vnc-lowres
    {
      disable = no
      socket_type = stream
      protocol = tcp
      wait = no
      user = nobody
      server = /usr/bin/Xvnc
      server_args = -inetd -query localhost -once -geometry 640x480 -depth 8
      securitytypes=none
      log_on_failure += USERID
    }

    service vnc-normalres
    {
      disable = no
      socket_type = stream
      protocol = tcp
      wait = no
      user = nobody
      server = /usr/bin/Xvnc
      server_args = -inetd -query localhost -once -geometry 800x600 -depth 16 securitytypes=none
      log_on_failure += USERID
    }

By registering several services like this we may allow users to get
different options by connecting to different ports on the VNC system. In
the above example any number of users can connect on port 5951 and
receive a desktop on the server at 800x600 resolution and 16-bit color;
or use port 5950 and work on a lower resolution, perhaps for speed.

> *VNC Accepts Xserver Options*: The -query and -once options are
> X-Window settings rather than VNC-specific, and you can use other
> Xserver options if you wish. See the Xvnc and Xserver manual pages for
> a full list of options.

Restart inetd or xinetd for the new settings to take effect. On Debian
systems, enter the command:

    # /etc/init.d/inetd restart

On Fedora and Red Hat Enterprise Linux distributions, use the service
utility to restart xinetd:

    # /sbin/service xinetd restart

# Running Persistent Desktops #

I use the term *persistent desktop* to describe desktop sessions that
are maintained until either the server shuts down, or the session is
deliberately terminated. A user may disconnect or reconnect to the
session at any time.

### VNC Desktops on Red Hat and Mandriva Systems ###

The VNC implementations provided with Mandriva, Fedora, and Red Hat
Enterprise Linux have a facility for starting a set of VNC desktops on
system boot. Add a line for each user that requires a persistent VNC
desktop to the file /etc/sysconfig/vncservers:

    VNCSERVERS=“4:firstuser”
    VNCSERVERS=“5:seconduser”

To run more desktops, just keep adding them in the same way.

The system loads a desktop for each named user with the *display number*
listed as part of the boot process.

For other systems, use either xinetd or inetd to launch persistent VNC
desktops for specific user accounts, as described in the next section.

### Persistent Desktops with inetd or xinetd ###

The example below shows configurations for the account *youraccount*.
Replace *youraccount* with the relevant username.

The port assignment in /etc/services:

    vnc-youraccount 5953/tcp  # Persistent VNC desktop for youraccount

The definition in inetd.conf:

    vnc-youraccount stream tcp wait youraccount /usr/bin/Xvnc Xvnc -inetd -query localhost -once -geometry 800x600 -depth 16 passwordfile=/home/youraccount/.vnc/passwd

To do this with xinetd, create a file in /etc/xinetd.d/, with the
following service definition:

    service vnc-youraccount
    {
      disable = no
      socket_type = stream
      protocol = tcp
      wait = yes
      user = youraccount
      server = /usr/bin/Xvnc
      server_args = -inetd -query localhost -once -geometry 800x600 -depth 16 passwordfile=/home/youraccount/.vnc/passwd
      log_on_failure += USERID
    }

If you specify password files, then VNC launches the desktop directly
after the connection completes, rather than showing a login screen.

# Manually Launching VNC #

The basic command to launch a VNC-accessible desktop for yourself is
vncserver.

To manually launch a desktop uses two files within the .vnc/ directory:

* A .vnc/xstartup file of commands
* A .vnc/passwd file containing the encrypted version of a password

Refer to the section above on setting the password in .vnc/passwd.

> *Debian and Ubuntu Provide a Global VNC Configuration File*: Debian
> and Ubuntu include the file /etc/vnc.conf to provide global options
> for vncserver.

### Configuring the Startup Process ###

When a user runs vncserver, it executes the commands in .vnc/xstartup in
sequence. To launch a standard desktop environment, you must include a
command in the xstartup file.

This example xstartup file starts a GNOME desktop:

    # Run any global xstartup file for the system
    [ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup

    Run any .Xresources file for the user account
    [ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources

    # Start the vncconfig helper
    # This allows clipboard transfers and control of the desktop
    vncconfig -iconic &

    # Start a GNOME desktop
    exec gnome-session &

GNOME is the default desktop for Debian, Fedora, Red Hat Enterprise
Linux, Ubuntu, and OpenSolaris systems.

> *RealVNC Automatically Generates an xstartup File*: RealVNC creates an
> xstartup file if none exists, and this default configuration starts
> the obsolete twm environment. For this reason, create your own
> xstartup file.

For other desktops, substitute the gnome-session line in the example
with the appropriate command. For example, this command launches KDE:

    startkde &

KDE is the default for Kubuntu, Mandriva, and SUSE systems.

> *Using Alternative Desktops*: You may use different environments for
> local and VNC access. If you anticipate that you will run many VNC
> desktops on the same system, consider using a lightweight desktop
> system such as IceWM or XFCE for VNC logins.

Set the file permissions on xstartup to allow the user to execute them:

    chmod 700 ~/.vnc/xstartup

### Starting a VNC Desktop ###

To launch a desktop, run vncserver:

    vncserver

You may run this command without specifying any extra options. To assign
a specific display number to the VNC desktop, add the number to the
command. For example, to start a desktop as display number *4* enter the
command:

    vncserver :4

To start a VNC desktop on a remote system, use an SSH client to execute
vncserver on the remote system. The OpenSSH software automatically
installed on Linux, macOS, and other UNIX-like systems provides the
ssh client. As an example, this command uses ssh runs vncserver on the
system *server.example.com*, as the user *username*:

    ssh username@server.example.com vncserver

Refer to the later section for an explanation of how to use SSH to
provide encryption for your VNC connections.

# VNC and Firewalls #

In practice, you should use SSH port forwarding to access the TCP ports
that VNC uses on the remote system. This means that the firewall on the
remote system, and any intervening firewalls, only need to allow traffic
over TCP port 22 (the port for SSH). Refer to the SSH section for an
explanation.

The VNC configuration determines which TCP ports are involved in VNC
network access. Each VNC service run with inetd or xinetd uses the
specific TCP port defined in the service configuration. If you run a VNC
desktop for a specific user then it uses two ports for each desktop. The
main ports for each display start at 5900, so display 1 uses port 5901,
display 2 uses port 5902, and so on. The Web browser access feature uses
an additional port for each display, which by default is 100 ports lower
than the main port - 5801 for display 1, 5802 for display 2 etc.

> *Named Services*: If you have register VNC services in /etc/services
> you may refer to them by name in the firewall configuration for that
> system, rather than using the port numbers.

The X-Window system automatically uses a TCP port for each display,
starting at port 6000 for display 0. These ports do not have to be
accessible from remote systems for VNC to function.

# Accessing a VNC Desktop #

Linux desktops incorporate VNC clients for accessing remote desktops. On
any operating system you may use the vncviewer utility included with the
VNC software package, or a Web browser with Java support enabled. The
sections below explain these options in more detail.

### Specifying a VNC Display ###

Whichever client you use, specify the address of the display with one of
these formats:

* (system name or IP address)::(TCP port number for the display)
* server.example.com::5904

Alternatively, specify the display number rather than the TCP port:

* (system name or IP address):(display number)
* server.example.com:4

### Using the vncviewer Client ###

Run vncviewer without options to prompt for the server name and display.

You may specify the address as part of the vncviewer command:

    vncviewer server.example.com::5904

### Using VNC on GNOME ###

The Terminal Server Client on the default Ubuntu desktop supports VNC.
To run the Terminal Server Client, choose *Applications > Internet >
Terminal Server Client*. Enter the address of the remote *Computer*,
select VNC as the *Protocol* and choose *Connect*. Optionally, specify
your *Username* on that system.

To create a launcher for vncviewer on a GNOME desktop, right-click the
desktop, select *Create Launcher…*, and enter the full text of the
command in the *Command* field. Enter a *Name:* and *Comment:* in the
relevant fields. To choose a custom icon, click the icon box, which
reads *No Icon* by default. Select *OK* to confirm the settings and
create the launcher. You may then double-click the launcher to carry out
the command and run the remote application.

### Using a Web Browser {#vnc-web}

For Web access, type the appropriate URL in any Web browser that has
Java support enabled:

    http://server.example.com:port number for the display

### Securing VNC Connections with OpenSSH ###

The standard VNC software does not encrypt the connection between the
client and the server. In order to protect VNC communications, we can
simply use the *tunneling* feature of SSH secure remote access software.
Linux, macOS, and other UNIX-based systems include OpenSSH by
default.

For Windows systems, install the open source PuTTY suite, to provide SSH
facilities:

<http://www.chiark.greenend.org.uk/~sgtatham/putty/>

*Tunneling* enables you to associate ports on the local system with
ports on the remote system. The SSH software then forwards every
connection to the specified local ports on to the remote system over
it’s own secure connection. Associate your VNC connections with local
ports numbered higher than 1025, as these high ports may be used without
root privileges. As an example, this command runs vncserver on the
system *server.example.com* as the user *username* to create a new
desktop as display 3, and links TCP port 10903 on the local system to
port 5903 on the remote system:

    ssh -f -L -N localhost:10903:server.example.com:5903 username@server.example.com vncserver :3

To use the secure tunnel, point any VNC client on your system to
localhost:10903, rather than the actual server and port number. SSH will
transparently forward the connection.

As a bonus, SSH software may compress the traffic that it forwards,
improving the responsiveness of slow connections. To enable compression,
simply add the *-C* option to the ssh command:

    ssh -C -f -L -N localhost:10903:server.example.com:5903 username@server.example.com vncserver :3

> *Compression Slows Fast Connections*: SSH compression actually reduces
> the performance of faster connections. Use compression for dial-up
> connections, and avoid enabling it when accessing systems on local
> networks.

# Basic Troubleshooting on the VNC Host #

Here are the basic checks you should make on the Linux system:

* Check that there is a service active on the system to provide a
    desktop: type netstat -tl at a shell prompt to get a list of active
    ports.
* Try to connect to a desktop using a viewer program on the same
    computer, e.g. type vncviewer localhost:1 at a command prompt.
* Double-check that you are using the correct system name, and the
    correct port or display numbers.
* Check that the system firewall will permit connections on the
    relevant ports.
* Restart the firewall service (iptables on Linux), and inetd or
    xinetd on the server to ensure that the active configuration matches
    the files.

# Basic Troubleshooting on the VNC Viewer #

To troubleshoot problems with the viewer:

* Use nslookup (or ping -a in Windows) on the client to ensure that
    the server name will be converted to the correct IP address.
* Use ping from the client machine to make sure that packets can reach
    the IP address of the server.
* Check the firewall on the client to ensure that traffic will not be
    blocked.

# If The Viewer Just Shows a Grey Screen #

Don’t worry, you’ve simply forgotten a step - you haven’t specified a
window manager in your xstartup file. RealVNC runs the twm window
manager by default, which appears as a grey screen. This is the most
common issue for new users when setting up VNC for the first time.
