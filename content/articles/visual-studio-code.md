+++
Title = "Setting up the Visual Studio Code Text Editor"
Slug = "visual-studio-code"
Date = "2019-04-13T08:11:00+01:00"
Description = "Setting up the Visual Studio Code text editor for development and systems administration"
Categories = ["administration", "programming"]
Tags = ["golang", "javascript", "python", "ruby"]
Type = "article"

+++

Notes on customizing the [Visual Studio Code](https://code.visualstudio.com) text editor.

<!--more-->

# Software Ethics and Visual Studio Code

The Microsoft releases of Visual Studio Code are proprietary software with telemetry enabled by default. If you prefer to avoid proprietary software, consider using the packages that are provided by the [vscodium](https://github.com/VSCodium/vscodium) project instead.

> Both Visual Studio Code and a number of extensions use telemetry. Always review the documentation for an extension before you install it, and look for notes about telemetry.

# Installing Visual Studio Code

## Installing Code on macOS

To install Visual Studio Code on macOS with Homebrew, enter this command in a terminal window:

    brew cask install visual-studio-code

If you manually install Visual Studio Code, rather than using Homebrew, you will need to add the _code_ executable to your PATH. To do this, start Visual Studio Code, open the command palette, and choose _Shell Command: Install 'code' command in PATH_.

## Installing Visual Studio Code to a USB Drive

To run Visual Studio Code directly from a USB device, without installing it on the computer, use [portable mode](https://code.visualstudio.com/docs/editor/portable).

## The EDITOR Environment Variable

Remember to set the EDITOR environment variable in your shell profile, so that this
editor is automatically invoked by command-line tools like your version control system.

To make Visual Studio Code your default editor, use this line:

    export EDITOR="code -w"

# Setting up Collaborative Editing with Live Share

Use the [Live Share service](https://visualstudio.microsoft.com/services/live-share/) for collaborative editing between copies of Visual Studio and Visual Studio Code.

# Disabling Telemetry

Visual Studio Code enables telemetry by default, and connects to remote services for various features, such as natural language search in settings. The FAQ explains [how Code complies with the GDPR](https://code.visualstudio.com/docs/supporting/faq#_gdpr-and-vs-code).

To disable telemetry and crash reporting, set these options in _Preferences > Settings_:

```json
"telemetry.enableTelemetry": false,
"telemetry.enableCrashReporter": false
```

To see settings for online services, search for _@tag:usesOnlineServices_ in _Preferences > Settings_.

Microsoft also add telemetry to some of their extensions to Visual Studio Code. This means that you must check the description of each extension to know whether it will send data to Microsoft, even if you have disabled telemetry for Visual Studio Code itself.

Third-party extensions may also send telemetry data. Check the specific settings that each extension uses, because settings may not be correctly tagged.

# Formatting on Save

Visual Studio Code automatically recognises if a formatter is available for the type of file that you are currently editing. The _Format Document_ command runs the appropriate formatter on the current file.

To automatically format files on save, enable this setting:

```
"editor.formatOnSave": true
```

# Extensions

## Extensions for Writing

- [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)
- [Spell Right](https://marketplace.visualstudio.com/items?itemName=ban.spellright)

## Extensions for Software Development

- [Git Lens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens) to
  enhance the Git support in the user interface
- The
  [Docker](https://marketplace.visualstudio.com/items?itemName=PeterJausovec.vscode-docker)
  extension
- [Prettier](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode) - Integration for the [Prettier](https://github.com/prettier/prettier) code formatter
- [VSCodeVim](https://marketplace.visualstudio.com/items?itemName=vscodevim.vim) to emulate Vim
- [YAML Support](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml)

## Extensions for Popular Programming Languages

Visual Studio Code includes support for JavaScript, TypeScript and Node.js. To add support for other programming languages, install the extension for the languages that you would like to use.

Run this command to add the
[Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
extension:

    code --install-extension ms-python.python

You will need to install some additional tools into the environment to use all of the features of this extension.

Run this command to add the
[Go](https://marketplace.visualstudio.com/items?itemName=ms-vscode.Go) extension, which
turns Code into a development environment for Go:

    code --install-extension ms-vscode.go

The Go extension will automatically download and configure all of the tools that it needs.

Run this command to add the
[Ruby](https://marketplace.visualstudio.com/items?itemName=rebornix.ruby) extension:

    code --install-extension rebornix.ruby

You will need to install some additional tools into the environment to use all of the features of this extension.

For UNIX shell scripts, use [Shellcheck](https://www.shellcheck.net/). Run this command to add the
[Shellcheck](https://marketplace.visualstudio.com/items?itemName=timonwong.shellcheck) extension:

    code --install-extension timonwong.shellcheck

You will need to install [Shellcheck](https://www.shellcheck.net/) into the environment to use all of the features of this extension.

## Useful Extensions for Web Development

- [ESLint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
  or [TSLint](https://marketplace.visualstudio.com/items?itemName=eg2.tslint) for
  JavaScript linter integration
- [Debugger for Chrome](https://marketplace.visualstudio.com/items?itemName=msjsdiag.debugger-for-chrome)
  to debug JavaScript in the Web browser

## Useful Extensions for Operations

- [Ansible](https://marketplace.visualstudio.com/items?itemName=vscoss.vscode-ansible)
- [AWS CloudFormation Linter](https://marketplace.visualstudio.com/items?itemName=kddejong.vscode-cfn-lint)
- [Microsoft SQL Server](https://marketplace.visualstudio.com/items?itemName=ms-mssql.mssql)
- [PowerShell](https://marketplace.visualstudio.com/items?itemName=ms-vscode.powershell)
- [Terraform](https://marketplace.visualstudio.com/items?itemName=mauve.terraform)

# Resources

- [Visual Studio Code documentation](https://code.visualstudio.com/Docs)
- [Up your AWS CloudFormation game with Visual Studio Code](https://hodgkins.io/up-your-cloudformation-game-with-vscode)
