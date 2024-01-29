#!/bin/bash

apt update -y && apt upgrade -y && apt auto-remove -y

apt install awscli -y

export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_SESSION_TOKEN=
export AWS_DEFAULT_REGION=us-east-1

STACK_NAME=tomcat
EC2_INSTANCE_TYPE=t2.medium

aws cloudformation deploy \
--template-file tomcat/script_ubuntu/ubuntu.yml \
--stack-name $STACK_NAME \
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--parameter-override InstanceType=$EC2_INSTANCE_TYPE