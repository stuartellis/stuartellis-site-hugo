+++
Title = "PowerShell and AWS"
Slug = "powershell-aws"
Date = "2022-04-03T17:39:00+01:00"
Description = ""
Categories = ["automation", "devops"]
Tags = ["dotNET", "automation", "devops", "powershell", "windows"]
Type = "article"
Toc = true

+++

The least that you need to know about [PowerShell](https://microsoft.com/powershell) and [AWS](https://aws.amazon.com/).

<!--more-->

## Summary

AWS provide [PowerShell modules](https://aws.amazon.com/powershell/) for working with their infrastructure. The AWS Tools for PowerShell modules are compatible with both Windows PowerShell and PowerShell 7. You can also run [PowerShell 7 with AWS Lambda](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-lambda.html). 

> These notes use the modular distribution that AWS recommend. AWS also offer a monolithic PowerShell module.

## Installing The Initial AWS Modules

To install the AWS Tools for PowerShell 7, run this command in PowerShell:

~~~powershell
Install-Module -Name AWS.Tools.Installer
~~~

This only sets up the *Installer* module. The Installer module enables you to install and update the PowerShell modules for the AWS services that you want to use:

~~~powershell
Install-AWSToolsModule AWS.Tools.EC2,AWS.Tools.S3 -CleanUp
~~~

## Using the AWS Module

If you have already created AWS profiles in plain-text files with the AWS CLI or libraries, PowerShell will read those files.

If you do not have AWS credentials, you must set an AWS profile, and specify the default AWS region for your operations:

~~~powershell
# Use the AWS profile named "default"
Set-AWSCredential -ProfileName default
# Set the default AWS region
Set-DefaultAWSRegion -Region us-west-1
~~~

> By default, PowerShell on Windows reads and writes these credentials into an encrypted store. 

Once the module and credentials are available, you may use AWS cmdlets to manage your infrastructure. The module also defines [aliases for the cmdlets](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-discovery-aliases.html), and a special [$AWSHistory variable](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-pipelines.html).

If you do not import an AWS module, it will automatically be loaded the first time that you use one of the cmdlets that it provides.

## Upgrading the AWS Modules

To upgrade the PowerShell modules for AWS:

~~~powershell
PS> Update-AWSToolsModule -CleanUp
~~~

## Resources

- [AWS Tools for PowerShell Documentation](https://docs.aws.amazon.com/powershell/index.html)
