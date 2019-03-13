#!/bin/bash

if [ $# -ne 1 ]
then
    echo "Usage: AWS_PROFILE=<YOUR-PROFILE> ./validate-cloudformation-stack.sh <yaml-file>"
    echo "Example: AWS_PROFILE=<YOUR-PROFILE> ./validate-cloudformation-stack.sh aws-intro-cloudformation.yaml"
    exit 1
fi

YAML_FILE_NAME=$1

aws cloudformation validate-template --template-body file://${YAML_FILE_NAME}
