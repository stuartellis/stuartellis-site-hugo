+++
Title = "Querying AWS"
Slug = "aws-queries"
Date = "2020-09-07T10:40:00+00:00"
Description = "Querying AWS"
Categories = ["automation", "devops"]
Tags = ["automation", "devops"]
Type = "article"
Toc = true

+++

Notes on querying AWS.

<!--more-->

# Features for Querying AWS 

There are three relevant features for queries:

- *query* - Shows the results of a  [JMESPath](https://jmespath.org) query on the returned data
- *filter* - Some AWS services support filters, to return limited sets of data
- *output* - The CLI provides this option to format the final output

The *query* option filters the data in the response, using the [JMESPath syntax](https://jmespath.org) to describe the filter. The filter is applied on the client-side (such as the CLI), before the response is sent to the output renderer, rather than on the AWS end.

> If you specify *json* or *yaml* formats, the AWS CLI applies the query after the complete document has been returned.

All of the AWS CLI commands support the *query* option. This uses the JMSPath syntax.

## Example CLI Queries

    aws cloudformation list-stacks --stack-status-filter DELETE_COMPLETE --output json --query "length(StackSummaries[?contains(@.StackName, 'lambda')])"

    aws cloudformation list-stacks --stack-status-filter DELETE_COMPLETE --output table --query "StackSummaries[].{Name: StackName, Deleted: DeletionTime}"

    aws cloudformation list-stacks --stack-status-filter DELETE_COMPLETE --output json --query "StackSummaries[].{Name: StackName, Desc: TemplateDescription} | [0:2]"

    aws cloudformation list-stacks --stack-status-filter CREATE_COMPLETE --output json --query "StackSummaries[?contains(@.StackName, 'web')].{Name: StackName, Created: CreationTime}"

    aws s3api list-objects --bucket example-bucket --output json --query "sort_by(Contents[?contains(@.Key, 'ansible')], &Key)"

> JMESPath uses dot-separated paths. The @ character represents the current element.

To understand the JMESPath syntax, use [the official tutorial](https://jmespath.org/tutorial.html).

> Numbers must be enclosed in backticks.

## Discovering Document Structures

It is difficult to construct queries without knowing the structure. To see the structure of the returned documents without running a large query, use the *max-items* option to generate a document with a small number of items:

    aws s3api list-objects-v2 --bucket www.mysite.example --output json --query "sort_by(Contents[?contains(@.Key, 'ansible')], &Key)" --max-items 1

Queries can include functions, such as *sum* and *sort*.

     aws s3api list-objects-v2 --bucket example-bucket --query "Contents[].[Key, Size]"

You can use the CLI to construct JSON results:

    aws s3api list-objects-v2 --bucket example-bucket --query "Contents[].{key: Key, size: Size}" --output json
