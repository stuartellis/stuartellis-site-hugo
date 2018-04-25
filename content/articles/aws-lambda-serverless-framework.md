+++
Title = "AWS Lambda with the Serverless Framework"
Slug = "aws-lambda-serverless-framework"
Date = "2018-04-25T16:43:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["aws", "node.js"]
Type = "article"
Draft = true

+++

Notes on developing for [AWS Lambda](https://aws.amazon.com/lambda/) with Node.js and the [Serverless](https://www.serverless.com) framework.

<!--more-->

# Overview

You can manage Lambda with DevOps infrastructure tools like Terraform and Ansible.

Alternatives to the Serverless framework include [Claudia.js](https://claudiajs.com/) and [Apex](http://apex.run/).

Serverless supports multiple languages and providers. It integrates with CloudFormation, which avoids the need to work with additional tools.

Each function must be stateless, because it may be launched in a new container. In REST terms, you should have one function per HTTP verb.

Each function must also be idempotent, because the same event can trigger a function multiple times, due to retries.

Lambda enables you to isolate and scale tasks. It is useful for dynamic or infrequent workloads, such as scheduled jobs, and sites with variable levels of traffic. Avoid tasks that take long periods of time.

# Installation

Install the command-line tool:

    npm -g installer serverless

This installs the *serverless* command-line tool.

For convenience, the *serverless* tool also has the command-line alias *sls*.

# Setting Up the Project

Use *serverless* to create a new project from the *aws-nodejs* template:

    serverless create --template aws-nodejs --path PROJECT

Amend the configuration in *serverless.yml* to use Node.js 8 in the Lambda environments:

~~~yaml
provider:
  name: aws
  runtime: nodejs8.10
# stage: dev
  region: eu-west-1
  memorySize: 128
~~~

> Start with a lower memorySize, and carry out performance tests with higher memorySize settings. Larger sizes execute faster, so may be cheaper overall.

Add a *.gitignore* file to the repository with these lines:

    .DS_Store
    .serverless
    .vscode
    node_modules

Add ESLint and Prettier. Note that you do use *console* statements in Lambda, to write entries to the logs.

Consider adding a Serverless plugin to minify your JavaScript code.

# Configuration

FIXME

Lambda injects environment variables into the environment that the application runs in. Lambda automatically encrypts the environment variables that are provided on deployment. [You can specify which KMS key is used](https://serverless.com/framework/docs/providers/aws/guide/functions#kms-keys).

[Set tags for each function](https://serverless.com/framework/docs/providers/aws/guide/functions#tags)

# Error Handling

FIXME

Useful pattern: log error with console.log(error) and then re-throw:

~~~javascript
if(error) {
      console.log(error);
      throw new Error(error[0].message);
  }
~~~

Note that *console.error()* does generate a message in CloudWatch logs, but does not increment a CloudWatch metric.

Third-party services like Raygun or Sentry provide exception tracking for errors that reach the top of the call stack.

Failed Lambda functions are automatically retried for *asynchronous* event sources like S3 and CloudWatch Events. Some event sources are classified as *synchronous*, like DynamoDB Streams, and retries are initiated by the event source. In the case of DynamoDB, the stream that is the event source is blocked until the function succeeds, or the event expires.

The Dead Letter Queue (DLQ) for a function holds failed executions, along with the event payload. A DLQ can be either SNS or SQS. The *DLQ Errors* metric in CloudWatch increments when a failed execution is added to the DLQ. This enables you to implement error handling outside of the individual function.

https://serverless.com/framework/docs/providers/aws/guide/functions#dead-letter-queue-dlq

> Remember that you can debug JavaScript Lambda functions with [AWS X-Ray](https://aws.amazon.com/xray/).

# Logging and Monitoring

FIXME

CloudWatch Logs

Note that default retention of events is forever!

Use [metric filters](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/MonitoringLogData.html) on CloudWatch to get metrics from log messages.

Note that you can do [custom CloudWatch metrics](https://serverless.com/blog/serverless-ops-metrics/)

[Runscope](https://www.runscope.com/) is a specialised service for API monitoring.

# Notifications

FIXME

SNS for email, SMS, and triggering dependent functions. Slack requires an extra package.

If the SNS topics and subscriptions are specifically for the application, manage them as [resources](https://serverless.com/framework/docs/providers/aws/guide/resources/).

Remember that you can get email addresses for AWS users from IAM.

# Data storage

FIXME

S3 for files.
DynamoDB for key-value structured data?
Aurora is a SQL data store. [Serverless Aurora](https://aws.amazon.com/rds/aurora/serverless/) is in preview

Remember that if you provision a resource as part of your application, it will be destroyed if you delete the application.

Consecutive calls of the same function may or may not use the same context, so always clean up database connections.

Note that DynamoDB is proprietary and specific to AWS. Aurora services will be compatible with MySQL or PostgreSQL.

# Testing

FIXME

https://serverless.com/blog/ci-cd-workflow-serverless-apps-with-circleci/

# Environments

[Managing domains for API Gateway and Serverless](https://serverless.com/blog/serverless-api-gateway-domain/)

API Gateway is for exposing sets of functions as a single API. It uses CloudFront for resilience.

You can invoke any Lambda function by using AWS SDK to make API calls, without needing an instance of API Gateway.

You can separate environments completely by using separate AWS accounts. The initial limit of 1,000 concurrent functions applies per account.

Remember there will be one cold start per concurrent call, as AWS launches extra containers. This means that it is hard to control latency. You may decide to run requests purely to keep functions warm.

# Accessing Other AWS Resources

FIXME

* [Serverless integration with AWS API Gateway](https://serverless.com/framework/docs/providers/aws/events/apigateway/#lambda-proxy-integration)
* [Managing AWS Step Functions with Serverless](https://serverless.com/blog/how-to-manage-your-aws-step-functions-with-serverless/)
* [Running Lambda functions inside a VPC](https://serverless.com/framework/docs/providers/aws/guide/functions#vpc-configuration)

# Security

https://serverless.com/blog/abcs-of-iam-permissions/

* Use the features of AWS services to filter the events, so that only valid events will trigger a Lambda function.
* Ensure that you validate every event. Use a validator such as Joi.
* If you use API Gateway, [enable CORS on the gateway](https://serverless.com/framework/docs/providers/aws/events/apigateway#enabling-cors). [This blog post](https://serverless.com/blog/cors-api-gateway-survival-guide/) provides more detail.
* Set [concurrency limits for each function](https://docs.aws.amazon.com/lambda/latest/dg/concurrent-executions.html)
* Set CloudWatch alarms for concurrency
* Set a billing alert, so that are warned you if there is an issue that generates heavy use in an AWS account
* AWS does not provide SLAs on Lambda. Consider your disaster recovery strategy if Lambda has issues in an AWS region.

# Learning Resources

## Documentation

* [AWS Lambda official documentation](https://aws.amazon.com/documentation/lambda/)
* [AWS SDK for JavaScript](https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/index.html)
* [Serverless documentation for AWS Lambda](https://serverless.com/framework/docs/providers/aws/)
* [Index of plugins for the Serverless framework](https://github.com/serverless/plugins)
* [Walk-through of creating an application with Serverless](https://serverless.com/blog/anatomy-of-a-serverless-app/)
* [How to operate reliable AWS Lambda applications in production](https://www.concurrencylabs.com/blog/how-to-operate-aws-lambda/)

## Videos

* [Real world serverless - architecture, patterns and lessons learned by David Schmitz](https://www.youtube.com/watch?v=uMCtcZ46gns)
* [Serverless - reality or BS - notes from the trenches - Lynn Langit](https://www.youtube.com/watch?v=PgZ2dxnj734)
* [AWS re:Invent 2017: Become a Serverless Black Belt: Optimizing Your Serverless Applications (SRV401)](https://www.youtube.com/watch?v=oQFORsso2go)
