#!/bin/bash
#
#>>>deploy.sh<<<
#
#MAIN SCRIPT FOR DEPLOYPRESS (BASH / AWS CLI)
#
#You must have the aws cli and credentials
#set up locally to use this script...
#
#cd ~
#mkdir .aws
#cd .aws
#touch credentials
#cd -
#sudo apt-get aws-cli
#
#The following git global config values must 
#already be set... 
#
#git config --global github.user <username>
#git config --global github.token <token>
#
#Once done, execute these steps...
#(These can be scripted, and run via a single BASH script
#place in the ~/Project directory on one's local machine)
#
#1) mkdir <projectname>
#[if automating this, mkdir via user input]
#2) cd <projectname>
#3) git clone https://github.com/seanbradley/wolfskill.git . #<--note the dot
#[clone via the GitHub API and include username/password in call]
#4) python scripts/set_up_env.py
#5) workon <projectname>
#6) python scripts/swap_project_name.py
#[see inline doc in swap_project_name about changing tags]
#7) ./deploy.sh (or deploy.py)
##############################

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

#NOTE: returns instance ID; plug into check_instance_status.sh and describe_instances.sh

./check_instance_status.sh
./create_tags.sh
./describe_instances.sh

#NOTE: returns public DNS; plug into connect_ec2.sh

./connect_ec2.sh

#When SSH'ing, regular EC2 Linux instances have #"ec2-user"; Ubuntu instances use "ubuntu". 
#Also chmod 400 the pem file of your keypair.

#Confirm that the Code Deploy Agent is installed...

    #check service status
    sudo service codedeploy-agent status

    #check which version
    sudo dpkg -s codedeploy-agent

    #start the service 
    sudo service codedeploy-agent start 
    
    exit

#If service is missing or broken...
./transfer_install_codedeploy.sh
./connect_ec2.sh
#Once connected, sudo su on EC2 machine. 
#You will need AWS credentials to complete installation.
./install_codedeploy.sh

#For stack creation, instead of a single instance: 
#execute ./create_stack.sh; confirm success with #/describe_stack.sh

#NOTE: create_stack.sh NOT POSSIBLE WITH CODEDEPLOY
#CodeDeploy requires the attachment of an IAM policy 
#when the instances are created (see 
#spin_up_instances.sh)

./create_application.sh
./list_applications.sh
./get_service_role_arn.sh 
    
#NOTE: Paste ARN into create_deployment_group.sh.

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


