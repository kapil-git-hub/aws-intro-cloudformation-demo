#!/bin/bash

if [ $# -ne 5 ]
then
    echo "Usage: AWS_PROFILE=<YOUR-PROFILE> ./create-cloudformation-stack.sh <prefix> <env> <region> <key-name> <yaml-file>"
    echo "Example: AWS_PROFILE=<YOUR-PROFILE> ./create-cloudformation-stack.sh aws-intro-cf-demo dev eu-west-1 demo-key aws-intro-cloudformation.yaml"
    exit 1
fi

MY_PREFIX=$1
MY_ENV=$2
MY_REGION=$3
MY_KEY=$4
YAML_FILE_NAME=$5

aws cloudformation create-stack --region=${MY_REGION} --template-body file://${YAML_FILE_NAME} --stack-name ${MY_PREFIX}-${MY_ENV}-stack --capabilities CAPABILITY_NAMED_IAM --parameters ParameterKey=Env,ParameterValue=${MY_ENV} ParameterKey=Prefix,ParameterValue=${MY_PREFIX} ParameterKey=KeyName,ParameterValue=${MY_KEY}

