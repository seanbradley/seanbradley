#!/bin/bash
#
#gives the instance_profile_role the permissions to access
#resources in the code_deploy_resource_permissions.json file

aws iam put-role-policy \
--role-name wolfskill_instance_profile_role \
--policy-name instance_profile_resource_permissions \
--policy-document file://json/instance_profile_resource_permissions.json
