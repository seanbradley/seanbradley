#!/bin/bash

aws deploy create-deployment \
--application-name wolfskill \
--deployment-config-name CodeDeployDefault.OneAtATime \
--deployment-group-name wolfskilldg \
--description "Wolfskill 1.0.9." \
--github-location repository=seanbradley/wolfskill,commitId=125f58da8c9b0ca59e1c48312058973f6d484347















