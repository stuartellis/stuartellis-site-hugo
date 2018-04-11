+++
Title = "AWS Data Backups with Built-in Features"
Slug = "aws-native-backups"
Date = "2018-04-11T16:13:00+01:00"
Description = "AWS data backups with the built-in features"
Categories = ["administration"]
Tags = ["administration"]
Type = "article"
Draft = true

+++

AWS includes backup features for several key services.

<!--more-->

# Putting Together the Pieces #

* One or more EBS volumes to back up
* An IAM role that has permissions to back up the volumes

# EBS Snapshots #

* [Code by Amir: Automated EBS Snapshots using AWS Lambda & CloudWatch](https://www.codebyamir.com/blog/automated-ebs-snapshots-using-aws-lambda-cloudwatch)
* [AWS Blog: Automating Amazon EBS Snapshot Management with AWS Step Functions and Amazon CloudWatch Events](https://aws.amazon.com/blogs/compute/automating-amazon-ebs-snapshot-management-with-aws-step-functions-and-amazon-cloudwatch-events/)
* [AWS documentation: Taking a Scheduled Snapshot with CloudWatch Events](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/TakeScheduledSnapshot.html)
* [AWS example solution: AWS Ops Automator](https://aws.amazon.com/answers/infrastructure-management/ops-automator/)
* [Karel Bemelmans: CloudFormation template for automated EBS volume backups using AWS Lambda and CloudWatch](https://www.karelbemelmans.com/2016/11/cloudformation-template-for-automated-ebs-volume-backups-using-aws-lambda-and-cloudwatch/)