+++
Title = "Notes on AWS CloudFormation"
Slug = "aws-cloudformation"
Date = "2016-09-01T17:20:00+01:00"
Description = "Notes on AWS CloudFormation"
Categories = ["administration", "cloud"]
Tags = ["administration", "aws", "cloud"]
Type = "article"
Draft = true

+++

CloudFormation

<!--more-->

CloudFormation uses *templates* to define *stacks*. Each stack is a set of AWS resources that work together and have the same lifecycle.

Once a stack is running, use *change sets* to define modifications.

## cfn-init

The *cfn-init* software run tasks on EC2 instances that have been created by CloudFormation. You define the task for new EC2 instances with *AWS::CloudFormation::Init*.

## Stack Policy

This enables you to restrict how resources can be changed
