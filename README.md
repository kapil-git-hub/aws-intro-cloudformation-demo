# AWS CloudFormation Short Intro Demonstration For Tieto Specialists  <!-- omit in toc -->


# Table of Contents  <!-- omit in toc -->
- [Introduction](#introduction)
- [AWS Solution](#aws-solution)
- [CloudFormation Code](#cloudformation-code)
- [Demonstration Manuscript](#demonstration-manuscript)
- [Suggestions How to Continue this Demonstration](#suggestions-how-to-continue-this-demonstration)


# Introduction

This demonstration can be used in training new cloud specialists who don't need to have any prior knowledge of AWS but who want to start working on AWS projects and building their AWS competence.

This demonstration is basically the same as [aws-intro-demo](https://github.com/tieto-pc/aws-intro-demo) with one difference: aws-intro-demo uses [Terraform](https://www.terraform.io/) as IaC tool, and this demonstration uses [CloudFormation](https://aws.amazon.com/cloudformation). The idea is to introduce another way to create infrastructure code in AWS and let developers to compare Terraform and CloudFormation and make their own decision which tool to use in their future projects.

This project demonstrates basic aspects how to create cloud infrastructure using code. The actual infra is very simple: just one EC2 instance. We create a virtual private cloud [vpc](https://aws.amazon.com/vpc/) and an application subnet into which we create the [EC2](https://aws.amazon.com/ec2/). There is also one [security group](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html) in the application subnet that allows inbound traffic only using ssh port 22. The infra creates private/public keys and installs the public key to the EC2 instance - you get the private key for connecting to the EC2 instance once you have deployed the infra.

I tried to keep this demonstration as simple as possible. The main purpose is not to provide an example how to create a cloud system (e.g. not recommending EC2s over containers) but to provide a very simple example of infrastructure code and tooling related creating the infra. I have provided some suggestions how to continue this demonstration at the end of this document - you can also send me email to my corporate email and suggest what kind of AWS or AWS POCs you need in your AS team - I can help you to create the POCs for your customer meetings.

NOTE: There are an equivalent Azure demonstrations - [azure-intro-demo](https://github.com/tieto-pc/azure-intro-demo) and [azure-intro-arm-demo](https://github.com/tieto-pc/azure-intro-arm-demo)- compare the AWS and Azure implementations and you realize how similar they are.


# AWS Solution

The diagram below depicts the main services / components of the solution.

![AWS Intro Demo Architecture](docs/aws-intro-demo.png?raw=true "AWS Intro Demo Architecture")

So, the system is extremely simple (for demonstration purposes): Just one application subnet and one EC2 instance doing nothing in the subnet. Subnet security group which allows only ssh traffic to the EC2 instance. 


# CloudFormation Code

TODO

# Demonstration Manuscript

TODO

# Suggestions How to Continue this Demonstration

We could add e.g. an autoscaling group and a load balancer to this demonstration but let's keep this demonstration as short as possible so that it can be used as an AWS introduction demonstration. If there are some improvement suggestions that our AS developers would like to see in this demonstration let's create other small demonstrations for those purposes, e.g.:
- Create a custom Linux image that has the Java app baked in.
- An autoscaling group for EC2s (with CRM app baked in) + a load balancer.
- Logs to CloudWatch.
- Use container instead of EC2.