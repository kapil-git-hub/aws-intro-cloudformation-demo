# AWS CloudFormation Short Intro Demonstration For Tieto Specialists  <!-- omit in toc -->


# Table of Contents  <!-- omit in toc -->
- [Introduction](#introduction)
- [AWS Solution](#aws-solution)
- [CloudFormation Code](#cloudformation-code)
- [AWS Command Line Interface](#aws-command-line-interface)
- [Demonstration Manuscript](#demonstration-manuscript)
- [Suggestions How to Continue this Demonstration](#suggestions-how-to-continue-this-demonstration)


# Introduction

This demonstration can be used in training new cloud specialists who don't need to have any prior knowledge of AWS but who want to start working on AWS projects and building their AWS competence.

This demonstration is basically the same as [aws-intro-demo](https://github.com/tieto-pc/aws-intro-demo) with one difference: aws-intro-demo uses [Terraform](https://www.terraform.io/) as IaC tool, and this demonstration uses [CloudFormation](https://aws.amazon.com/cloudformation). The idea is to introduce another way to create infrastructure code in AWS and let developers to compare Terraform and CloudFormation and make their own decision which tool to use in their future projects.

This project demonstrates basic aspects how to create cloud infrastructure using code. The actual infra is very simple: just one EC2 instance. We create a virtual private cloud [vpc](https://aws.amazon.com/vpc/) and an application subnet into which we create the [EC2](https://aws.amazon.com/ec2/). There is also one [security group](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html) in the application subnet that allows inbound traffic only using ssh port 22. In this demonstration you have to create manually the Key pair - you get to use the AWS Console if you haven't used it before. Once you have deployed the CloudFormation stack you can use the private key of the Key pair for connecting to the EC2 instance.

I tried to keep this demonstration as simple as possible. The main purpose is not to provide an example how to create a cloud system (e.g. not recommending EC2s over containers) but to provide a very simple example of infrastructure code and tooling related creating the infra. I have provided some suggestions how to continue this demonstration at the end of this document - you can also send me email to my corporate email and suggest what kind of AWS or AWS POCs you need in your AS team - I can help you to create the POCs for your customer meetings.

NOTE: There are an equivalent Azure demonstrations - [azure-intro-demo](https://github.com/tieto-pc/azure-intro-demo) and [azure-intro-arm-demo](https://github.com/tieto-pc/azure-intro-arm-demo)- compare the AWS and Azure implementations and you realize how similar they are.


# AWS Solution

The diagram below depicts the main services / components of the solution.

![AWS Intro Demo Architecture](docs/aws-intro-demo.png?raw=true "AWS Intro Demo Architecture")

So, the system is extremely simple (for demonstration purposes): Just one application subnet and one EC2 instance doing nothing in the subnet. Subnet security group which allows only ssh traffic to the EC2 instance. 


# CloudFormation Code

All CloudFormation infra code is provided in file [aws-intro-cloudformation.yaml](https://github.com/tieto-pc/aws-intro-cloudformation-demo/blob/master/cloudformation/aws-intro-cloudformation.yaml). You could modularize your CloudFormation stack using [Nested Stacks](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/using-cfn-nested-stacks.html) but you have to store the nested stacks in S3 - too much trouble for a small demo like this, so I provided the whole stack in one yaml file. Let's walk through the file together.

The stack template starts with **parameters** section. Here we define the same prefixes we are using also in the aws-intro-demo Terraform implementation: Prefix and Env (I skipped the rest of the tag keys - an exercise for the learner if you wish to do so). Here we also define some other parameters I use in the template like Instance type, AMI id and Key name.

Then in the **resources** section we define the actual resources: VPC, Subnet, InternetGateway, RouteTable, Route, EIP, Security group, InstanceRole and the actual EC2 instance. Compare [aws-intro-cloudformation.yaml](https://github.com/tieto-pc/aws-intro-cloudformation-demo/blob/master/cloudformation/aws-intro-cloudformation.yaml) CloudFormation code with aws-intro-demo's Terraform code found in [modules](https://github.com/tieto-pc/aws-intro-demo/tree/master/terraform/modules) directory - you can see how all the entities are defined pretty much the same, only the notation is different.


# AWS Command Line Interface

You need to install the [AWS Command Line Interface](https://aws.amazon.com/cli/).

Then create yourself AWS access and secret keys. Go to AWS portal / IAM / YOUR-USER-ACCOUNT. You can find there "Security credentials" section => create the keys here. Then you should create an AWS profile to the configuration section in your ~/.aws/credentials. Add a section for your AWS account and copy-paste the keys there, e.g.:

```text
[my-aws-profile]
aws_access_key_id = YOUR-ACCESS-KEY
aws_secret_access_key = YOUR-SECRET-KEY
```

Whenever you use aws cli you should give the AWS profile environment variable with the command, e.g.:

Linux:

```bash
AWS_PROFILE=MY-PROFILE <MY-CLI-COMMAND>
```

Windows:

```dos
set AWS_PROFILE=MY-PROFILE
<MY-CLI-COMMAND>
```


# Demonstration Manuscript

This time I didn't test the deployment using Windows (I just used my Linux workstation) - but I assume the enlightened Windows user should find no problems walking through this demonstration with a Windows workstation. There are certain issues a Windows user must tackle: the scripts are written using bash - either use e.g. Git Bash or just read the bash scripts and run the **aws cli** commands in your Windows command prompt. If some Windows user wants to see the trouble to convert the bash scripts used in this demonstration to Bat or Powershell scripts I'm happy to receive a push request. In the Terraform exercise I added functionality to create the key pair as part of the deployment and store the private key automatically to developer's workstation. In this CloudFormation exercise I skipped that part and you have to create the key pair manually (don't worry - detailed instructions given how to do that).

1. Install the [AWS Command Line Interface](https://aws.amazon.com/cli/) and setup your AWS profile as instructed above.
2. Clone this project: git clone https://github.com/tieto-pc/aws-intro-cloudformation-demo.git .
3. Create a key pair in AWS Console (portal). Navigate to: EC2 Dashboard => Key Pairs => Create a new key pair, give name for the key pair (and write it down) and store the private key to your workstation's folder.
4. Open console in [cloudformation](cloudformation) folder. Give command: ```AWS_PROFILE=<YOUR-PROFILE> ./create-cloudformation-stack.sh <prefix> <env> <region> <key-name> <yaml-file>```. Windows users: you can give the aws cli command as given in the bash script and populate the values directly to the aws cli command.
5. Open AWS Console (portal). Navigate to: CloudFormation. Find the stack you are deploying and browse the events. Refresh the events and you can see how AWS is deploying the resources in your stack template.
6. Wait until the stack is fully deployed: AWS Console => CloudFormation => Stack info => Stack status: "CREATE_COMPLETE".
7. Open AWS Console (portal): Navigate to EC2 Dashboard. Click the EC2 instance that CloudFormation created earlier. Check the public IP (write it down).
8. Open console. Navigate to folder you stored your private key of the key pair you created earlier. Give command: ```ssh -i <key-file> ubuntu@<PUBLIC-IP>```. You should be able to login to the EC2 instance.
9. Finally delete the stack (and resources): ```AWS_PROFILE=<YOUR-PROFILE> ./CAREFULL-delete-cloudformation-stack.sh <prefix> <env> <region>```.

The official demo is over. Next you could do the equivalent [aws-intro-demo](https://github.com/tieto-pc/aws-intro-demo) that uses Terraform. Then compare the Terraform and CloudFormation code and also the workflows. Reflect the two tools - which pros and cons they have when compared to each other? Which one would you like to start using? And why?


# Suggestions How to Continue this Demonstration

We could add e.g. an autoscaling group and a load balancer to this demonstration but let's keep this demonstration as short as possible so that it can be used as an AWS introduction demonstration. If there are some improvement suggestions that our AS developers would like to see in this demonstration let's create other small demonstrations for those purposes, e.g.:
- Create a custom Linux image that has the Java app baked in.
- An autoscaling group for EC2s (with CRM app baked in) + a load balancer.
- Logs to CloudWatch.
- Use container instead of EC2.