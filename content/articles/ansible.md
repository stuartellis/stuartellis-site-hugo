+++
Title = "Managing Systems with Ansible"
Slug = "ansible"
Date = "2019-04-14T07:46:00+01:00"
Description = "An introduction to Ansible"
Categories = ["administration"]
Tags = ["administration", "python"]
Type = "article"

+++

[Ansible](http://www.ansible.com) provides an Open Source framework for automation. It is used for managing servers and network devices, as well as many other tasks.

<!--more-->

# How Ansible Works

First, you set up Ansible and the required configuration files on a _control machine_, which can just be the workstation of an administrator.

Ansible runs tasks on either the control machine, or remote systems. Tasks are usually defined in _playbooks_. The tasks in a playbook are run in order, from the first task to the last. Playbooks are YAML files.

Each time that you run a task, this calls a _module_ of code that connects to the relevant systems, and sends the appropriate commands to carry out the task. The list of available systems is known as the _inventory_, and individual systems are referred to as _nodes_.

Modules for managing UNIX-like systems connect to the target nodes with SSH and then send Python code to the nodes. The Python interpreter on each node executes the code. Both SSH and Python are installed on most Linux systems, and are part of macOS. There are also modules to execute actions with more basic methods, such as the
Bash shell that is the default for both macOS and GNU/Linux distributions.

Other types of modules use the appropriate network protocols and commands for their purpose. For example, the Ansible modules for Microsoft Windows send commands to PowerShell, using the PowerShell remoting facility.

This means that you can
manage almost any system with Ansible, possibly starting with tasks that use low-level modules to install the prerequisites for the more complex operations.

Ansible modules for online services work slightly differently. These modules connect from the control machine to the relevant server or cloud, and use the API that the service provides to send commands to it.

If you need a central service for managing tasks and nodes, Red Hat offer
[Ansible Tower](https://www.ansible.com/products/tower). The software for Ansible Tower is developed as an Open Source project, called [AWX](https://github.com/ansible/awx). You may use AWX, rather than pay for Ansible Tower, but the project does not provide user support or long-term maintenance for releases. None of the features of Ansible itself rely on Ansible Tower or AWX.

# Setting Up a Control Machine

To set up Ansible on a macOS or Linux system using [Homebrew](http://brew.sh/), enter these commands in a terminal window:

    brew update && brew install ansible

Alternatively, use [pipx](https://pypi.org/project/pipx/) to install Ansible:

    pipx install ansible

## Installing Extra Packages

Ansible modules from _extras_ may require additional Python packages. If you installed Ansible with pipx, use the _inject_ subcommand to add the package to the correct virtual environment. For example, this command adds _boto3_ to the Ansible installation:

    pipx inject ansible boto3

If you use _pip_, add the _--user_ option to install Python packages into your home directory, rather than globally. For example, this command installs _passlib_ into your home directory with _pip_:

    pip install --user passlib

# Creating A Repository

You should always store your Ansible code in version control. For convenience, you may put the Ansible playbooks in the root of your repository.

Exclude the _ansible.cfg_ file itself from version control. Consider putting an example of the expected _ansible.cfg_ file in the repository. This enables each person that works with the repository to use their own configuration file, by copying the example file.

> Use the [Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html) feature to encrypt
> any YAML file that stores password variables.

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

# The Repository Directory Structure

Create the directories that you need within the repository. You can define playbooks as single YAML files, so in some cases, you do not need to create any directories at all.

These are standard directories for Ansible projects:

- examples/ - Various other templates and examples
- filter_plugins/ - Custom filter plugins
- host_vars/ - Variables for individual host systems
- inventory/ - Lists of nodes
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

# Managing Microsoft Windows Systems

Ansible 2.1 and above support managing Windows systems. This means that they may
communicate with Windows nodes using the WinRM and PowerShell Remoting
facilities that are built-in to current versions of Windows, and also include
specific modules for Windows features.

Each Windows node must meet these requirements to be managed with Ansible:

- PowerShell 3.0 or above must be installed
- PowerShell Remoting with WinRM must be enabled
- The firewall must allow remote TCP connections to port 5986 (WinRM over HTTPS)

The [Ansible documentation on Windows](https://docs.ansible.com/ansible/latest/user_guide/windows_setup.html) includes a PowerShell script to set up remote access for you.

# A Note on Generating Passwords

You must specify the SHA512 hashed version of a user password when you set it
through Ansible. By default, macOS does not generate the same hashes as
Linux, so you should install the Python module _passlib_ to provide a hash
generator that behaves consistently across operating systems. To generate a
valid hash with _passlib_ enter this command in a terminal window:

    python -c "from passlib.hash import sha512_crypt; import getpass; print sha512_crypt.encrypt(getpass.getpass())"

Enter the password that you would like to use at the prompt.

Any YAML file that stores password variables should be encrypted using the [Vault](http://docs.ansible.com/playbooks_vault.html) feature of Ansible.

# Recommended Tools

- [Ansible Lint](https://docs.ansible.com/ansible-lint/) - Maintained by the Ansible team
- [Molecule](https://molecule.readthedocs.io/) - Official test framework for Ansible roles
- [Visual Studio Code extension for Ansible](https://marketplace.visualstudio.com/items?itemName=vscoss.vscode-ansible) - Maintained by Microsoft

# Third-Party Tools

- [Ansible interactive tutorial](https://github.com/turkenh/ansible-interactive-tutorial)
- [ARA](https://ara.recordsansible.org/) - Ansible plugin to record playbook activity for support and troubleshooting

# Resources

- [Ansible Documentation](https://docs.ansible.com/)
- [Ansible Module Index](https://docs.ansible.com/ansible/latest/modules/modules_by_category.html) - Documentation for the modules that are provided with Ansible
- [Ansible for DevOps](https://www.ansiblefordevops.com), by Jeff Geerling - The most popular book on Ansible
- [Ansible Lightbulb](https://ansible.github.io/lightbulb/) - Material for running training workshops on Ansible
