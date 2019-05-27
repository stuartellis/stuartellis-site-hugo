+++
Title = "Static Websites with AWS CloudFormation"
Slug = "static-sites-cloudformation"
Date = "2018-08-11T12:41:00+01:00"
Description = "Managing static Websites with AWS CloudFormation"
Categories = ["devops", "cloud"]
Tags = ["devops", "aws", "cloud"]
Type = "article"
Draft = true

+++

This articles describes how to orchestrate AWS services with CloudFormation to deploy static Websites.

<!--more-->

# Hosting Static Websites on AWS

AWS provides a Content Delivery Network (CDN) service called CloudFront. You may use CloudFront with any Website, but it has specific features for integrating with other AWS services, such as S3 file storage.

S3 includes a feature to serve the contents of a bucket as a Website. This is useful in cases where you want to host a Website that can only be accessed by a limited set of users. If you want to host a public Website, put he files for the site in an S3 bucket, and set up CloudFront to act as the main server.

# Setting Up a Public Website with S3 and CloudFront

To host a static Website on AWS with CloudFront, you need:

- An S3 bucket to store the content
- A CloudFront distribution
- An SSL certificate in Certificate Manager

Certificate Manager provides free SSL certificates. CloudFront can use certificates that have been issued by Certificate Manager to serve your Website with SSL.

Optionally, you can also use host the DNS domain with Route 53, the AWS service for DNS. This means that all of the elements of the site are in your AWS account.

You can use a CloudFormation template to manage all of these resources.

CloudFront includes a feature for integrating with S3 called _Origin Access Identity_, which allows a CloudFront distribution to access files in an S3 bucket without the need to enable public access to the bucket. Unfortunately, CloudFront cannot serve directories from S3 if you use Origin Access Identity. This means that if your URLs point to directories, rather than individual files, you must configure S3 to act as a public Website.

# Resources

## Static Websites on AWS

- [Hosting a Static Website on Amazon S3](https://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteHosting.html) - Official documentation
- [Serving index pages from a non-root location via CloudFront](http://someguyontheinter.net/blog/serving-index-pages-from-a-non-root-location-via-cloudfront/)

## Tools

- [Hugo](https://gohugo.io) - Static Website generator
- [s3deploy](https://github.com/bep/s3deploy) - Deploys static websites to Amazon S3
