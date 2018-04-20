+++
Title = "AWS Lambda with the Serverless Framework"
Slug = "aws-lambda-serverless-framework"
Date = "2018-04-20T17:28:00+01:00"
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

Use *serverless* to create a new project from the template

Amend the configuration to use Node.js 8 in the Lambda environments.

Add a *.gitignore* file to the repository:

Add ESLint and Prettier.

# Configuration

FIXME


# Error Handling

FIXME


Dead Letter Queue (DLQ)

# Logging

FIXME


# Testing

FIXME


# Accessing Other AWS Resources

FIXME
