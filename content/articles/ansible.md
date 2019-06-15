+++
Title = "Task Automation with Ansible"
Slug = "ansible"
Date = "2019-04-27T13:47:00+01:00"
Description = "The Ansible task automation framework"
Categories = ["automation", "python"]
Tags = ["ansible", "automation", "devops", "python"]
Type = "article"
Toc = true

+++

[Ansible](http://www.ansible.com) provides an Open Source framework for automation. It is most well-known for managing servers and network devices, but you can use Ansible to automate almost any task.

<!--more-->

# How Ansible Works

First, set up a copy of Ansible and the required configuration files on a _control machine_, which can just be the workstation of an administrator.

Ansible runs tasks on either the control machine, or remote systems. Tasks are usually defined in _playbooks_. The tasks in a playbook are run in order, from the first task to the last. Playbooks are YAML files.

Each time that you run a task, this calls a _module_ of code that connects to the relevant systems, and sends the appropriate commands to carry out the task. The list of available systems is known as the [inventory](https://docs.ansible.com/ansible/latest/user_guide/intro_inventory.html), and individual systems are referred to as _nodes_.

### Managing Systems with Ansible

Modules for managing UNIX-like systems connect to the target nodes with SSH and then send Python code to the nodes. The Python interpreter on each node executes the code. Both SSH and Python are installed on most Linux systems, and are part of macOS. There are also modules to execute actions with more basic methods, such as the Bash shell that is the default for both macOS and GNU/Linux distributions.

Other types of modules use the appropriate network protocols and commands for their purpose. For example, the Ansible modules for Microsoft Windows send commands to PowerShell, using the PowerShell remoting facility.

This means that you can
manage almost any system with Ansible, possibly starting with tasks that use low-level modules to install the prerequisites for the more complex operations.

### Ansible and API Services

Ansible modules for online services work slightly differently. These modules connect from the control machine to the relevant server or cloud, and use the API that the service provides to send commands to it.

### Ansible Tower and AWX

If you need a central service for managing tasks and nodes, Red Hat offer
[Ansible Tower](https://www.ansible.com/products/tower). The software for Ansible Tower is developed as an Open Source project, called [AWX](https://github.com/ansible/awx). You may use AWX, rather than pay for Ansible Tower, but the project does not provide user support or long-term maintenance for releases. None of the features of Ansible itself rely on Ansible Tower or AWX.

# Setting Up a Control Machine

To set up Ansible on a macOS or Linux system, first ensure that Python 3 and the pip utility are installed. Homebrew includes pip in the _python_ package, but some Linux distributions provide it in a separate package.

To install Ansible with pip, run this command in a terminal:

    pip3 install --user ansible

If you use [pipx](https://pypi.org/project/pipx/) to manage Python utilities, use this command to install Ansible:

    pipx install ansible

### Installing Extra Packages on the Control Machine

Some Ansible modules require additional Python packages on either the control machine or the nodes. You can use an Ansible task to install packages on nodes, but you should avoid trying to manage the Ansible installation on the control machine with Ansible itself:w
.

If you installed Ansible on the control machine with pipx, use the _inject_ subcommand to add packages. This subcommand will install the specified package into the Python virtual environment that pipx maintains for Ansible. For example, this command adds _boto3_ to the Ansible installation:

    pipx inject ansible boto3

If you used _pip_ to install Ansible, add the _--user_ option to install Python packages into your home directory, rather than globally. For example, this command installs _passlib_ into your home directory with _pip_:

    pip install --user passlib

### Ansible Configuration Files

Ansible does not require a configuration file. It does check for [configuration files in several locations](https://docs.ansible.com/ansible/latest/reference_appendices/config.html#the-configuration-file), so that you can customize the behavior of Ansible at the project, user or system level.

This is a simple Ansible configuration file:

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

# Ansible and Version Control

Store your Ansible playbooks and roles in a source code repository. Ansible files can be placed in the same repository as the other files for a project.

For convenience, you may put the Ansible playbooks in the root of your repository. You can define playbooks as single YAML files, so in some cases, you do not need to create any directories at all for Ansible code.

Always exclude _\*.retry_ files from version control. Ansible generates temporary files on the control station and the nodes, but only the retry files appear in the working directory.

If you expect to use an Ansible configuration file in the root directory of a project, consider excluding the _ansible.cfg_ file itself from version control, and just putting an example of the expected _ansible.cfg_ file in the repository. This enables each person that works with the repository to use their own configuration file, by copying the example file.

> Use the [Vault](https://docs.ansible.com/ansible/latest/user_guide/vault.html) feature to encrypt
> any YAML file that stores password variables.

# Directory Conventions for Ansible

These are standard directories for Ansible projects:

- filter_plugins/ - Custom filter plugins
- host_vars/ - Variables for individual host systems
- inventory/ - Lists of nodes
- group_vars/ - Variables for groups of systems
- library/ - Custom Ansible modules
- roles/ - Custom roles used by the Ansible playbooks

# Using Ansible

### The Ansible Tools

Ansible provides three main tools:

- _ansible-playbook_ - Execute an Ansible playbook on the specified
  systems
- _ansible_ - Executes an individual shell command or Ansible module
  on the specified systems
- _ansible-console_ - Provides an interactive shell for working with Ansible

You should also make use of these commands:

- _ansible-galaxy_ - Manages Ansible roles that are provided from shared repositories
- _ansible-vault_ - Encrypts and decrypts any individual YAML file that Ansible uses.

Ansible includes [several other specialized tools](https://docs.ansible.com/ansible/latest/user_guide/command_line_tools.html). For example, [ansible-pull](https://docs.ansible.com/ansible/latest/cli/ansible-pull.html) configures a system to pull Ansible playbooks from a source code repository and run them on a schedule.

### Specifying The Target Nodes

Use _-i_ to specify the inventory that has the target nodes. If you do not provide an inventory, Ansible will run, as if you had specified an inventory that only contains _localhost_, and print a warning.

Optionally, you can also specify a [pattern](https://docs.ansible.com/ansible/latest/user_guide/intro_patterns.html#intro-patterns), to limit the targets to the nodes that are either in a particular group, or whose names match the specified pattern.

    TOOL PATTERN -i INVENTORY OPTIONS

The tool will connect to each of the specified nodes and execute the
required commands. If a command fails on one or more of the nodes, a _retry_
file is created to enable you to run the commands again on only the failed
nodes.

> The _all_ group is a built-in group that automatically includes all of the systems in the specified inventory.

### The ansible Tool

Use the _ansible_ command with the _-a_ option to execute a shell command:

    ansible PATTERN -i INVENTORY -a /usr/bin/uptime

Use _-m_ to execute an Ansible module:

    ansible PATTERN -i INVENTORY -m ping
    ansible PATTERN -i INVENTORY -m setup

The _ping_ module checks that Ansible can connect to the remote system. The
_setup_ module returns information about the remote system.

To specify the arguments to use with the module, add the _-a_ option. For example, this command uses the _get_url_ module to download the file that is specified by the _url_ argument to the directory that is specified by the _dest_ argument:

    ansible PATTERN -i INVENTORY -m get_url -a "url='https://github.com/restic/restic/releases/download/v0.9.4/restic_0.9.4_linux_amd64.bz2' dest='/tmp'"

Use this feature to copy files between the control station and the nodes. The [copy](https://docs.ansible.com/ansible/latest/modules/copy_module.html) module transfers files from the control station over an SSH connection, the [fetch](https://docs.ansible.com/ansible/latest/modules/fetch_module.html) module downloads files from the nodes to the control station, and the [synchronize](https://docs.ansible.com/ansible/latest/modules/synchronize_module.html) module uses rsync for synchronization.

This example copies the _~/Downloads/example.txt_ file to the nodes:

    ansible PATTERN -i INVENTORY -m copy -a "src=~/Downloads/example.txt dest=/tmp/example.txt"

### The ansible-playbook Tool

To run a playbook:

    ansible-playbook -K -i INVENTORY MY_PLAYBOOK.YML

The _-K_ option means that Ansible will prompt you for the password of your
account on the remote system in order to use _sudo_.

Add _--syntax-check_ to test the Ansible playbook without running it:

    ansible-playbook --syntax-check -K -i INVENTORY MY_PLAYBOOK.YML

Add _--check_ to simulate the effect without making changes to the target systems:

    ansible-playbook --check -K -i INVENTORY MY_PLAYBOOK.YML

If the playbook requires data from a file that has been encrypted with
_ansible-vault_, add _--ask-vault-pass_:

    ansible-playbook --ask-vault-pass -K -i INVENTORY MY_PLAYBOOK.YML

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

# Additional Ansible Roles

- [Ansible Lockdown](https://ansiblelockdown.io/) - Project to maintain roles that configure systems to meet security standards
- [Linux System Roles](https://linux-system-roles.github.io/) - Project to provide a standard set of Ansible roles for configuring Linux systems

# Resources

- [Ansible Documentation](https://docs.ansible.com/)
- [Ansible Module Index](https://docs.ansible.com/ansible/latest/modules/modules_by_category.html) - Documentation for the modules that are provided with Ansible
- [Ansible for DevOps](https://www.ansiblefordevops.com), by Jeff Geerling - The most popular book on Ansible
- [Ansible Lightbulb](https://ansible.github.io/lightbulb/) - Material for running training workshops on Ansible
