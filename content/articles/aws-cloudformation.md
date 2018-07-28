+++
Title = "Notes on AWS CloudFormation"
Slug = "aws-cloudformation"
Date = "2018-07-28T08:16:00+01:00"
Description = "Notes on AWS CloudFormation"
Categories = ["administration", "cloud"]
Tags = ["administration", "aws", "cloud"]
Type = "article"
Draft = true

+++

CloudFormation

<!--more-->

CloudFormation uses _templates_ to define _stacks_. Each stack is a set of AWS resources
that work together and have the same lifecycle.

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

If you give someone permissions to update a resource, ensure that you also grant them
permissions to rollback.

## Tools

- [CloudFormation Linter](https://github.com/awslabs/cfn-python-lint)

## Resources

- [AWS CloudFormation Best Practices](https://www.youtube.com/watch?v=sAqkN0vIhAY)
