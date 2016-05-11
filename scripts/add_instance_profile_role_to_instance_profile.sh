#!/bin/bash

aws iam add-role-to-instance-profile \
--instance-profile-name wolfskill \
--role-name wolfskill_instance_profile_role
