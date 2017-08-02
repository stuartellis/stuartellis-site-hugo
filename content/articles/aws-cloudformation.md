+++
Title = "Notes on AWS CloudFormation"
Slug = "aws-cloudformation"
Date = "2017-08-02T09:03:00+01:00"
Description = "Notes on AWS CloudFormation"
Categories = ["administration", "cloud"]
Tags = ["administration", "aws", "cloud"]
Type = "article"
Draft = true

+++

CloudFormation

<!--more-->

CloudFormation uses *templates* to define *stacks*. Each stack is a set of AWS
resources that work together and have the same lifecycle.

Once a stack is running, use *change sets* to define modifications.

Use the Validation API to check your templates before you apply them.

You can also use APIs to request a cost estimate for a CloudFormation stack.

## cfn-init

The *cfn-init* software run tasks on EC2 instances that have been created by
CloudFormation. You define the tasks for new EC2 instances with
*AWS::CloudFormation::Init*. This can download or create files, create user and
groups, or run commands.

The *cfn-init* process logs to a file on the EC2 instance.

Remember to run *cfn-signal* after the other tasks run.

Install the *CloudWatch Logs* agent to stream logs from the instance to CloudWatch.

## Writing Templates

Use the *Description* key to write a comment on a stacks, or the *Metadata* to
set a comment on a resource.

## Stack Policy

This enables you to restrict how resources can be changed.

If you give someone permissions to update a resource, ensure that you also grant
them permissions to rollback.

## Resources

* [AWS CloudFormation Best Practices](https://www.youtube.com/watch?v=sAqkN0vIhAY)
