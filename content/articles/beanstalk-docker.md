+++
Title = "Deploying Applications to Amazon Elastic Beanstalk with Docker"
Slug = "beanstalk-docker"
Date = "2016-09-09T20:26:00+01:00"
Description = "Deploying Web applications to Amazon Elastic Beanstalk with Docker"
Categories = ["administration"]
Tags = ["administration", "aws", "docker"]
Type = "article"
Draft = true

+++


<!--more-->

# Overview #

Amazon provide two different services that use containers:

* Elastic Beanstalk (*Elastic Beanstalk*)
* EC2 Container Service (*ECS*)

Elastic Beanstalk defaults to one container per instance. The EC2 Container Service provides tools for running sets of container hosts.

By default, Elastic Beanstalk uses two IAM roles:

* The *service role* is used by Elastic Beanstalk itself (by default, *aws-elasticbeanstalk-service-role*)
* The *instance profile* is the IAM role that instances use to access AWS resources (by default, *aws-elasticbeanstalk-ec2-role*)

You manage the Elastic Beanstalk service through the AWS Web console and the *eb* command-line utility.

To create or deploy an application, Elastic Beanstalk uses an *application bundle*, a ZIP file that contains the configuration files, and (if necessary) the application. The set of configuration files for an Elastic Beanstalk application that uses Docker are:

* Dockerrun.aws.json file - Configuration for the Docker engine on each Elastic Beanstalk instance
* .ebignore file - The list of files and directories to exclude from the application bundle
* The .ebextensions/ directory - Contains Elastic Beanstalk environment configuration files

Each time that Elastic Beanstalk creates or deploys an application, it uses the files in an application bundle that has been uploaded to an AWS S3 bucket. The *eb* command-line utility automates the process of generating an application bundle, uploading it to S3 and triggering the Elastic Beanstalk operations.

# Preparing The Application #

Here is an example .ebignore file:

    # Exclude everything
    *

    # Include the Elastic Beanstalk
    !Dockerrun.aws.json
    !.ebextensions/*.config

You may write the files in the .ebextensions/ directory in either YAML or JSON format. They must have the file extension *.config*, or the command-line tool will ignore them.

Specify a Docker image repository and image tag in the Dockerrun.aws.json file. Elastic Beanstalk will pull the image from the repository as part of the deployment process. This means that you only need to include the configuration files in the application bundle and nothing else. If you do not have a repository, refer to the next section.

Avoid including the Dockerfile. If a Dockerfile is present in the bundle Elastic Beanstalk will ignore the image specified in the Dockerrun.aws.json file and use the Dockerfile to build images on the instances.

## If You Have No Docker Image Repository ##

To build the Docker images on the instances, the repository should contain the items listed in the previous section, plus:

* Dockerfile - The build file for Docker images
* The application source code

Use the * .ebignore file to specify which files and directories will be excluded or included in the application bundle.

 Building Docker images requires significant resources, and will take many minutes on a smaller instance. Ideally, the process should be handled by Continuous Integration servers. If you must build images on the instances, ensure that you set the timeout period to long enough for this process to complete.

# Setting Up Amazon Elastic Beanstalk #

First of all, create a Docker repository. Once you have a Docker repository, you can build Docker images and publish them to it.

Specify the Docker image details in the Dockerrun.aws.json file.

Amazon provide free Docker repositories with the EC2 Container Registry (ECR), as part of ECS, and these may also be used by Elastic Beanstalk. Currently, ECR only runs in the US East region.

To enable Elastic Beanstalk instances to pull images from your registry, either attach a policy to the IAM role for the instances, or add a custom policy:

    {
      "Version": "2008-10-17",
      "Statement": [
        {
          "Sid": "AllowEbAuth",
          "Effect": "Allow",
          "Action": [
            "ecr:GetAuthorizationToken"
          ],
          "Resource": [
            "*"
          ] },
        {
          "Sid": "AllowPull",
          "Effect": "Allow",
          "Resource": [
              "arn:aws:ecr:us-east-1:account-id:repository/repository-name" ],
          "Action": [
            "ecr:GetAuthorizationToken",
            "ecr:BatchCheckLayerAvailability",
            "ecr:GetDownloadUrlForLayer",
            "ecr:GetRepositoryPolicy",
            "ecr:DescribeRepositories",
            "ecr:ListImages",
            "ecr:BatchGetImage"
          ] }
    ] }

IAM accounts must have the *ecr:GetAuthorizationToken* permission in order to login to any ECR repository.

## Setting Up The VPC ##

Each VPC must have an Internet Gateway and a Routing Table with an entry that associates 0.0.0.0/0 with the Gateway for the VPC. Otherwise, none of the systems within the VPC will be accessible from the public Internet.

To run an Elastic Beanstalk application with RDS, you need a minimum of three subnets:

* At least one public subnet for the instances and the load balancer
* Two subnets on different availability zones for RDS

The instances must be on a public subnet for the health monitoring to function.

The Elastic Beanstalk application instances must also explicitly have access to the RDS instance. Add a rule into the security group for the RDS cluster to enable the security group for the instances to access the correct port.

# Elastic Beanstalk Commands #

Commands for the *eb* command-line tool:

    eb create <environment> --tier <web or worker> --cname <dns name>

If you set a *Logging* directory in the *Dockerrun.aws.json* files from that directory on the container are available in the directory /var/log/eb-docker/containers/eb-current-app/ on the instance. This means that they will be included in log exports from Elastic Beanstalk.

# TODO #

* Use .ebextensions or AWS CLI to set up: VPC, public subnets, RDS instance, RDS database, Route 53 (if possible)
* Multiple public subnets for instances
* Versioning: Dockerfile label, Docker tag, Git tag, Elastic Beanstalk app version
* How to run admin tasks
* Run test suite from a container (needs a database to be running)
* Compile assets on host, not in container (assets precompile runs even if there are no changes)
* Tune Puma
* Consider CI testing
* Add container ID to Rails log tags
