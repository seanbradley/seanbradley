#!/bin/bash
#
#cd ~
#mkdir .aws
#cd .aws
#touch credentials
#cd -

sudo apt-get aws-cli
./create_user.sh
./create_access_key.sh
#NOTE: copy and paste the keys to the 
#~/.aws/credentials file
./attach_access_policy_to_user.sh
./attach_cloudformation_policy_to_user.sh
./create_service_role.sh
./attach_service_role_policy.sh
./get_service_role_arn.sh
#Make a note of the Service Role ARN. 
#You need it to create a Deployment Group.
./create_instance_profile_role.sh
./attach_instance_role_policy.sh
./create_instance_profile.sh
./add_instance_profile_role_to_instance_profile.sh
./spin_up_instances.sh
./check_instance_status.sh
./create_tags.sh
./describe_instances.sh

    ssh -i ~/.ssh/<yourkeypair>.pem ec2-user@ec2-XX-XXX-XX-XX.compute-1.amazonaws.com

#When SSH'ing, regular EC2 Linux instances have #"ec2-user"; Ubuntu instances use "ubuntu". 
#Also chmod 400 the pem file of your keypair.

# Confirm that the Code Deploy Agent is installed...

    #to check service status
    sudo service codedeploy-agent status

    #to check which version
    sudo dpkg -s codedeploy-agent

    #to start the service 
    sudo service codedeploy-agent start 
    
    exit

#If service is missing or broken, see #"install_code_deploy_on_an_ec2_instance.txt" in 
#the /docs directory of this repo. 
#Install the service. Verify its status.

#For stack creation, instead of a single instance: #execute ./create_stack.sh
#confirm success with /describe_stack.sh]

./create_application.sh
./list_applications.sh
./get_service_role_arn.sh 
    
#Paste ARN into create_deployment_group.sh.

./create_deployment_group.sh
    
#You may need to create an autoscaling group first. A 
#load balancer may be specified with the autoscaling 
#group creation--meaning: you may also need to create
#an ELB 

#~~~~~

#this moves configure_db.sh from local to AWS; 
#it is executed manually from local before a new deployment;
#it sends configure_db.sh, which is leveraged in the
#appspec.yml
./transfer_wp_config_to_aws.sh

#during the deploy appspec.yml executes ./configure_db.sh
#as a post install script; configure_db does the following...
#1) writes config globals as envvars to ~/.bashrc
#2) overwrites the generic, empty, or placekeeper values in wp-config.php to reference those globals
#3) tweaks the httpd.conf
#4) creates a new root password for MySQL

#if successful, then have appspec.yml execute another script to delete configure_db.sh

#get new commit hash from git log
#increment line 7 and line 8 before executing
./create_deployment.sh



