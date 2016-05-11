#!/bin/bash

aws iam create-role \
--role-name wolfskill_service_role \
--assume-role-policy-document file://json/service_role_trust.json
