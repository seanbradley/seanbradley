#!/bin/bash -xe
    
##########
#This file must stay out of version control.
##########

sudo yum update
sudo yum install ruby
sudo yum install aws-cli
cd /home/ec2-user

aws configure
#enter AWS Access Key ID
#enter AWS Secret Acces Key
#enter Default region name (us-east-1)
#enter Default output format (text)

aws s3 cp s3://aws-codedeploy-us-east-1/latest/install . --region us-west-1
chmod +x ./install
sudo ./install auto
