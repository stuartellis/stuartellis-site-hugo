+++
Title = "AWS CloudWatch"
Slug = "cloudwatch"
Date = "2016-09-16T16:20:00+01:00"
Description = "An introduction to AWS CloudWatch"
Categories = ["administration"]
Tags = ["administration", "aws", "cloudwatch"]
Type = "article"
Draft = true

+++


The CloudWatch service manages logging and event monitoring for your entire
Amazon Web Services infrastructure, and is a key feature of the platform.

<!--more-->

# Overview #

CloudWatch itself is a data repository that collects metrics. Attached to it are
two other services: *CloudWatch Events* for dispatching real-time events, and
*CloudWatch Logs* for storing log files.

A *metric* is a series of data points over time for a particular source. Every
metric is identified by a *dimension*, which is a set of two key-value pairs,
e.g. *Server=Prod,Domain=Frankfurt*. Each metric also belongs to a *namespace*.
Data points consist of a timestamp and a value.

Once you have created a metric, you can add *alarms*. Each alarm watches the
specified metric for a given period of time, and either sends a message to the
Simple Notification Service (SNS) or trigger an Auto-Scaling Policy if the
metric meets the alarm criteria for longer than a given period of time.

CloudWatch stores data for 14 days.

Each AWS region is independent, with separate metrics, alarms, and logs.

# CloudWatch Alarms #
