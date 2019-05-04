+++
Title = "Kubernetes on a Single Computer with Minikube"
Slug = "minikube"
Date = "2019-05-04T16:31:00+01:00"
Description = "Using Minikube for developing with Kubernetes"
Categories = ["administration"]
Tags = ["administration", "kubernetes"]
Type = "article"
Draft = true

+++

[Minikube](https://github.com/kubernetes/minikube)

<!--more-->

# Overview

Minikube enables you to try out experimental features of Kubernetes before they are available on cloud providers.

Minikube can be run in a CI system, to provide a cluster for integration tests.

# How It Works

By default, Minikube uses the selected virtual machine manager to create a virtual machine. The virtual machine has a container run-time installed. By default, the container run-time is Docker.

You can run Minikube directly on a Linux system, instead of a virtual machine. In this case, you must install a container run-time. You must also ensure that the system has the requirements for Minikube, including specific versions of Linux tools such as iptables.

Minikube uses _kubeadm_ to set up the Kubernetes installation on the target machine. It installs the minimum set of Kubernetes components to operate a cluster, including the _etcd_ and _kubelet_ services. All of the other components of Kubernetes are then deployed as containers on the cluster, such as the API server and the Scheduler.

# Setting up Minikube

FIXME: Bash auto-completion

Minikube mounts directories from ~/.minikube/ to the virtual machine. This enables you to customize the virtal machine or the Kubernetes installation.

To pin the Kubernetes version that Minikube uses:

    minikube start --k8s-version=

Use the _--extra-config_ option to pass settings to Kubernetes components:

    minikube start --extra-config=

This feature use kubeadm, so the available settings are the same as using kubeadm directly.

# Configuring Minikube

Minikube includes an add-on manager:

     minikube addons list

FIXME: The _ingress_ add-on

To share a Minikube configuration between developers, use the features to export and import configurations. The configuration can be in a JSON file, or environment variables.

You can switch Minikube to another type of container run-time, such as CRI-O.

# Using Minikube for Local Development

Use Kubernetes Dashboard

The virtual machine has one IP address. Use NodePorts in Kubernetes to route traffic to specific applications.

Minikube supports attaching local directories on the host to pods in the Kubernetes cluster. This enables you to develop code on the host which immediately runs in containers on the Minikube cluster.

You can also use the container run-time in the Minikube virtual machine to build containers for deployment.

# Using Minikube for CI

Refer to TravisCI blog post.

# Third-Party Tools

The [Visual Studio Code extension for Kubernetes](ms-kubernetes-tools.vscode-kubernetes-tools) supports Minikube. For example, it automatically detects the Kubernetes cluster that is provided by Minikube, and includes commands to start and stop Minikube.

# Videos

[Minikube Intro – Dan Lorenc, Google](https://www.youtube.com/watch?v=4x0CZmF_U5o)
