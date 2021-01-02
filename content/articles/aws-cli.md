+++
Title = "Notes on the AWS CLI"
Slug = "aws-cli"
Date = "2021-01-02T10:40:00+00:00"
Description = "Using the AWS CLI tool"
Categories = ["automation", "devops"]
Tags = ["automation", "devops"]
Type = "article"
Toc = true

+++

Notes on version 2 of the [command-line tool for AWS](https://aws.amazon.com/cli/).

<!--more-->

## Versions

AWS have now released version 2 of the CLI. This replaces version 1.

Use the latest version of the AWS CLI. AWS update the CLI regularly as they add and improve their services.

## The Configure Command

You can use the *configure* command to both view and edit the configration of the AWS CLI. It accepts sub-commands:

    aws configure list
	aws configure get region

> Use *get* and *set* to programmatically manage the AWS configuration.

## Configuration Files

The AWS CLI uses two files:

The *~/.aws/credentials* file:

- This is supported by all AWS SDKs
- It only contains credentials

The *~/.aws/config* file:

- This is only used by the CLI
- It can contain credentials, but that is not the default behaviour

> Use *role-arn* to specify credentials that are federated identities.

## Command Completion

To enable [command completion](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-parameters-prompting.html), add this line to your shell profile:

    complete -C aws2_completer aws2

> Press TAB to auto-complete resource names

## Outputs

Use *yaml-stream* as the default output format. This output format shows results as they are returned, which is important if large numbers of results are coming back. You can stop the query, or page backwards and forwards over the returned data.

> The *yaml-stream* output format was introduced in version 2 of the AWS CLI.

The output format is applied to the final result. This means that you can use the *query* option and format the result as any supported type of output.

## Command Syntax

Syntax:

    <SERVICE> <OPERATION> <PARAMETERS>

The OPERATION usually corresponds to an API method. The parameters become JSON. AWS responds with XML documents.

For example:

    aws ec2 describe-instances --instance-ids i-987654321abcdef3

> The CLI automatically handles paginated responses from AWS by making additional API calls.

The *yaml-stream* output format displays responses as they are received. Most output methods build a dataset in memory, but do not display it until all of the API calls have completed.

### Parameters

There are defined [parameter types](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-parameters-types.html). Parameter names and their values are separated by spaces on the command line. If a string value contains an embedded space, then you must surround the entire string with quotation marks.

> Use single quotation marks ' ' to enclose the parameters string.

You can use a short-hand syntax for specifying parameters:

    --option key1=value1,key2=value2,key3=value3

> In PowerShell, this must in a quoted string: --option "key1=value1,key2=value2,key3=value3"

Use quotation marks to enclose JSON:

    aws dynamodb get-item --table-name my-table --key '{"id": {"N":"1"}}'

If you use single quotation marks, you do not need to escape double quotation marks embedded in the JSON string. However, you need to escape each single quotation mark with a backtick \` within the JSON structure.

## Interactive Support

AWS CLI version 2 includes [interactive wizards](https://docs.aws.amazon.com/cli/latest/userguide/cli-usage-wizard.html) for common tasks. For example:

    aws dynamodb wizard new-table

### Auto Prompt

The CLI also provides the *cli-auto-prompt* option. This lists the required and optional parameters, and fills them out with the values that you specify.

## CLI Skeletons

Most of the commands support the ability to accept all of the parameter input from a file using the *cli-input-json* and *cli-input-yaml* parameters.

Those same commands provide the *generate-cli-skeleton* parameter, to generate a file in either JSON or YAML format with all of the parameters that you can edit and fill in. Then you can run the command with the relevant *cli-input-json* or *cli-input-yaml* parameter and point to the filled-in file. 

Run the command with the completed parameters by passing the completed template file to either the *cli-input-json* or *cli-input-yaml* parameter by using the *file://* prefix.

    aws ec2 run-instances --generate-cli-skeleton yaml-input > run-ec2.yaml
	aws ec2 run-instances --cli-input-yaml file://run-ec2.yaml

To override values in the input file, specify the names of the parameters as options:

    aws dynamodb create-table --cli-input-yaml file://run-dydb.yaml --table-name bettername

## Tricks

Use STS to determine your current identity:

    aws sts get-caller-identity

Use Secrets Manager to generate a random password:

    aws secretsmanager get-random-password --password-length 7

## Resources

- [Video: AWS Command Line Interface Deep Dive](https://www.youtube.com/watch?v=ZbgvG7yFoQI)
- [Video: AWS CLI v2 Changes](https://www.youtube.com/watch?v=U5y7JI_mHk8)
