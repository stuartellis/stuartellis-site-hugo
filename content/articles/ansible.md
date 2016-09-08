+++
Title = "Managing Systems with Ansible"
Slug = "ansible"
Date = "2016-07-01T01:00:00+01:00"
Description = "An introduction to Ansible"
Categories = ["administration"]
Tags = ["administration", "python"]
Type = "article"

+++

[Ansible](http://www.ansible.com) provides an Open Source tool for provisioning,
configuring and orchestrating changes on systems that is fundamentally much
simpler and more flexible than older tools such Puppet and Chef. This makes it
suitable for a very wide range of requirements, from setting up a few
workstations to deploying applications and updates across hundreds or thousands
of servers.

<!--more-->

# How Ansible Works #

Unlike most other products in this area, Ansible does not require a central
service or use dedicated agents on each system. Instead, you only install
Ansible and your configuration on a *control machine*, which can just be the
workstation of an administrator. Each time that you perform an operation with
Ansible, it connects to the required systems and streams code to a standard
run-time that is already installed on the target. The managed systems are
referred to as *nodes*.

Most Ansible modules connect to the target systems with SSH and run Python 2,
both of which are installed on most Linux systems, and are part of Mac OS X.
There are also modules to execute actions with more basic methods, such as the
Bash shell that is the default for both Mac OS X and GNU/Linux distributions.
The Ansible modules for managing Microsoft Windows systems send commands to
PowerShell, using the PowerShell remoting facility. This means that you can
manage almost any system with Ansible, possibly starting with low-level modules,
and using them to install the prerequisites for the more complex operations.

If you do need a central service for coordinating changes or maintaining
detailed inventories of systems, Ansible Inc. sell
[Tower](http://www.ansible.com/tower), but this product is not needed for any of
the features of Ansible itself.

# Setting Up A Mac OS X Control Machine #

To set up Ansible on a Mac OS X workstation using [Homebrew](http://brew.sh/)
enter these commands in a terminal window:

    brew update && brew install ansible

Ansible modules from *extras* may require additional Python packages. If you
need to install more Python packages, use *pip*. To install *pip*, enter this
command in a terminal window:

    sudo easy_install pip

Install Python modules into your home directory, rather than globally. If you
use *pip*, add the *--user* option. For example, this command installs the
*passlib* module into your home directory:

    pip install --user passlib

# Creating A Repository #

You should always store your Ansible configuration in version control. Git is
effectively the standard version control tool, and works perfectly for this
purpose.

For convenience, I would put the Ansible playbooks in the root of your
repository, along with a copy of *ansible.cfg*, the configuration file.

Use the [Vault](http://docs.ansible.com/playbooks_vault.html) feature to encrypt
any YAML file that stores password variables.

# An Example Ansible Configuration File #

This is a simple *ansible.cfg* file:

    [defaults]

    # SSH settings
    remote_user = ansibler
    remote_port = 1234
    pipelining = True

Replace *ansibler* with the name of a user account that has administrative
privileges on the target systems (this means *sudo* for UNIX-based systems).
Replace *1234* with the port number of the SSH service on the target systems.

The
[pipelining](http://docs.ansible.com/ansible/intro_configuration.html#pipelining)
option significantly increases the performance of Ansible over SSH.
Unfortunately, it means that commands that require root access will fail if
*sudo* has the *requiretty* option enabled.

# Source Control Exclusions #

If you are using Git, create a *.gitignore* file, otherwise define exclusions
however is appropriate for your version control system (for example, a
*.hgignore* file for Mercurial).

I would recommend that you always exclude the *ansible.cfg* file from version
control, and put an example configuration file in the repository instead. This
allows each administrator that works with the repository to use their own
configuration file.

# The Repository Directory Structure #

Create the following directories within the repository:

* examples/ - Various other templates and examples
* filter_plugins/ - Custom filter plugins
* host_vars/ - Variables for individual host systems
* inventory/ - Lists of host systems
* group_vars/ - Variables for groups of systems  
* library/ - Custom Ansible modules
* roles/ - Custom roles used by the Ansible playbooks
* scripts/ - Utility scripts

The *examples/* and *scripts/* directories are useful for storing your own work,
but are not essential. These directories are not used by Ansible itself.

# Using Ansible #

Ansible provides three main commands:

* *ansible-playbook* - to execute all of an Ansible playbook on the specified
systems
* *ansible* - to execute an individual shell command or Ansible module
 on the specified systems
* *ansible-vault* - to encrypt or decrypt any individual YAML file that Ansible uses.

Both *ansible-playbook* and *ansible* require you to specify the group of
systems that the commands will run on, and use *-i* to specify the *inventory*,
which is the file or directory that lists the specified systems. The *all* group
is a built-in group that automatically includes all of the systems in the
specified inventory.

    COMMAND GROUP -i INVENTORY OPTIONS

Each utility will connect to each of the nodes in the group and execute the
required commands. If a command fails on one or more of the nodes, a *retry*
file is created to enable you to run the commands again on only the failed
nodes.

Use the *ansible* command with the *-a* option to execute a shell command:

    ansible all -i inventory -a /usr/bin/uptime

Use *-m* to execute an Ansible module:

    ansible all -i inventory -m ping
    ansible all -i inventory -m setup

The *ping* module checks that Ansible can connect to the remote system. The
*setup* module returns information about the remote system.

To run a playbook:

    ansible-playbook -K -i inventory my_playbook.yml

The *-K* option means that Ansible will prompt you for the password of your
account on the remote system in order to use *sudo*.

Add *--syntax-check* to test the Ansible playbook without running it:

    ansible-playbook --syntax-check -K -i inventory my_playbook.yml

Add *--check* to simulate the effect without making changes to the target systems:

    ansible-playbook --check -K -i inventory my_playbook.yml

If the playbook requires data from a file that has been encrypted with
*ansible-vault*, add  *--ask-vault-pass*:

    ansible-playbook --ask-vault-pass -K -i inventory my_playbook.yml

Enter the password for the encrypted files when prompted.

# Using Ansible to Manage Microsoft Windows Systems #

Ansible 2.1 and above support managing Windows systems. This means that they may
communicate with Windows nodes using the WinRM and PowerShell Remoting
facilities that are built-in to current versions of Windows, and also include
specific modules for Windows features.

Each Windows node must meet these requirements to be managed with Ansible:

* PowerShell 3.0 or above must be installed
* PowerShell Remoting with WinRM must be enabled
* The firewall must allow remote TCP connections to port 5986 (WinRM over HTTPS)

The [Ansible documentation on Windows](http://docs.ansible.com/ansible/intro_windows.html) includes a PowerShell script to set up remote access for you.

# A Note on Generating Passwords #

You must specify the SHA512 hashed version of a user password when you set it
through Ansible. By default, Mac OS X does not generate the same hashes as
Linux, so you should install the Python module *passlib* to provide a hash
generator that behaves consistently across operating systems. To generate a
valid hash with *passlib* enter this command in a terminal window:

    python -c "from passlib.hash import sha512_crypt; import getpass; print sha512_crypt.encrypt(getpass.getpass())"

Enter the password that you would like to use at the prompt.

Any YAML file that stores password variables should be encrypted using the [Vault](http://docs.ansible.com/playbooks_vault.html) feature of Ansible.
