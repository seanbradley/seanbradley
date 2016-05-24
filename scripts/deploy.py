"""
MAIN SCRIPT FOR DEPLOYPRESS (PYTHON)

Refactoring deploy.sh as a boto driven python script

Before this script can be used, you must set up the 
aws-cli tools and set your credentials locally,
like so...

cd ~
mkdir .aws
cd .aws
touch credentials
cd -
sudo apt-get aws-cli

To configure boto, see...
http://boto.cloudhackers.com/en/latest/boto_config_tut.html
"""

import boto
import os, sys, subprocess
from os import environ
from os.path import basename
from set_up_env import startenv
#from unipath import Path

#from django.core.exceptions import ImproperlyConfigured
def get_env_variable(var_name):
    """ Get the environment setting or return exception """
    try:
        return os.environ[var_name]
    except KeyError:
        error_msg = "Set the %s environment variable" % var_name
        #raise ImproperlyConfigured(error_msg)

AWS_ACCESS_KEY_ID = get_env_variable("AWS_ACCESS_KEY_ID")
AWS_SECRET_ACCESS_KEY = get_env_variable("AWS_SECRET_ACCESS_KEY")

os.system('/bin/bash  --rcfile %/bin/activate') % projectname



#CREATE USER
#./create_user.sh

# Connect to IAM with boto
iam = boto.connect_iam(AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY)

# Create user
user_response = iam.create_user(username)

# Limit access with IAM policy
policy_json = '''{
    "Statement":[{
        "Sid":"RandomStringIdentifier",
        "Action":"s3:*",
        "Effect":"Allow",
        "Resource":"arn:aws:s3:::houdini/*"
    }]
}'''
iam.put_user_policy(username, 'allow_access_houdini', policy_json)

# Generate new access key pair for username
#./create_access_key.sh
key_response = iam.create_access_key(username)

#NOTE: copy and paste the keys to the 
#~/.aws/credentials file or boto config file
#./attach_access_policy_to_user.sh
#attach to "username" the policy named "code_deploy_user_access_policy" which is held in 
#file://json/code_deploy_user_access_policy.json

#OPTIONAL:
#./attach_cloudformation_policy_to_user.sh


# The calls to AWS STS AssumeRole must be signed with the access key ID
# and secret access key of an existing IAM user or by using existing temporary 
# credentials such as those from another role. (You cannot call AssumeRole 
# with the access key for the root account.) The credentials can be in 
# environment variables or in a configuration file and will be discovered 
# automatically by the boto3.client() function. For more information, see the 
# Python SDK documentation: 
# http://boto3.readthedocs.org/en/latest/guide/sqs.html

"""
# create an STS client object that represents a live connection to the 
# STS service
sts_client = boto3.client('sts')

# Call the assume_role method of the STSConnection object and pass the role
# ARN and a role session name.
assumedRoleObject = sts_client.assume_role(
    RoleArn="arn:aws:iam::account-of-role-to-assume:role/name-of-role",
    RoleSessionName="AssumeRoleSession1"
)

# From the response that contains the assumed role, get the temporary 
# credentials that can be used to make subsequent API calls
credentials = assumedRoleObject['Credentials']

# Use the temporary credentials that AssumeRole returns to make a 
# connection to Amazon S3  
s3_resource = boto3.resource(
    's3',
    aws_access_key_id = credentials['AccessKeyId'],
    aws_secret_access_key = credentials['SecretAccessKey'],
    aws_session_token = credentials['SessionToken'],
)

# Use the Amazon S3 resource object that is now configured with the 
# credentials to access your S3 buckets. 
for bucket in s3_resource.buckets.all():
    print(bucket.name)
    
#./create_service_role.sh
#./attach_service_role_policy.sh
#./get_service_role_arn.sh
#Make a note of the Service Role ARN. 
#You need it to create a Deployment Group.
#./create_instance_profile_role.sh
#./attach_instance_role_policy.sh
#./create_instance_profile.sh

#./add_instance_profile_role_to_instance_profile.sh
"""


'''
In [1]: policy = """{
   ...:   "Statement":[{
   ...:     "Effect":"Allow",
   ...:     "Action":["s3:*"],
   ...:     "Resource":["arn:aws:s3:::mybucket"]}]}"""
In [2]: import boto
In [4]: c = boto.connect_iam()
In [5]: instance_profile = c.create_instance_profile('myinstanceprofile')
In [6]: role = c.create_role('myrole')
In [7]: c.add_role_to_instance_profile('myinstanceprofile', 'myrole')
Out[7]: {u'add_role_to_instance_profile_response': {u'response_metadata': {u'request_id': u'2221d92c-b437-11e1-86e5-c9c4f3b58653'}}}
In [8]: c.put_role_policy('myrole', 'mypolicy', policy)
Out[8]: {u'put_role_policy_response': {u'response_metadata': {u'request_id': u'2b878c93-b437-11e1-86e5-c9c4f3b58653'}}}
In [9]: c = boto.connect_ec2()
In [10]: c.run_instances('ami-e565ba8c', key_name='mykeyname', security_groups=['mysecuritygroup'], instance_type='t1.micro', instance_profile_name='myinstanceprofile')

./spin_up_instances.sh
#returns instance ID; plug into check_instance_status.sh
#and describe_instances.sh
./check_instance_status.sh
./create_tags.sh
./describe_instances.sh
ListDeploymentInstances()
#returns public DNS; plug into connect_ec2.sh
./connect_ec2.sh

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

#If service is missing or broken...
./transfer_install_codedeploy.sh
./connect_ec2.sh
#sudo su on EC2 machine
./install_codedeploy.sh #you will need AWS credentials to complete

#For stack creation, instead of a single instance: 
#execute ./create_stack.sh
#confirm success with /describe_stack.sh
#NOTE: create_stack.sh NOT POSSIBLE WITH CODEDEPLOY
#CodeDeploy requires the attachment of an IAM policy 
#when the instances are created (see spin_up_instances.sh)

./create_application.sh
create_application()

./list_applications.sh
list_applications()

./get_service_role_arn.sh 
    
#Paste ARN into create_deployment_group.sh.

./create_deployment_group.sh
create_deployment_group()
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
create_deployment()

'''


