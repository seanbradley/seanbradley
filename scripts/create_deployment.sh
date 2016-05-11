#!/bin/bash

aws deploy create-deployment \
--application-name wolfskill \
--deployment-config-name CodeDeployDefault.OneAtATime \
--deployment-group-name wolfskilldg \
--description "Wolfskill 1.0.1." \
--github-location repository=seanbradley/wolfskill,commitId=46732b3627a9e3e1e83e6f153ec153a29aa34c92












