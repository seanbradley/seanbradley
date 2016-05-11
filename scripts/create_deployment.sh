#!/bin/bash

aws deploy create-deployment \
--application-name wolfskill \
--deployment-config-name CodeDeployDefault.OneAtATime \
--deployment-group-name wolfskilldg \
--description "Wolfskill 1.0.0." \
--github-location repository=seanbradley/wolfskill,commitId=6d412ddb22c74d6f2b3f02361bd967d3a4176d33












