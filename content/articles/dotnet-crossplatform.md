+++
Title = "An Introduction to Cross-Platform .NET"
Slug = "dotnet-crossplatform"
Date = "2017-08-19T13:03:00+01:00"
Description = "The .NET Core and supporting tools"
Categories = ["programming"]
Tags = ["csharp", "dotnet"]
Type = "article"

+++


This article covers the Open Source [.NET Core](https://dotnet.github.io/),
and associated tools.

<!--more-->

# Overview #

The .NET Core implementation itself consists of the *CoreCLR*, which is the
runtime for .NET Core, and *CoreFX*, the standard libraries for .NET Core. Many
other libraries and tools are shared between .NET Core and other
implementations. The various implementations of .NET follow the [.NET
Platform
Standard](https://github.com/dotnet/standard)
to ensure that they remain interoperable.

There are currently other implementations of the .NET APIs and programming
languages. The .NET Framework supplied with most editions of Windows is not Open Source, although the [code
is available](http://referencesource.microsoft.com/) for reference purposes.

## Programming Languages ##

The .NET platforms support multiple programming languages. In practice, the [C# language](https://docs.microsoft.com/en-gb/dotnet/csharp/) is the standard for .NET development.

## Releases ##

Microsoft support [two tracks of .NET Core releases](https://docs.microsoft.com/en-gb/dotnet/core/versions/lts-current). Long-Term Support (LTS) versions of .NET Core are supported for three years, and Current versions are supported for one year.

Install .NET Core releases on systems that need to run .NET applications, and the [.NET Core SDK](https://docs.microsoft.com/en-us/dotnet/core/sdk) on developer systems. The .NET Core SDK includes .NET Core and the tools for building .NET Core applications.

## Deployment ##

There are [two types of build](https://docs.microsoft.com/en-gb/dotnet/core/deploying) for .NET Core applications. By default, .NET Core applications compile into Framework-Dependent Deployments (FDD), which means that the application itself uses platform-independent code, but relies on there being a copy of .NET Core installed on the host system. If you choose to build a Self-Contained Deployment (SCD), then the result is an executable application that includes .NET Core. Each SCD must be built for specific operating systems.

# The Tools #

The key developer tool that you use for setting up .NET Core projects is the [*dotnet*](https://github.com/dotnet/cli/blob/master/Documentation/intro-to-cli.md) command-line utility. Both the *dotnet* tool and the facilities in
Visual Studio use [NuGet](http://www.nuget.org), the underlying package
management system for .NET platforms, and [MSBuild](https://docs.microsoft.com/en-us/visualstudio/msbuild/msbuild), the tool for managing  application builds.

Use the [Visual Studio Code](https://code.visualstudio.com) editor, which
includes support for .NET Core projects, such as debugging for C#, JavaScript, and TypeScript.

Both the *dotnet* command-line utility and the Visual Studio Code editor enable telemetry by default. 

* [.NET Core Telemetry](https://docs.microsoft.com/en-gb/dotnet/core/tools/telemetry)
* [Visual Studio Code Crash Reporting](https://code.visualstudio.com/Docs/supporting/FAQ#_how-to-disable-crash-reporting)
* [Visual Studio Code Telemetry](https://code.visualstudio.com/Docs/supporting/FAQ#_how-to-disable-telemetry-reporting)

# Popular Libraries #

Frequently used NuGet packages are:

* [ASP.NET](http://www.asp.net) - A set of libraries that provide the basic capabilities for Web applications
* [ASP.NET MVC](http://www.asp.net/mvc) - The MVC Web framework that is built on ASP.NET
* [Entity Framework](https://docs.microsoft.com/en-gb/ef) - The default ORM (Object-Relational Mapper) for .NET applications
* [Kestrel](https://nuget.org/packages/Kestrel) - The default HTTP server for .NET Core
* [Nancy](http://nancyfx.org/) - A lightweight Web framework that is built on ASP.NET
* [SignalR](http://www.asp.net/signalr) - The default WebSockets implementation for .NET (does not support .NET Core yet)
* [xUnit.net](https://xunit.github.io/) - The default unit testing framework

# Setup on A macOS Development Workstation #

First, use the installer to set up the [.NET Core SDK](https://www.microsoft.com/net/core#macos).

Install Node.js to run JavaScript utilities:

    brew install node

Use Node.js to install TypeScript:

    npm install -g typescript

Use Homebrew Cask to install Visual Studio Code:

    brew cask install visual-studio-code

Once you have installed Code, add the C# extension and choose *Reload* to enable support for C#.

If you are going to deploy your Web applications with Docker, install [Docker for Mac](https://www.docker.com/docker-mac) from the Docker Website.

# Creating an Application #

Create a directory and change the working directory before you run any commands:

    mkdir MyApplication
    cd MyApplication

Use the *dotnet new* command to create a skeleton application. For example, the *mvc* option creates an ASP.NET MVC Web application:

    dotnet new mvc

# Building and Running an Application #

To build an application, use *dotnet*:

    dotnet build

To run an application:

    dotnet run

If the application is an ASP.NET Web application, the *run* command starts a Web server that hosts the application on port 5000.

## Environments ##

ASP.NET Core applications have several different modes, known as [environments](https://docs.microsoft.com/en-gb/aspnet/core/fundamentals/environments). By default, Web applications run in Production mode. To specify a different
environment, set a shell environment variable with the name *ASPNETCORE_ENVIRONMENT*:

    ASPNETCORE_ENVIRONMENT=Development

# Resources #

* [.NET Core Web site](https://dotnet.github.io/)
* [ASP.NET Web site](https://get.asp.net/)
* [NuGet Web site](http://www.nuget.org)
* [ASP.NET MVC tutorial](https://docs.microsoft.com/en-gb/aspnet/core/tutorials/first-mvc-app-xplat/start-mvc)
