#!/bin/bash
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=

export AWS_SESSION_TOKEN=
export AWS_DEFAULT_REGION=
aws cloudformation delete-stack \
--stack-name tomcat \

