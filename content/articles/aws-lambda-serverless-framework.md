+++
Title = "AWS Lambda with the Serverless Framework"
Slug = "aws-lambda-serverless-framework"
Date = "2018-04-21T15:29:00+01:00"
Description = ""
Categories = ["programming"]
Tags = ["aws", "node.js"]
Type = "article"
Draft = true

+++

Notes on developing for [AWS Lambda](https://aws.amazon.com/lambda/) with Node.js and the [Serverless](https://www.serverless.com) framework.

<!--more-->

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
  memorySize: 512
~~~

Add a *.gitignore* file to the repository with these lines:

    .DS_Store
    .serverless
    .vscode
    node_modules

Add ESLint and Prettier. Note that you do use *console* statements in Lambda, to write entries to the logs.

# Configuration

FIXME

Lambda injects environment variables into the environment that the application runs in. Lambda automatically encrypts the environment variables that are provided on deployment. [You can specify which KMS key is used](https://serverless.com/framework/docs/providers/aws/guide/functions#kms-keys).

[Set tags for each function](https://serverless.com/framework/docs/providers/aws/guide/functions#tags)

To retrieve

# Error Handling

FIXME

Dead Letter Queue (DLQ)

https://serverless.com/framework/docs/providers/aws/guide/functions#dead-letter-queue-dlq

# Logging

FIXME

CloudWatch Logs

Note that you can do [custom CloudWatch metrics](https://serverless.com/blog/serverless-ops-metrics/)

# Notifications

FIXME

SNS for email and SMS. Slack requires an extra package.

If the SNS topics and subscriptions are specifically for the application, manage them as [resources](https://serverless.com/framework/docs/providers/aws/guide/resources/).

Remember that you can get email addresses for AWS users from IAM.

# Data storage

FIXME

S3 for files.
DynamoDB for key-value structured data?

# Testing

FIXME

https://serverless.com/blog/ci-cd-workflow-serverless-apps-with-circleci/

# Environments

[Managing domains for API Gateway and Serverless](https://serverless.com/blog/serverless-api-gateway-domain/)

# Accessing Other AWS Resources

FIXME

* [Serverless integration with AWS API Gateway](https://serverless.com/framework/docs/providers/aws/events/apigateway/#lambda-proxy-integration)
* [Managing AWS Step Functions with Serverless](https://serverless.com/blog/how-to-manage-your-aws-step-functions-with-serverless/)
* [Running Lambda functions inside a VPC](https://serverless.com/framework/docs/providers/aws/guide/functions#vpc-configuration)

# Security

https://serverless.com/blog/abcs-of-iam-permissions/

* If you use API Gateway, [enable CORS on the gateway](https://serverless.com/framework/docs/providers/aws/events/apigateway#enabling-cors). [This blog post](https://serverless.com/blog/cors-api-gateway-survival-guide/) provides more detail.
* Set [concurrency limits for each function](https://docs.aws.amazon.com/lambda/latest/dg/concurrent-executions.html)

# Learning Resources

* [AWS Lambda official documentation](https://aws.amazon.com/documentation/lambda/)
* [AWS SDK for JavaScript](https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/index.html)
* [Serverless documentation for AWS Lambda](https://serverless.com/framework/docs/providers/aws/)
* [Index of plugins for the Serverless framework](https://github.com/serverless/plugins)
* [Walk-through of creating an application with Serverless](https://serverless.com/blog/anatomy-of-a-serverless-app/)
