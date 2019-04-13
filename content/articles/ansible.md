+++
Title = "Managing Systems with Ansible"
Slug = "ansible"
Date = "2019-04-13T15:48:00+01:00"
Description = "An introduction to Ansible"
Categories = ["administration"]
Tags = ["administration", "python"]
Type = "article"

+++

[Ansible](http://www.ansible.com) provides an Open Source tool for automation. It is used for managing servers and network devices, as well as other tasks.

<!--more-->

# How Ansible Works

Ansible runs task on either the local computer, or remote systems. It does not require a central
service or use dedicated agents on each system. Instead, you install
Ansible and your configuration on a _control machine_, which can just be the
workstation of an administrator. Each time that you perform an operation with
Ansible, it connects to the required systems and streams code to one of the standard run-times that are already installed on the target. The managed systems are
referred to as _nodes_.

Most Ansible modules connect to the target systems with SSH and run Python 2,
both of which are installed on most Linux systems, and are part of macOS.
There are also modules to execute actions with more basic methods, such as the
Bash shell that is the default for both macOS and GNU/Linux distributions.
The Ansible modules for managing Microsoft Windows systems send commands to
PowerShell, using the PowerShell remoting facility. This means that you can
manage almost any system with Ansible, possibly starting with low-level modules,
and using them to install the prerequisites for the more complex operations.

If you need a central service for coordinating changes or maintaining
detailed inventories of systems, Red Hat offer
[Ansible Tower](https://www.ansible.com/products/tower). This is developed as an Open Source project, called [AWX](https://github.com/ansible/awx). You may use AWX, but there are no guarantees of support or stability. None of the features of Ansible itself rely on Ansible Tower or AWX.

# Setting Up A macOS Control Machine

To set up Ansible on a macOS workstation using [Homebrew](http://brew.sh/)
enter these commands in a terminal window:

    brew update && brew install ansible

Ansible modules from _extras_ may require additional Python packages. If you
need to install more Python packages, use _pip_.
Install Python modules into your home directory, rather than globally. If you
use _pip_, add the _--user_ option. For example, this command installs the
_passlib_ module into your home directory:

    pip install --user passlib

# Creating A Repository

You should always store your Ansible configuration in version control. Git is
effectively the standard version control tool, and works perfectly for this
purpose.

For convenience, I would put the Ansible playbooks in the root of your
repository, along with a copy of _ansible.cfg_, the configuration file.

Use the [Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html) feature to encrypt
any YAML file that stores password variables.

# An Example Ansible Configuration File

This is a simple _ansible.cfg_ file:

    [defaults]

    # SSH settings
    remote_user = ansibleuser
    remote_port = 1234
    pipelining = True

Replace _ansibleuser_ with the name of a user account that has administrative
privileges on the target systems (this means _sudo_ for UNIX-based systems).
Replace _1234_ with the port number of the SSH service on the target systems.

The
[pipelining](http://docs.ansible.com/ansible/intro_configuration.html#pipelining)
option significantly increases the performance of Ansible over SSH.
Unfortunately, it means that commands that require root access will fail if
_sudo_ has the _requiretty_ option enabled.

# Source Control Exclusions

If you are using Git, create a _.gitignore_ file, otherwise define exclusions
however is appropriate for your version control system (for example, a
_.hgignore_ file for Mercurial).

Always exclude the _ansible.cfg_ file from version control, and put an example configuration file in the repository instead. This
allows each administrator that works with the repository to use their own
configuration file.

# The Repository Directory Structure

Create the following directories within the repository:

- examples/ - Various other templates and examples
- filter_plugins/ - Custom filter plugins
- host_vars/ - Variables for individual host systems
- inventory/ - Lists of host systems
- group_vars/ - Variables for groups of systems
- library/ - Custom Ansible modules
- roles/ - Custom roles used by the Ansible playbooks
- scripts/ - Utility scripts

The _examples/_ and _scripts/_ directories are useful for storing your own work,
but are not essential. These directories are not used by Ansible itself.

# Using Ansible

Ansible provides three main commands:

- _ansible-playbook_ - to execute all of an Ansible playbook on the specified
  systems
- _ansible_ - to execute an individual shell command or Ansible module
  on the specified systems
- _ansible-vault_ - to encrypt or decrypt any individual YAML file that Ansible uses.

Both _ansible-playbook_ and _ansible_ require you to specify the group of
systems that the commands will run on, and use _-i_ to specify the _inventory_,
which is the file or directory that lists the specified systems. The _all_ group
is a built-in group that automatically includes all of the systems in the
specified inventory.

    COMMAND GROUP -i INVENTORY OPTIONS

Each utility will connect to each of the nodes in the group and execute the
required commands. If a command fails on one or more of the nodes, a _retry_
file is created to enable you to run the commands again on only the failed
nodes.

Use the _ansible_ command with the _-a_ option to execute a shell command:

    ansible all -i inventory -a /usr/bin/uptime

Use _-m_ to execute an Ansible module:

    ansible all -i inventory -m ping
    ansible all -i inventory -m setup

The _ping_ module checks that Ansible can connect to the remote system. The
_setup_ module returns information about the remote system.

To run a playbook:

    ansible-playbook -K -i inventory my_playbook.yml

The _-K_ option means that Ansible will prompt you for the password of your
account on the remote system in order to use _sudo_.

Add _--syntax-check_ to test the Ansible playbook without running it:

    ansible-playbook --syntax-check -K -i inventory my_playbook.yml

Add _--check_ to simulate the effect without making changes to the target systems:

    ansible-playbook --check -K -i inventory my_playbook.yml

If the playbook requires data from a file that has been encrypted with
_ansible-vault_, add _--ask-vault-pass_:

    ansible-playbook --ask-vault-pass -K -i inventory my_playbook.yml

Enter the password for the encrypted files when prompted.

# Using Ansible to Manage Microsoft Windows Systems

Ansible 2.1 and above support managing Windows systems. This means that they may
communicate with Windows nodes using the WinRM and PowerShell Remoting
facilities that are built-in to current versions of Windows, and also include
specific modules for Windows features.

Each Windows node must meet these requirements to be managed with Ansible:

- PowerShell 3.0 or above must be installed
- PowerShell Remoting with WinRM must be enabled
- The firewall must allow remote TCP connections to port 5986 (WinRM over HTTPS)

The [Ansible documentation on Windows](http://docs.ansible.com/ansible/intro_windows.html) includes a PowerShell script to set up remote access for you.

# A Note on Generating Passwords

You must specify the SHA512 hashed version of a user password when you set it
through Ansible. By default, macOS does not generate the same hashes as
Linux, so you should install the Python module _passlib_ to provide a hash
generator that behaves consistently across operating systems. To generate a
valid hash with _passlib_ enter this command in a terminal window:

    python -c "from passlib.hash import sha512_crypt; import getpass; print sha512_crypt.encrypt(getpass.getpass())"

Enter the password that you would like to use at the prompt.

Any YAML file that stores password variables should be encrypted using the [Vault](http://docs.ansible.com/playbooks_vault.html) feature of Ansible.

# Official Tools

- [Ansible Lint](https://docs.ansible.com/ansible-lint/)
- [Molecule](https://molecule.readthedocs.io/) - Official test framework for Ansible roles
- [Visual Studio Code extension for Ansible](https://marketplace.visualstudio.com/items?itemName=vscoss.vscode-ansible)

# Third-Party Tools

- [Ansible interactive tutorial](https://github.com/turkenh/ansible-interactive-tutorial)
- [ARA](https://ara.recordsansible.org/) - Ansible plugin to record playbook activity for support and troubleshooting

# Resources

- [Ansible for DevOps](https://www.ansiblefordevops.com), by Jeff Geerling - The most popular book on Ansible
- [Ansible Lightbulb](https://ansible.github.io/lightbulb/) - Material for running training workshops on Ansible
