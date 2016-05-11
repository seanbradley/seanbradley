#!/bin/bash -xe
    
##########
#This file must stay out of version control.
##########

echo "Transferring CodeDeploy agent installation script..."
rsync -azv --progress --rsync-path="sudo rsync" --no-R --no-implied-dirs -e "ssh -i /home/seanbradley/.ssh/us-west-2-keypair.pem" /home/seanbradley/Projects/wolfskill/scripts/install_codedeploy.sh ec2-user@54.188.227.137:~/install_codedeploy.sh
