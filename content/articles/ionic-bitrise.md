+++
Title = "Building Ionic apps with Bitrise"
Slug = "ionic-bitrise"
Date = "2017-07-08T01:10:46+01:00"
Description = ""
Categories = ["programming"]
Tags = ["bitrise", "cordova", "ionic", "javascript", "mobile"]
Type = "article"
Draft = true

+++

[Bitrise](https://www.bitrise.io) is a Continuous Integration service that is
designed specifically for mobile apps. The service itself runs the Open Source
[Bitrise CLI](https://www.bitrise.io/cli) command-line tool in containers.

<!--more-->

# Bitrise Configuration

Each Bitrise project has one or more Workflows. Each Workflow consists of one or more Steps.

Define your steps in a *bitrise.yml* file. By default, the Bitrise service
generates a configuration that you can edit on the Website through the Workflow
Editor. To use a *bitrise.yml* configuration file from your project repository,
you must [create a wrapper configuration](http://devcenter.bitrise.io/tips-and-tricks/use-bitrise-yml-from-repository/).
The Bitrise CLI automatically uses the configuration file in your project.

To use the Bitrise CLI on your own computers, define passwords, API keys and
other secrets in the *.bitrise.secrets.yml* file.

Use the *ionic-archive* step to build iOS and Android packages.

Currently, you must specifically set the Bitrise service to use your custom
configuration.

# Android Code Signing

Follow the steps in [the documentation](http://devcenter.bitrise.io/android/code-signing) to upload the files for [Android code signing](https://developer.android.com/studio/publish/app-signing.html) to, and
enable Bitrise to sign the app.

Remember that each version of the app must be signed with the same identity to
be recognised as the same app.

First, [create a keystore and a key](https://developer.android.com/studio/publish/app-signing.html#generate-key).
To create a new keystore, use the *keytool* command-line utility:

    keytool -genkeypair -v -keystore <filename>.keystore -alias <key-name> -keyalg RSA -keysize 2048 -validity 10000

The *validity* is the number of days that the certificates will be valid for.
Google provide [specific guidance about certificate lifetimes](https://developer.android.com/studio/publish/app-signing.html#considerations).
They recommend that you create certificates that are valid for a minimum of 25
years. You must currently use certificates that are valid until at least 22
October 2033 for all apps that you publish with the Google Play Store.

Once you build a APK package for an app, it must be aligned, and then signed. If
you [build a package manually](https://developer.android.com/studio/publish/app-signing.html#signing-manually), use
[zipalign](https://developer.android.com/studio/command-line/zipalign.html) to
align it, and then run
[apksigner](https://developer.android.com/studio/command-line/apksigner.html) to
sign it for distribution. Bitrise provides the [sign-apk](https://github.com/bitrise-steplib/steps-sign-apk) Step to sign Android apps as part of a Workflow.
