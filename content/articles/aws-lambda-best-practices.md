+++
Title = "Best Practices for AWS Lambda"
Slug = "aws-lambda-best-practices"
Date = "2019-06-09T12:53:00+01:00"
Description = "Best practices for AWS Lambda"
Categories = ["devops"]
Tags = ["devops"]
Type = "article"
Draft = true

+++

A colllection of best practices for [AWS Lambda](https://aws.amazon.com/lambda/).

<!--more-->

## Logging

- Format all logs in json. This allows you to use the json path filtering option on CW.
- Add function version & tag to the log lines. CW doesn't allow you to filter based on version.
- Don't expect CW log querying to work all the time.
- Output runtime stats to CW metrics.

## Resources

### Tools

- [AWS Serverless Application Model](https://aws.amazon.com/serverless/sam/)

### Code Examples

- [AWS Serverless Express](https://github.com/awslabs/aws-serverless-express) - Example of Lambda with Node.js and Express

### Information

- https://aws.amazon.com/blogs/compute/container-reuse-in-lambda/
- https://news.ycombinator.com/item?id=13775780,
  stlava on Mar 2, 2017
