+++
Title = "Basics of Git Version Control"
Slug = "git-basics"
Date = "2016-07-01T01:00:00+01:00"
Description = ""
Categories = ["tools"]
Tags = ["git"]
Type = "article"

+++


Git is fairly logical once you have learned the ideas behind it, so this
articles has quite a lot on concepts, and much more abbreviated notes on the
important commands.

<!--more-->

# Concepts #

The essential component of version control is the *repository*, a
database that holds information about changes to a set of files, known
as the *working tree*. The changes and other information that make up a
set of files and directories are all stored as *objects* in the
repository database. When you request a version of a working tree or a
particular file the relevant objects are rapidly combined, and the
result is written to disk.

Each time that the user requests a *commit*, Git stores the state of the
entire working tree as a *snapshot*, along with the contents of those
files that the user specifies and have changed. This means that Git only
records those changes to the tree that the user chooses to register.

## Distributed Version Control ##

Git is a distributed system, so the concept of a master repository is
not really appropriate. Instead, you start with one repository, and then
make extra copies for distribution and backup purposes. Once created,
copies may diverge from the original, but you can synchronize them at
any time. You can treat one particular repository as the canonical copy
if you wish, but Git has no such notion.

Similarly, clients and servers no longer have the same meaning with a
distributed version control system. You can copy to and from any
repository that you have access to, either on the same computer, or over
a network.

The Git software package does include a network service for sharing
repositories, but this is only necessary to protect a common repository
from locking issues caused by multiple simultaneous requests, or to
enable controlled remote access without exposing the rest of the system
to the repository users.

Normally, you create the original repository on your desktop computer,
and then use the *clone* facility of git to create copies of it. These
clones can then put on remote servers, removable drives, or anywhere
that you like. You could equally create the original repository on a
server, and then create a clone on your own computer.

To conveniently interact with another copy of a repository, you register
it with your local copy as a *remote*. Each remote has an alias, which
can have any name that you wish. If you clone an existing repository
then the source repository is automatically registered in the clone as a
remote with the name *origin*.

## The Two Forms of Repository ##

Git repositories are not binary files, unlike most databases. Instead, a
Git repository is a directory that contains a set of files and
subdirectories within it. These files and subdirectories each have a
specific function. It is not necessary to enter or directly edit any of
the pieces of a repository.

A standard Git repository is linked to a copy of the working tree. By
default, the repository is a subdirectory within a copy of the working
tree, and has the name *.git*. You may configure a repository to manage
a working tree in another location, but this is outside of the scope of
these notes.

A *bare repository* is just a copy of the repository itself, and is not
linked to a copy of the working tree. By convention, a directory that
holds a bare repository has the suffix *.git* attached to it’s name,
e.g. *my-project.git*. Other repositories can submit or collect
information to and from bare repositories.

Bare repositories provide collection and distribution points for changes
that were recorded by standard repositories elsewhere. Usually, each
developer working on a project has a standard repository copy on their
own computer, and all of the developers have access to a bare repository
that resides on a central server.

Both forms of repository use the same storage format. The repository
format for Git is stable, which means that you can upgrade installed
copies of Git without modifying your repositories.

## Git is a Content Tracker ##

Git actually works with the contents of files, and is flexible about
where the content currently resides. The advantage of this approach is
that you can rename and move files without much issue. The disadvantages
are that Git does not maintain file permissions, nor does it track
completely empty directories.

Unfortunately, Git must treat binary files in the tree as indivisible
blobs. This means it must make a copy of the entire binary file every
time that a change is registered, and it cannot tell you what a change
actually did. For these reasons, put your data and source code into
version control, along with any scripts needed to compile binaries, but
do not store the generated binaries.

## The Index (or Staging Area) ##

Whenever you register that one or more files in the working tree have
changed, the details are noted in the *index*. The *commit* command
permanently saves all of the pending changes from the index to the
object database for the repository, and then flushes the index.

Although other version control systems have a similar concept to the
index, only Git exposes it to the user so directly. Some documentation
refers to the index as the staging area, which is a much more
appropriate name.

The *stash* command saves the current states of both the working tree
and the index, without making commits.

## Branches and Tags ##

Every Git repository has one or more *branches* and *tags*, which
identify alternative versions of the working tree. Each branch and tag
may provide a completely different directory structure and set of files.
Tags and branches are actually just types of pointers, or *refs*, that
identify the commit that is the latest in the sequence. This means they
take up very little space, and there is no limit on the number that can
be held in a repository.

A tag identifies the state of the working tree at a particular point in
time, such as a release. It may be digitally signed, so that others can
verify copies later.

A branch indicates a version of the working tree that may continue to be
changed. At any time, one branch is the *current branch*. This is the
branch that will be targeted by commands such as *merge*.

The branch that Git automatically creates when it initializes a
completely new repository is named *master*. This first branch is the
current branch, until you explicitly change to another branch.

Git provides two forms of synchronization between branches. A *merge*
attempts to reconcile two or more branches. A *rebase* makes the target
branch identical to the source branch, and then reapplies all of the
committed changes. This enables outside developers to track the main
line of development whilst working on customizations.

## Remote Branches ##

By default, a repository database only actually holds the objects for
those branches that were created locally. Each *remote tracking branch*
is simply a reference to a branch in a remote repository. You may add
remote branches to a repository from any other repository. Once a remote
branch is registered in your repository, you may synchronize a local
branch with it at any time.

> To work on the content from a remote branch, create a copy as a local
> branch, and make your changes on this local branch. Once a change is
> complete, reconcile the local and remote versions.

If you clone a repository then the master branch is fully copied to the
clone, and this local branch becomes the current branch. All of the
other branches in the source repository are created as remote branches
in the clone. These inherited branches have a name prefixed by
*origin/*.

## Identifiers for Commits ##

Git uniquely identifies each change with an SHA1 checksum, which looks
like this:

    c34a140e552a091f3d1b36effb0bf2a031850e5f

The mathematics behind SHA1 mean that every checksum that is generated
is truly, globally unique, and will never be repeated by any other
system in the world. This means that all of the changes registered in
separate copies of a repository are guaranteed to have unique
identifiers, and can be compared and reconciled without error at any
time.

To enable users to refer to commits without needing to quote the entire
checksum, Git supports a number of alternate ways to specify a commit. A
short form identifier is referred to as a *treeish* in the
documentation. By far the most common is the partial checksum:

    c34a14

Git automatically resolves other identifiers to the nearest matching
checksum. For example, this identifier will be resolved to the commit
that was made yesterday:

    master@{yesterday}

Use the tilde identifiers to ask Git to find a commit, relative to the
commit with the specified checksum. This identifier specifies the commit
that was two commits before the commit that has a partial checksum of
c34a14:

    c34a14~2

To find a series of commits, specify the first commit before the start
of the range, and the last commit that is within the range, separated by
two dots:

    c34a14..b9c38e

To specify one of the parent commits, use the caret:

    c34a14^2

This is mainly useful for the results of a merge, where the specified
commit may have two or more parents, rather than just one.

If Git cannot resolve an identifier, it produces an error.

> *HEAD:* The pointer *HEAD* always refers to the most recent commit on
> the current branch.

Refer to the [Git Community
Book](http://book.git-scm.com/4_git_treeishes.html) for more on the
available identifiers.

# Common Working Styles #

In practice there are three standard to arrange sets of Git
repositories:

* A copy on a desktop as the canonical repository, with remote clones
* A canonical repository on a remote system, with a local clone as your personal working copy
* Forking a repository on GitHub or Gitorious, and then working on a clone

The third use case actually involves three repositories: the source
repository, a clone on the hosting service that is private to you, and a
local clone of your clone. This means that you have to register the
first source repository as a remote branch in your local clone - it will
not automatically be registered.

# Installing Git #

Whichever operating system you use, remember to configure Git before you
create a repository.

## Installing Git on Linux ##

To install Git on Linux, simply use the package management system built
into the operating system. The package is often named *git-core*, to
differentiate it from another Open Source product that is also called
git. For example, to install the Git version control system on Debian or
Ubuntu systems, run this command:

    sudo apt-get install git-core

Debian and Ubuntu provide other supporting software, such as the gitweb
interface, but put these in separate packages.

## Installing Git on Microsoft Windows ##

Install one of the following:

* [Git for Windows](http://code.google.com/p/msysgit/) - Package for command-line Git on Windows, including SSH
* [Git Extensions](http://sourceforge.net/projects/gitextensions/) - Provides Git for Windows, as well as a graphical utility, and a Visual Studio plugin for Git

## Installing Git on Mac OS X ##

Go to the [Git Web site](http://www.git-scm.com/) and follow the link
for *Other Download Options*, to obtain a Mac OS X disk image. Use the
disk image as normal.

# Configuring Git #

Once you have installed Git on a system, always set your details before
you create or clone a repository. This requires two commands:

    git config —global user.name "Your Name"
    git config —global user.email "you@your-domain.com"

The *—global* option means that the setting will apply to every
repository that you work with in the current user account.

To enable colors in the output, which can be very helpful, enter this
command:

    git config --global color.ui auto

## Global Exclusions ##

You may want to ensure that some files never appear in any commit that
you do in any repository. Specify a global ignore file with the
*core.excludesfile* setting. You must give the full path of your
exclusions file, or the feature will silently fail. For example:

    git config --global core.excludesfile /home/you/.gitexclusions.txt

Your exclusions file uses the same format as *.gitignore* files.

## Command Aliases ##

Finally, you will probably to create short aliases for the commands that
you use often. Use the keyword *alias*, followed by the alias, like
this:

    git config —global alias.br branch
    git config —global alias.co checkout
    git config —global alias.ci commit
    git config —global alias.df diff
    git config —global alias.lg log -p
    git config —global alias.st status

You may define aliases for any Git command.

# Creating a New Repository #

To turn a directory into a Git repository, simply enter these commands:

    git init
    touch .gitignore
    git add .
    git commit -m “Initial commit”

Add the appropriate entries to the *.gitignore* file, as explained
below, and then commit the change.

You should immediately create a branch and switch to it. This command
creates a branch called *spike*, and makes it the current branch:

    git checkout -b spike

You can then makes changes and selectively merge them to the master
branch.

## Exclusions ##

In addition to the global exclusions for your user account, you can
specify exclusions for a repository in either the *exclude* file, or
*.gitignore* files. Each *.gitignore* file defines a set of exclusions
for the directory that it resides in, and subdirectories. These files
are tracked by Git in the usual way, and so they apply to every copy of
that repository. The listings in the repository exclusion file
*.git/info/exclude* apply to the current copy of the entire repository,
but this file is not replicated between copies of a repository.

Always exclude these files, which are automatically generated by
operating systems:

* .DS\_Store
* thumbs.db

Other exclusions depend upon the type of project. As a rule, you should
exclude files that are compiled or generated from the source code. For
example, these exclusions cover the files that Ruby on Rails projects
generate:

* db/\*.sqlite3
* doc/api
* doc/app
* log/\*.log
* tmp/\*\*/\*

> If you use RVM then exclude .rvmrc files from the project repository.
> These files are system-specific.

# The Most Commonly Used Commands #

These are the standard commands for working with files in a Git
repository.

Remember that the man page for each Git command is prefixed with *git-*,
so to view the man page for *git commit*, type this command:

    man git-commit

## Adding Changes to the Index: git add {#cmds-add}

Use *git add* to add changes to the index. All of the changes made on
the specified files are registered. If you run *git add* again with the
same file before you commit, the information in the indexed is
automatically updated.

    git add my-file.txt
    git add some/directory/*
    git add some/other/directory/*.txt

Use the *-p* option to add just some of the changes to a file:

    git add -p my-file.txt

Git then lets you interactively choose which of the changes to the file
to register in the index.

## Removing Changes to the Index: git reset ##

Use *git rm —cached* or *git reset* to remove files from the index,
without actually deleting the copies in the working tree:

    git reset myfile.txt

The *reset* command accepts patterns as well as file names.

## Committing the Index: git commit ##

The commit message should have a one line summary, a blank line, then
details.

    git commit -m "Committed minor change to Blah module.

    This now does blah blah instead."

To amend the previous commit, use the *—amend* option. For example, to
amend the message on a commit:

    git commit --amend -m  "New commit message" c34a14

## Listing Changes: git status and git log ##

For a list of changes, whether they are staged or unstaged:

    git status

This also shows any untracked files that are in the working tree.

To see a list of committed changes for all branches, use *git log*:

    git log

Use the *-p* option to show the content of each commit:

    git log -p

The *git log* accepts many filters and options. One of the most useful
changes the format to show one commit per line:

    git log --pretty=oneline

## Reviewing the Details of Changes: git show and git diff ##

To see a specific commit, use *git show*:

    git show c34a14

To see the details of changes between particular revisions, use *git
diff*. If you do not specify revisions, or give any options, *git diff*
shows that changes between the index and the working files.

Use the *—staged* option to see the differences between the HEAD and the
index:

    git diff --staged

If you specify revisions, *git diff* compares them. Just specify HEAD to
see all of the differences between the repository and the working files:

    git diff HEAD

To compare particular commits, specify the identifiers:

    git diff c34a14 b9c38e

You may specify tag or branch names, or other identifiers.

To narrow the scope of any *diff* to a single directory or file, append
the name of the target to the command:

    git diff c34a14 b9c38e myfile.txt

To compare a set of changes, specify a range:

    git diff c34a14...b9c38e myfile.txt

## Reverting Changes: git reset and git revert ##

To get a previous version of an individual file, you can use *git
checkout*:

    git checkout HEAD myfile.txt

To go back to a previous version of the working tree, use *git reset*.
For example:

    git reset --hard HEAD

These commands to revert changes do not destroy files in the working
tree.

To remove all untracked files from the working tree, use *git clean*:

    git clean -f

The *git revert* command undoes the result of the specified commit, and
creates a new commit to register the changes. For example, to undo the
specific changes made by the commit c34a140, run this command:

    git revert c34a14

## Deleting Files: git rm ##

Use *git rm* to delete a file or directory from the working tree. This
also marks it as deleted in the index, so that the next commit will
register the change in the repository.

    git rm my-file.txt

## Moving or Renaming Files ##

As Git tracks content, you do not need to use any special commands to
safely move or rename files. Simply copy, move, or rename the file, and
then use *git add* to register the resulting file in the staging area.

# Repository Operations #

## Cloning an Existing Repository: git clone ##

To create a new copy of an existing repository, get the URL of the
repository, and use *git clone*:

    git clone http://server.domain.com/a-project.git
    git clone git+ssh://server.domain.com/a-project.git
    git clone git://server.domain.com/a-project.git

By default, this creates a working tree that matches the HEAD of the
master branch. To create the clone as a bare repository, add the *—bare*
option to the command.

Remember to create a local branch before you make any changes to the new
clone.

## Managing Linked Remote Repositories: git remote ##

To register a remote with your repository, use the *remote* command:

    git remote add other-repo

Similarly, to remove a remote, use the *rm* option of *git remote*:

    git remote rm other-repo

You can also safely add or remove remotes by editing the *.git/config*
file directly, if you wish.

## Synchronizing with Another Repository: git pull and git fetch ##

To fully synchronize a repository with another, Git has to do three
things. Firstly, it has to get all of the objects that are stored within
the source repository that the target does not have. Secondly, it has to
reset HEAD on the target to point to the latest commit. Thirdly, it has
to update the working tree of the target to match the new HEAD.

To perform all of these operations with one command, use *git pull*. By
default, this merges the *master* branch from the remote repository that
is registered as *origin* into the current local branch.

    git pull

In many cases you do not want all of the steps to happen immediately. To
just copy new objects from the remote repository to the local repository
database without updating the HEAD pointer or your copy of the working
tree, use *git fetch*:

    git fetch

To reset the HEAD pointer and the working tree, use either the *merge*
or *rebase* facilities to apply the outstanding changes. This command
merge the *master* branch from the *origin* repository with the current
branch:

    git merge origin/master

## Exporting from a Repository: git archive and git checkout-index ##

By default, *git archive* streams the specified version of a working
tree in *tar* archive format to the terminal STDOUT, so that you can
pipe or redirect the data to any command or location of your choice. Use
*git archive* with the option *—format=zip* to export the tree in
compressed zip format. For example, this command exports the latest
version of the tree as a zip archive and saves it to a file named
*my-archive.zip*:

    git archive HEAD --format=zip > my-archive.zip

To export a tree without compressing it, we must use *git
checkout-index*. Use the *prefix* option to specify the destination for
the exported files:

    git checkout-index --prefix=/path/to/destination/ -a

Refer to the [Git Ready
article](http://gitready.com/intermediate/2009/01/29/exporting-your-repository.html)
for more on exporting repositories.

# Working with Branches: git branch and git checkout #

## Creating a New Branch ##

You can create a branch at any time. Remember that this creates an
alternate version of the entire working tree. If you do not specify a
commit, Git creates a branch that is copy of HEAD:

    git branch new-branch

This does not actually switch branches.

To create a new branch and switch to it immediately, use *git
checkout -b*:

    git checkout -b new-branch

If you create a branch to work on content from another branch that was
created elsewhere, name the new branch the same as the original, with a
prefix of your initials followed by a forward slash. For example, J S
Bach’s local copy of the *useful-feature* branch should be named
*jsb/useful-feature*. This is purely a helpful convention.

## Listing Available Branches ##

To see the local branches, use *git branch -l*:

    git branch -l

The current branch has an asterisk next to it.

To see the remote branches, use *git branch -r*:

    git branch -r

## Switching Branches {#branches-switching}

To change the current branch, use *git checkout*. Note that you must use
the *-f* option to actually change the working tree to match:

    git checkout -f new-branch

## Transferring Changes Between Branches ##

To merge the content of another branch into the current branch, use *git
merge* or *git rebase*. Normally you use *merge* to apply just the
differences:

    git merge other-branch

The *rebase* function is more aggressive. It makes the current branch
the same as the specified branch, and then applies all of the changes
between the current branch and the common ancestor of the two branches.

    git rebase other-branch

To copy a single commit from one branch to another, switch to the target
branch, and then use *cherry-pick* to import the specified commit:

    git cherry-pick f28e67

## Publishing a Branch to Another Repository ##

To publish a branch to another repository that you have write access to,
use *git push*. This adds the objects to the database of the remote
repository, so that others with access to the repository can reproduce
your branch if they wish.

If the remote repository has been specified as a mirror, then every push
will automatically transfer all new changes from all of the branches in
the repository.

## Deleting a Branch ##

To delete a local branch, use *git branch* with the *-d* option:

    git branch -d unwanted-branch

To delete a remote branch, just push to the repository, with a colon
before the name of the branch that you want to remove:

    git push origin :unwanted-branch

# Working with Tags: git tag #

## Listing Available Tags ##

To see the tags, use *git tag -l*:

    git tag -l

## Creating a New Tag ##

To create a new tag from the current branch:

    git tag -a -m "This is a tag" tag-name

# Submodules #

The submodule facility enables you to attach another complete repository
to a directory within the main repository. Commands within a submodule
work as if the submodule was a separate clone.

Some experts advise using the newer subtree option instead of
submodules.

## Important: Submodule Names ##

Git commands that use the submodule require the name of the submodule,
not the local directory that it is attached to. By default, the local
directory has the same name, which may confuse.

This specifies the name, which is correct:

    git add submodule-name

This is a file path, which is wrong:

    git add submodule-name/

## Creating a Submodule ##

To create a submodule within a project, use the *add* option of the *git
submodule*:

    git submodule add url local-name
    git commit -m “Added submodule”

This creates a directory called local-name, and clones the repository
plus the working tree under it. The submodule is registered to a
specific commit.

Next, run the *init* function to activate all of the registered
submodules:

    git submodule init

## Updating a Submodule ##

To update a submodule to match the latest remote version:

    cd submodule-path
    git pull

This updates the working tree inside the submodule.

To update the commit that the parent repository thinks the submodule
should link to:

    cd parent
    git add submodule-name
    git commit -m “Updated submodule”

Ensure that you use the name of the submodule, not the path of the local
directory that it is attached to.

# Replicating Repositories #

Assuming that the original is called *my-project*, and the remote server
has a directory called */srv/repo-mirrors*, these commands make a clone
bare repository, and transfer it to the server with SSH:

    git clone —bare my-project my-project.git
    scp -r my-project.git
    my-server.my-domain.com/srv/repo-mirrors

Once there is a clone of the original on a remote server, these commands
register the remote clone as a mirror, with the alias *replicant*, and
carry out a test push:

    cd master-repo
    git remote add replicant
    ssh://my-server.my-domain.com/srv/repo-mirrors/master-repo.git —mirror
    git push replicant

The mirror setting means that data for all branches will be transferred
to the remote every time that you use *git push*.

To synchronize the remote clone with the local copy, simply run *git
push* on the local copy. You could write a script to do this and
schedule it to run periodically, or add a post-commit [hook
script](http://book.git-scm.com/5_git_hooks.html) to the local copy that
pushes every change to the clone immediately after it is made.

# Backing Up Your Repositories #

There are no special tools required to backup a copy of a Git
repository - it is just a collection of files and directories. If you
are sharing the repository through a service, then you should create a
clone which is automatically updated, and back that up, simply because
the shared repository may be changing at any time.

# Resources and Documentation #

## Getting Started ##

* [Git for Designers](http://hoth.entp.com/output/git_for_designers.html) is actually a very lucid introduction to the concepts of Git that is suitable for anyone.
* [Git Reference](http://gitref.org/) is actually a fairly short and well-written tutorial
* [Effective Project Management with Git](http://scotland-on-rails.s3.amazonaws.com/1A02_Scott_Chacon.mp4) (MP4 download) - An excellent video presentation
* [Git SVN Crash Course](http://git-scm.com/course/svn.html) for those coming from Subversion.

## Reference Documentation ##

* [Everyday Git](http://git-scm.com/docs/everyday) - The top 20 commands
* [Pro Git](http://book.git-scm.com/) - An online version of the Apress book

## Cheatsheets ##

* [A useful one page cheatsheet](https://github.com/AlexZeitler/gitcheatsheet/blob/master/gitcheatsheet.pdf)
* [A polished two page cheatsheet from the makers of Tower](http://www.git-tower.com/files/cheatsheet/Git_Cheat_Sheet_grey.pdf)

## Advanced Use of Git {#resources-adv}

* [git ready](http://gitready.com/)
* [Understanding Git Submodules](http://speirs.org/blog/2009/5/11/understanding-git-submodules.html)
* [Git Submodules - Adding Using, Removing, and Updating](http://gaarai.com/2009/04/20/git-submodules-adding-using-removing-and-updating/)
* [Git From The Bottom Up](http://www.newartisans.com/2008/04/git-from-the-bottom-up.html) - Explains the internal design of Git
