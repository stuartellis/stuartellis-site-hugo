+++
Title = "10 Best Practices for Software Projects"
Slug = "project-best-practices"
Date = "2018-07-28T09:31:00+01:00"
Description = "A checklist of best practices for software projects"
Categories = ["programming"]
Tags = ["practices"]
Type = "article"
Draft = true

+++

A checklist of best practices for software projects, open and closed source.

<!--more-->

# Use a Source Control Repository

All source code and documentation should be in a version control repository. Use
[Git](https://git-scm.com/) for version control, unless you have a very compelling
reason not to do so, because it is now the industry standard.

# Include Standard Project Files

Write these files in [MarkDown](https://commonmark.org/) format.

- CHANGELOG.md - The changelog for the project
- CONTRIBUTING.md - How to work with the project
- LICENSE.md - The license that the software is provided under
- README.md - An introduction to the project

The CHANGELOG should edited by humans to be a meaningful list of changes, and follow the
recommendations on the [keep a changelog](https://keepachangelog.com) Website.

The CONTRIBUTING file should describe the workflow for submitting changes to the
project. There is no standard format for this file.

You must include a software license, and tools now check for a LICENSE file. Use an Open
Source license from the list of
[OSI-approved licenses](https://opensource.org/licenses), unless you specifically wish
the software to be proprietary.

There is no standard for the README file.
[This project](https://github.com/jehna/readme-best-practices) provides an example
README.

# Ensure That The Project Builds Cleanly

TODO

Consider using [pre-commit](https://pre-commit.com/) or another tool to automatically
apply formatting and linting.

# Use Consistent Version Numbering

Use [Semantic Versioning](http://semver.org/), unless you have a very compelling reason
to use another versioning scheme. If you do not use Semantic Versioning, document your
version numbering scheme in the README for your project.

# Use A Consistent Format for Commit Messages

Specify that commits should follow the
[Conventional Commits](https://conventionalcommits.org/) format. This enables you to use
tools to parse commit messages later.

# Enforce a Consistent Code Format

This avoids code reviews becoming discussions about formatting issues.

Add an [Editor Config](https://editorconfig.org/) file to automatically specify basic
formatting to code editors.

Include [Prettier](https://prettier.io/) or another code formatter in the recommended
workflow for your project. If there is a standard method of code formatting for a
programming language, such as _gofmt_ for Go, then use it when you work with that
language.

# Use Code Quality Checks

TODO

# Require Code Reviews

TODO

# Automate Testing

TODO

# Automate Releases

TODO
