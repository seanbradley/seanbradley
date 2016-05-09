#!/bin/bash

aws cloudformation create-stack \
  --stack-name wolfstack002 \
  --template-url https://s3.amazonaws.com/grandmashouse/wp-w-local-mysql-cfn.template \
  --parameters \
    ParameterKey=DBPassword,ParameterValue=victorytrail \
    ParameterKey=KeyName,ParameterValue=us-west-2-keypair \
    ParameterKey=DBUser,ParameterValue=bluewolf \
    ParameterKey=InstanceType,ParameterValue=m1.small \
    ParameterKey=SSHLocation,ParameterValue=0.0.0.0/0 \
  --capabilities CAPABILITY_IAM
