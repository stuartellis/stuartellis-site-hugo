+++
Title = "Static Websites with AWS CloudFormation"
Slug = "static-sites-cloudformation"
Date = "2018-08-02T21:55:00+01:00"
Description = "Managing static Websites with AWS CloudFormation"
Categories = ["administration", "cloud"]
Tags = ["administration", "aws", "cloud"]
Type = "article"
Draft = true

+++

This articles describes how to orchestrate AWS services with CloudFormation to deploy static Websites.

<!--more-->

# Hosting Static Websites on AWS

S3 includes a feature to serve the contents of a bucket as a Website. This is useful in cases where you want to host a Website that can only be accessed by a limited set of users. If you want to host a public Website, put he files for the site in an S3 bucket, and set up CloudFront to act as the main server.

# Setting Up a Public Website with S3 and CloudFront

To host a static Website on AWS with CloudFront, you need:

- An S3 bucket to store the content
- A CloudFront distribution
- An SSL certificate in Certificate Manager

CloudFront includes a feature called _Origin Access Identity_, that allows a CloudFront distribution to access files in an S3 bucket without the need to enable public access to the bucket.

Optionally, you can also use Route 53 for the DNS records, which means that all of the elements of the site are in your AWS account.

You can use a CloudFormation template to manage all of these resources.

# Resources

## Static Websites on AWS

- [Hosting a Static Website on Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html) - Official documentation

## AWS CloudFormation

- [YAML in One Video](https://www.youtube.com/watch?v=cdLNKUoMc6c)
- [Cloudonauts free templates for CloudFormation](https://cloudonaut.io/templates-for-aws-cloudformation/)

## Tools

- [Hugo](https://gohugo.io) - Static Website generator
- [S3deploy](https://github.com/bep/s3deploy) - Deploys static websites to Amazon S3
