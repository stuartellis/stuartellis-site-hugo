+++
Title = "Best Practices for AWS CloudFormation"
Slug = "cloudformation-best-practices"
Date = "2019-06-09T12:27:00+01:00"
Description = "Best practices for AWS CloudFormation"
Categories = ["devops"]
Tags = ["devops"]
Type = "article"
Draft = true

+++

A colllection of best practices for [AWS CloudFormation](https://aws.amazon.com/cloudformation/).

<!--more-->

### Learning

- Understand how CloudFormation identifies and replaces resources
- Understand the elements of a CloudFormation template

### Elements of a CloudFormation Template

- Parameters
- Mappings
- Conditions
- Resources
- Output

### Usage

- Use Parameter Types
- Use Parameter Constraints
- Enable AWS CloudFormation Stack Termination Protection
- Use a deletion policy to retain critical resources after a stack is terminated

### Organizing Templates

Organize by layers:

- Identity (IAM Users, Groups, Roles)
- Base Network (VPCs, Internet Gateways, VPNs, NATs)
- Shared Services (Subnets, Security Groups, Common Monitoring and Alerts, some datastores)
- Backend Services
- Frontend Services

### Debugging

- Deactivate Rollback Flag during tests
- Use WaitConditions to provide "breakpoints"

### Security

- Enable AWS CloudFormation Stack Notifications
- Limit access to CloudFormation stacks with IAM
- Use CloudFormation Stack Policies

### Tools from AWS

- [CloudFormation Linter](https://github.com/aws-cloudformation/cfn-python-lint)
- [AWS Serverless Application Model](https://aws.amazon.com/serverless/sam/)
- [Custom Resource Helper](https://github.com/aws-cloudformation/custom-resource-helper) - Simplifies best practice when building Custom Resources

### Resources

- [AWS CloudFormation Best Practices](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/best-practices.html)
- [StackSet Best Practices](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/stacksets-bestpractices.html)
- [Two years with CloudFormation: lessons learned](https://sanderknape.com/2018/08/two-years-with-cloudformation-lessons-learned/), by Sander Knape
