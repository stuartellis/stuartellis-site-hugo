+++
Title = "An Introduction to Cross-Platform .NET"
Slug = "dotnet-crossplatform"
Date = "2016-07-01T01:00:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["csharp", "dotnet"]
Type = "article"

+++


There are currently several implementations of the .NET APIs and programming
languages, and the .NET Framework product is not Open Source, although the [code
is available](http://referencesource.microsoft.com/) for reference purposes.
This article only covers the Open Source [.NET Core](https://dotnet.github.io/),
and the associated tools.

<!--more-->

# Overview #

The .NET Core implementation itself consists of the *CoreCLR*, which is the
runtime for .NET Core, and *CoreFX*, the standard libraries for .NET Core. Many
other libraries and tools are shared between .NET Core and other
implementations. In future all .NET implementations should follow the [.NET
Platform
Standard](https://github.com/dotnet/corefx/blob/master/Documentation/project-docs/standard-platform.md)
to ensure that they remain interoperable.

By design, implementations of the .NET Framework support multiple programming languages. In practice, the C# language is the standard for .NET development.

# The Tools #

The key developer tool that you use for setting up .NET Core projects is the [*dotnet*](https://github.com/dotnet/cli/blob/master/Documentation/intro-to-cli.md) command-line utility. Both the *dotnet* tool and the facilities in
Visual Studio use [NuGet](http://www.nuget.org), the underlying package
management system for .NET platforms.

Use the [Visual Studio Code](https://code.visualstudio.com) editor, which includes support for .NET Core projects, such as debugging for C# and JavaScript.

# Popular Libraries #

Frequently used NuGet packages are:

* [ASP.NET](http://www.asp.net) - A set of libraries that provide the basic capabilities for Web applications
* [ASP.NET MVC](http://www.asp.net/mvc) - The MVC Web framework that is built on ASP.NET
* [Entity Framework](http://www.efproject.net) - The default ORM (Object-Relational Mapper) for .NET applications
* [Kestrel](https://nuget.org/packages/Kestrel) - The default HTTP server for .NET Core
* [Nancy](http://nancyfx.org/) - A lightweight Web framework that is built on ASP.NET
* [SignalR](http://www.asp.net/signalr) - The default WebSockets implementation for .NET (does not support .NET Core yet)

# Setup on A macOS Development Workstation #

First, use the installer to set up the [.NET Core SDK](https://www.microsoft.com/net/core#macos).

Install Node.js to run *yeoman*, and any other JavaScript utilities:

    brew install node
    npm install -g yo

Install the .NET generators for Yeoman:

    npm install -g generator-aspnet

# Creating an Application #

Use the Yeoman generator to create a skeleton Console or Web Application:

    yo aspnet

The generator automatically creates the *package.json* file that DNX uses for
each project.

Change the working directory to the application before you run any commands:

    cd MyApplication

For real-world development, your source code repository will probably contain multiple projects, such as an ASP.NET MVC project and an [xUnit.net](https://xunit.github.io/) testing project. To manage multiple projects like this, put a *Global.json* file in the root directory of your repository. Global.json files replaces the solution files and *.sln* format that were used by older versions of Visual Studio.

# Building an Application #

Use the *restore* option of *dotnet* to install the NuGet packages to the DNX
package cache on your workstation:

    dotnet restore

Then, to build the .NET part of the application, use *dotnet*:

    dotnet build

The Yeoman generator for .NET Web applications automatically includes a file for
[Docker](http://www.docker.com) in the project. You can use this to build images
and containers with the standard Docker tools.

# Running Administrative Commands #

Use *dotnet* to run commands, such as starting a Web application:

    dotnet web

Each command for a project is defined in the *project.json* file. The project
file that Yeoman will generate for ASP.NET projects has a *web* command to start the Web application, using Kestrel as the server.

By default, Web applications run in Production mode. To specify a different
environment, set a shell environment variable with the name *ASPNET_ENV*:

    ASPNET_ENV=development dnx web

You can define other commands in the *project.json* file, and then run them with
*dotnet*. For example, ASP.NET MVC applications have an Entity Framework command,
called *ef*, which provides sub-commands for creating and managing the
application database.

This command uses  to run the *migrations list* sub-command of *ef*:

    dotnet ef migrations list

# Resources #

* [.NET Core Web site](https://dotnet.github.io/)
* [ASP.NET Web site](https://get.asp.net/)
* [NuGet Web site](http://www.nuget.org)
* [xUnit.net](https://xunit.github.io/)
