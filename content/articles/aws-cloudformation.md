+++
Title = "Notes on AWS CloudFormation"
Slug = "aws-cloudformation"
Date = "2018-08-04T11:49:00+01:00"
Description = "Notes on AWS CloudFormation"
Categories = ["administration", "cloud"]
Tags = ["administration", "aws", "cloud"]
Type = "article"
Draft = true

+++

Notes on AWS CloudFormation.

<!--more-->

CloudFormation uses _templates_ to define _stacks_. Each stack is a set of AWS resources that work together and have the same lifecycle.

Once a stack is running, use _change sets_ to define modifications.

Use the Validation API to check your templates before you apply them.

You can also use APIs to request a cost estimate for a CloudFormation stack.

## cfn-init

The _cfn-init_ software run tasks on EC2 instances that have been created by
CloudFormation. You define the tasks for new EC2 instances with
_AWS::CloudFormation::Init_. This can download or create files, create user and groups,
or run commands.

The _cfn-init_ process logs to a file on the EC2 instance.

Remember to run _cfn-signal_ after the other tasks run.

Install the _CloudWatch Logs_ agent to stream logs from the instance to CloudWatch.

## Writing Templates

Use the _Description_ key to write a comment on a stacks, or the _Metadata_ to set a
comment on a resource.

Template sections:

- Version - The CloudFormation API version
- Description - A description of the stack
- Metadata - Objects that can be referenced in the template
- Parameters - The input parameters
- Resources - The resources
- Outputs - The output values

The version section should be one line that reads:

    AWSTemplateFormatVersion: "2010-09-09"

## Stack Policy

This enables you to restrict how resources can be changed.

If you give someone permissions to update a resource, ensure that you also grant them permissions to rollback.

## YAML

- [YAML in One Video](https://www.youtube.com/watch?v=cdLNKUoMc6c)

## Tools

- [CloudFormation Linter](https://github.com/awslabs/cfn-python-lint)
- [Up your AWS CloudFormation game with Visual Studio Code](https://hodgkins.io/up-your-cloudformation-game-with-vscode)

## Resources

- [AWS CloudFormation Best Practices](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/best-practices.html) - Documentation
- [AWS CloudFormation Best Practices](https://www.youtube.com/watch?v=sAqkN0vIhAY) - Video
- [Making CloudFormation Awesome](https://dev.solita.fi/2018/06/14/making-cloudformation-awesome.html)
- [Cloudonauts free templates for CloudFormation](https://cloudonaut.io/templates-for-aws-cloudformation/)
- [A Step-by-Step Guide to "continuously" Qualify AWS](https://valimation.com/blog/2018/1/18/a-step-by-step-guide-to-continuously-qualify-aws)
