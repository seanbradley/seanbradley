#!/bin/bash -xe

#aws s3 cp s3://bucket-name/latest/install . --region region-name

#>>>bucket-name represents one of the following:

#aws-codedeploy-us-east-1 for instances in the US East (N. Virginia) region

#aws-codedeploy-us-west-1 for instances in the US West (N. California) region

#aws-codedeploy-us-west-2 for instances in the US West (Oregon) region

#aws-codedeploy-eu-west-1 for instances in the EU (Ireland) region

#aws-codedeploy-eu-central-1 for instances in the EU (Frankfurt) region

#aws-codedeploy-ap-northeast-1 for instances in the Asia Pacific (Tokyo) region

#aws-codedeploy-ap-southeast-1 for instances in the Asia Pacific (Singapore) region

#aws-codedeploy-ap-southeast-2 for instances in the Asia Pacific (Sydney) region

#aws-codedeploy-sa-east-1 for instances in the South America (São Paulo) region

#>>>region-name represents one of the following:

#us-east-1 for instances in the US East (N. Virginia) region

#us-west-1 for instances in the US West (N. California) region

#us-west-2 for instances in the US West (Oregon) region

#eu-west-1 for instances in the EU (Ireland) region

#eu-central-1 for instances in the EU (Frankfurt) region

#ap-northeast-1 for instances in the Asia Pacific (Tokyo) region

#ap-southeast-1 for instances in the Asia Pacific (Singapore) region

#ap-southeast-2 for instances in the Asia Pacific (Sydney) region

#sa-east-1 for instances in the South America (São Paulo) region

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

aws s3 cp s3://aws-codedeploy-us-west-2/latest/install . --region us-west-2
chmod +x ./install
sudo ./install auto
