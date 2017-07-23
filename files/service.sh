#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

/opt/jira_software/bin/start-jira.sh -fg
