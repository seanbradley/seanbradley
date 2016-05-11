#!/bin/bash

aws deploy create-deployment \
--application-name wolfskill \
--deployment-config-name CodeDeployDefault.OneAtATime \
--deployment-group-name wolfskilldg \
--description "Wolfskill 1.0.4." \
--github-location repository=seanbradley/wolfskill,commitId=922bda1d785e6966893016b8ed1d9414e61317aa












