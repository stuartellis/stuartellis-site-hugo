+++
Title = "Starting Mobile App Development with the Ionic Framework"
Slug = "ionic-development"
Date = "2016-07-01T01:00:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["angular.js", "javascript", "mobile"]
Type = "article"
Draft = true

+++


The Ionic Framework provides a set of tools and libraries for developing mobile applications using Web technologies (HTML, CSS and JavaScript). Each Ionic application is essentially a Website that is built with the Angular.js JavaScript framework, and packaged with the Apache Cordova library and other native components to interface with the underlying operating system of the mobile device.

<!--more-->

# Installation #

You may run Ionic and the Android compiler on any platform. You may only compile and run iOS packages on macOS.

First install Node.js. To set up Node.js on a macOS workstation using [Homebrew](http://mxcl.github.com/homebrew/) enter this command in a terminal window::

    brew install node

You can then install the Ionic framework:

    npm install -g bower cordova ionic ios-sim

The *ios-sim* package is needed to run the iOS device emulator.

## Install Android Support ##

To install Android support:

1. Install the JDK 8 package from oracle.com
2. Set the STUDIO_JDK environment variable for your user account: *export STUDIO_JDK=/Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk*
3. Install Android Studio
4. Open Android Studio
5. In Android Studio, choose *Configure > SDK Manager*. Ensure that the *Android 4.4.2 (API 19)* and *Android 5.1.1 (API 22)* packages are installed.

To enable Android support, export the path to the Android SDK directory as the ANDROID_HOME environment variable:

    export ANDROID_HOME=$HOME/Library/Android/sdk
