#!/bin/bash

aws deploy create-deployment \
--application-name wolfskill \
--deployment-config-name CodeDeployDefault.OneAtATime \
--deployment-group-name wolfskilldg \
--description "Wolfskill 1.0.6." \
--github-location repository=seanbradley/wolfskill,commitId=24982584e0a3d28cbf81b6d829ce78c258a469cc














