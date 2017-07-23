#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

ulimit -n 8192

if [ "$1" = "/usr/local/bin/service.sh" ]; then
	echo "configure"
fi

echo "start $@"
exec "$@"
