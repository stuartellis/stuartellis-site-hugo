+++
Title = "Using AWS CloudTrail"
Slug = "aws-cloudtrail"
Date = "2018-08-30T18:39:00+01:00"
Description = "An introduction to AWS CloudTrail"
Categories = ["administration"]
Tags = ["administration", "aws", "cloudtrail"]
Type = "article"
Draft = true

+++

The CloudTrail service logs API calls across your
Amazon Web Services infrastructure, and is a key feature of the platform.

<!--more-->

CloudTrail can be used for troubleshooting issues as well as security auditing.

CloudTrail uses _trails_, which define which regions are monitored, the APIs to be logged, and where the log data should be sent.

CloudTrail tracks _management events_ and _data events_. Data events are operations performed on or within the resource itself, such as uploads to an S3 bucket, or calls to a Lambda function. 

AWS do not charge for the first trail that you configure in an account, provided that it only tracks management events.

Typically, you would use CloudTrail in conjunction with other services. 

By default, CloudTrail uses S3 to store captured data. Trails deliver logs to the specified S3 bucket every five minutes.

Trails can be integrated with CloudWatch, but you may choose other log analysis and notification systems for larger or more complex use cases. If you integrate a trail with CloudWatch, CloudTrail will also continue to write to the S3 bucket for that trail. 

FIXME: 21:40 in video for cross-account access

Optionally, CloudTrail offers a feature for validating the integrity of your logs. This generates hashes of your log files and delivers these digests to S3 hourly. You can then use the AWS CLI tool to validate logs or build this facility in your own tools.

FIXME: 28:50 for log integrity

CloudTrail writes into S3 sub-folders for Account ID and then AWS Region, so that you can set bucket access policies to restrict access to particular folders. It also delivers integrity digests to a separate folder than the main logs.

# Setting Up S3 Buckets for Log Storage

- Enable encryption at rest for the buckets
- Enable access logging for the buckets
- Restrict access to the buckets
- Enable MFA Delete, so that object cannot be removed from buckets
- Set a lifecycle policy to archive older data to Glacier

FIXME: AWS provide a sample CloudFormation template for S3 bucket policy 

# CloudTrail Configuration

- Create a trail that is enabled for all regions.
- Enable log file validation of CloudTrail logs
- Integrate CloudTrail with CloudWatch Logs
- Enable alerts for any activity on non-approved regions.

# Add CloudWatch Alarms

FIXME: AWS provide a sample CloudFormation template for CloudWatch Alarms

# Resources

- [AWS re:Invent 2015 | (SEC318) AWS CloudTrail Deep Dive](https://www.youtube.com/watch?v=t0e-mz_I2OU) - Video tutorial
- [8 AWS CloudTrail Best Practices for Governance, Compliance, and Auditin](https://www.skyhighnetworks.com/cloud-security-blog/aws-cloudtrail-best-practices-for-governance-compliance-auditing/)
- [Sharing AWS CloudTrail Log Files Between Accounts](https://aws.amazon.com/blogs/security/sharing-aws-cloudtrail-log-files-between-accounts/)
- [A Few CloudTrail best practices](http://www.oneguyinit.com/2017/02/a-few-cloudtrail-best-practices/) - Tutorial for enabling alerts for any activity on non-approved regions.
- [Visualize AWS Cloudtrail Logs Using AWS Glue and Amazon QuickSight](https://aws.amazon.com/blogs/big-data/streamline-aws-cloudtrail-log-visualization-using-aws-glue-and-amazon-quicksight/?nc1=b_rp)

# Libraries and Tools

- [AWS CloudTrail Processing Library](https://github.com/aws/aws-cloudtrail-processing-library) - Java library for working with CloudTrail logs
