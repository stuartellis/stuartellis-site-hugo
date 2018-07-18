+++
Title = "Static Websites with AWS CloudFormation"
Slug = "static-sites-cloudformation"
Date = "2018-07-18T19:33:00+01:00"
Description = "Managing static Websites with AWS CloudFormation"
Categories = ["administration", "cloud"]
Tags = ["administration", "aws", "cloud"]
Type = "article"
Draft = true

+++

This articles describes how to orchestrate AWS services with CloudFormation to deploy
static Websites.

<!--more-->

# Hosting Static Websites on AWS

To host a static Website on AWS, you need:

- An S3 bucket to store the content
- A CloudFront distribution
- An SSL certificate in Certificate Manager

Optionally, you can use Route 53 for the DNS records.

You can use a CloudFormation template to manage all of these.

# Resources

## AWS CloudFormation

- [YAML in One Video](https://www.youtube.com/watch?v=cdLNKUoMc6c)
- [Cloudonauts free templates for CloudFormation](https://cloudonaut.io/templates-for-aws-cloudformation/)

## Static Websites on AWS

- [Hosting a Static Website on Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html) -
  Official documentation

