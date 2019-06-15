+++
Title = "Deployments with AWS EC2 and Packer"
Slug = "aws-packer"
Date = "2018-12-16T18:18:00+01:00"
Description = "Using Packer to provide machine images for AWS EC2"
Categories = ["devops"]
Tags = ["devops", "packer"]
Type = "article"
Toc = true

+++

Notes on using [Packer](https://packer.io/) to provide machine images for deployment with AWS EC2.

<!--more-->

# Overview

[Packer](https://packer.io/) enables you to build machine images, which you can then deploy through whatever process that you decide. It includes support for Amazon Machine Images, Docker, Vagrant, VMWare, and several other popular image formats.

Packer itself is just a command-line tool. This means that it can be installed on an existing system.

# Packer Configuration

Each Packer project includes a template file, in JSON format. This defines the tasks that run to create a set of images. If you define multiple types of image in the same template, Packer can builld them in parallel.

Packer also reads configuration settings from environment variables. Several run-time [configuration options are environment variables](https://packer.io/docs/other/environment-variables.html).

Environment variables also enables you to avoid writing API keys such as AWS Access IDs in the template file: you can either specify the path to an AWS client configuration file as an environment variable, or specify individual settings as environment variables.

### Example Configuration

This example assumes that you will either provide the AWS Access Key, Secret Key and Region settings through environment variables, or run the process on an EC2 instance with an [appropriate IAM Role](https://packer.io/docs/builders/amazon.html#iam-task-or-instance-role).

```json
{
  "description": "Packer Template Example",
  "builders": [
    {
      "type": "amazon-ebs",
      "source_ami": "ami-09693313102a30b2",
      "instance_type": "t3.micro",
      "ssh_username": "ec2-user",
      "ami_name": "example {{timestamp}}",
      "region": "eu-west-1"
    }
  ],

  "provisioners": [
    {
      "type": "shell",
      "script": "setup-instance.sh"
    }
  ]
}
```

# Online Resources

- [Official Packer documentation](https://packer.io/docs/index.html)
- [Packer Your AMIs for Immutable Deployments](https://lobster1234.github.io/2017/04/23/packer-your-AMIs-for-immutable-aws-deployments/) - Tutorial with example configurations
- [Build and Deploy using Jenkins, Packer and Terraform](https://medium.com/@I_M_Harsh/build-and-deploy-using-jenkins-packer-and-terraform-40b2aafedaec) - Another tutorial with example configurations
