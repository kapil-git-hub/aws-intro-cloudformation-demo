#!/bin/bash

if [ $# -ne 3 ]
then
    echo "Usage: AWS_PROFILE=<YOUR-PROFILE> ./CAREFULL-delete-cloudformation-stack.sh <prefix> <env> <region>"
    echo "Example: AWS_PROFILE=<YOUR-PROFILE> ./CAREFULL-delete-cloudformation-stack.sh aws-intro-cf-demo dev eu-west-1"
    exit 1
fi

MY_PREFIX=$1
MY_ENV=$2
MY_REGION=$3

aws cloudformation delete-stack --region=${MY_REGION} --stack-name ${MY_PREFIX}-${MY_ENV}-stack

