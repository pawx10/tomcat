#!/bin/bash

apt update -y && apt upgrade -y && apt auto-remove -y

apt install awscli -y

export AWS_ACCESS_KEY_ID=ASIAVS4F2WJDUOQUGQXX
export AWS_SECRET_ACCESS_KEY=IYfG5f1tb0M1EPXG+/nl2w8boJDIsUz0XGvDszXl
export AWS_SESSION_TOKEN=FwoGZXIvYXdzEEkaDNbHI7ak+Ntek7kjKSLGAXjWBcD7upjwndIJOl3yY4NxDMkEoaGntBHDaJZImi1DbCuo5LBGAlsQvAwIV2UnAp7l3a+CgJvL2NJJvI89wf2cV0U+yIk7o1H2zEMv1kP1pafRwavDajIIQYarZhX/H5wL4tCK1LSlzn/mY6noUaml0v2A9FxGzCl5e6ZFVvgKoUbpt4wfhAGk5iIU9muk2u4EnugleCJRw2csP7i9vPjq3GZGyUo8bN3GWfuTh6B6pguzuvH5lfcy1Ul2zv3XdJ2nCHWaciiPhN+tBjItpeKz9f8cO9VWySIgn9WHH2r9by5R2v18AbDjv+GVCwjLJ1i/DWs4j3VbdHZP
export AWS_DEFAULT_REGION=us-east-1

STACK_NAME=tomcat
EC2_INSTANCE_TYPE=t2.medium

aws cloudformation deploy \
--template-file tomcat/script_ubuntu/ubuntu.yml \
--stack-name $STACK_NAME \
--capabilities CAPABILITY_NAMED_IAM \
--no-fail-on-empty-changeset \
--parameter-override InstanceType=$EC2_INSTANCE_TYPE



