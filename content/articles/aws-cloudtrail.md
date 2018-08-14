+++
Title = "AWS CloudTrail"
Slug = "cloudtrail"
Date = "2018-08-14T07:05:00+01:00"
Description = "An introduction to AWS CloudTrail"
Categories = ["administration"]
Tags = ["administration", "aws", "cloudtrail"]
Type = "article"
Draft = true

+++

The CloudTrail service logs API calls across your
Amazon Web Services infrastructure, and is a key feature of the platform.

<!--more-->

CloudTrail uses _trails_, which define which regions are monitored, the APIs to be logged, and where the log data should be sent.

# Setting Up S3 Buckets for Log Storage

- Enable encryption at rest for the buckets
- Enable access logging for the buckets
- Restrict access to the buckets
- Require MFA to delete CloudTrail buckets

# CloudTrail Configuration

- Create a trail that is enabled for all regions.
- Enable log file validation of CloudTrail logs
- Integrate CloudTrail with CloudWatch Logs
- Enable alerts for any activity on non-approved regions.

# Resources

- [8 AWS CloudTrail Best Practices for Governance, Compliance, and Auditin](https://www.skyhighnetworks.com/cloud-security-blog/aws-cloudtrail-best-practices-for-governance-compliance-auditing/)
- [Sharing AWS CloudTrail Log Files Between Accounts](https://aws.amazon.com/blogs/security/sharing-aws-cloudtrail-log-files-between-accounts/)
- [A Few CloudTrail best practices](http://www.oneguyinit.com/2017/02/a-few-cloudtrail-best-practices/) - Tutorial for enabling alerts for any activity on non-approved regions.
- [Visualize AWS Cloudtrail Logs Using AWS Glue and Amazon QuickSight](https://aws.amazon.com/blogs/big-data/streamline-aws-cloudtrail-log-visualization-using-aws-glue-and-amazon-quicksight/?nc1=b_rp)
