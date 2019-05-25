+++
Title = "Minikube - Kubernetes on a Single Computer"
Slug = "minikube"
Date = "2019-05-25T09:08:00+01:00"
Description = "Using Minikube for developing with Kubernetes"
Categories = ["administration"]
Tags = ["administration", "kubernetes"]
Type = "article"

+++

[Minikube](https://kubernetes.io/docs/setup/minikube/) sets up and manages Kubernetes on a single host system, so that you can develop and test clusters on a laptop or a stand-alone server.

<!--more-->

# Overview

Minikube sets up and manage Kubernetes on a single system. This system could be a developer laptop, but it could also be a Linux server. For example, you can run Minikube on a CI system, to provide clusters for your integration tests.

Use Minikube to develop applications that will be deployed on Kubernetes clusters. You can also use it to develop and test cluster configurations.

Minikube uses standard Kubernetes components. This means that all of the tools for Kubernetes should work with Minikube.

# How It Works

By default, Minikube uses the virtual machine manager to create a new virtual machine, and installs all of the requirements for Kubernetes in this virtual machine. These requirements include the [kubeadm](https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/) tool, and a container run-time. Current versions of Minikube use Docker as the default container run-time.

If Minikube runs on a Linux operating system, it can set up Kubernetes directly on this system, instead of creating a virtual machine. In this case, you must install a container run-time on the host system yourself.

In either case, Minikube uses _kubeadm_ to set up a Kubernetes cluster on the target machine. First, Minikube installs the minimum set of Kubernetes components to operate a cluster, including the _etcd_ and _kubelet_ services. All of the other components of Kubernetes are then deployed as containers on the cluster, such as the API server and the Scheduler.

Finally, Minikube creates a kubectl context called _minikube_. This means that the copy of kubectl on the host system automatically connects to the Minikube cluster.

> You can use Minikube to set up several different Kubernetes clusters on the same host system.

# Manually Setting up Minikube on macOS

If possible, use Homebrew to manage the software on macOS 

1. Create a _~/.local/bin/_ directory
2. Add _~/.local/bin/_ to your PATH
3. Download kubectl for macOS, and copy it to _~/.local/bin/_
4. Download minikube for macOS, and copy it to _~/.local/bin/_
5. Install [hyperkit](https://github.com/moby/hyperkit) (unless you have already installed VirtualBox)
6. Install Docker

The Minikube documentation recommends that you use Hyperkit as the virtual machine manager on macOS. If you already use VirtualBox on macOS, you do not need to install Hyperkit, because Minikube supports both types of virtual machine manager.

Install Docker on the macOS host system, so that you can use the command-line tool when you need it. Avoid starting the Docker service, because you will be using Minikube to host your containers.

Optionally, install [Helm](https://helm.sh/) and [Skaffold](https://skaffold.dev) to deploy your applications. Download the versions for macOS and copy them to the _~/.local/bin/_ directory. Minikube itself does not use or require these tools.

## Creating a Cluster on Minikube

Minikube downloads images and sets up a cluster the first time that you run the _minikube start_ command. Configure Minikube before you start the cluster.

Always specify resource limits before you run the _start_ command:

    minikube config set memory 4096
    minikube config set cpus 2

To pin the Kubernetes version that Minikube uses, add the _--kubernetes-version_ option:

    minikube start --kubernetes-version=1.14.2

Use the _--extra-config_ option to pass other settings to Kubernetes components:

    minikube start --extra-config=

This feature uses kubeadm, so you can use the same settings as kubeadm.

By default, clusters use Docker as the container run-time. You can [configure a Minikube cluster to use another type of container run-time](https://kubernetes.io/docs/setup/minikube/#alternative-container-runtimes), such as CRI-O.

# Using Minikube for Local Development

To connect to the Docker instance on the Minikube server, use _minikube docker-env_ to set the necessary environment variables:

    eval $(minikube docker-env)

Skaffold supports docker-compose files as well as the default _skaffold.yaml_ configuration file.

Use Minikube to launch the Kubernetes Dashboard:

    minikube dashboard

The virtual machine has one IP address. Use NodePorts in Kubernetes to route traffic to specific applications.

Minikube supports attaching local directories on the host to pods in the Kubernetes cluster. This enables you to develop code on the host which immediately runs in containers on the Minikube cluster.

    minikube mount $(pwd) /var/www/html

You can also use the container run-time in the Minikube virtual machine to build containers for deployment. Use the _minikube docker-env_ command to output the environment variables that are needed to connect to the container run-time.

    eval $(minikube docker-env)

# Generating a Configuration File

To share a Minikube configuration between developers, use the features to export and import configurations. The configuration can be in a JSON file, or environment variables.

Use the _kubectl_ command with the _--dry-run_ option and the _-o_ option to create a manifest for a pod in JSON or YAML formats.

Remember to add resource constraints to your pod definitions.

# Customizing Minikube

Minikube includes an add-on manager. Several features are provided as addons. For example, the _ingress_ add-on allows access to services that are running on the cluster:

To list the addons:

    minikube addons list

To enable an addon:

    minikube addons enable ingress

To disable an addon:

    minikube addons disable ingress

# Editing the Minikube Configuration

Minikube also mounts directories from ~/.minikube/ to the virtual machine. This enables you to customize the virtual machine or the Kubernetes installation.

# Extra Tools

- [Helm](https://helm.sh/) - Package manager for Kubernetes
- [Skaffold](https://skaffold.dev/) - Deployment tool for Kubernetes
- [Ansible Role for Minikube](https://galaxy.ansible.com/gantsign/minikube)

The [Visual Studio Code extension for Kubernetes](ms-kubernetes-tools.vscode-kubernetes-tools) supports Minikube. For example, it automatically detects the Kubernetes cluster that is provided by Minikube, and includes commands to start and stop Minikube.

# Videos

- [Minikube Intro](https://www.youtube.com/watch?v=4x0CZmF_U5o), by Dan Lorenc, Minikube developer at Google
- [Developing Locally with Kubernetes](https://www.youtube.com/watch?v=_W6O_pfA00s), by Ryan Jarvinen, with [slides](http://gist-reveal.it/bit.ly/kubecon-dev)
- [Deep Dive: Minikube](https://www.youtube.com/watch?v=46-FXiSEfE4), Bálint Pató & Thomas Strömberg - covers the architecture of Minikube, and future directions for the project

# Articles

- [Sharing a Local Container Registry with Minikube](https://blog.hasura.io/sharing-a-local-registry-for-minikube-37c7240d0615/), by Hasura
- [Run multiple minikube Kubernetes clusters on Ubuntu Linux with KVM](https://gist.github.com/alexellis/eec21a96906726d08a071d58aee66ab9), by Alex Ellis
- [Minikube on Travis CI](https://kinvolk.io/blog/2017/10/running-kubernetes-on-travis-ci-with-minikube/), by Kinvolk
