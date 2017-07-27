#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
set -o errtrace

ATLASSIAN_VERSION=${ATLASSIAN_VERSION:-""}
VERSION=${VERSION:-""}
GIT_BRANCH=${GIT_BRANCH:-""}

if [ ! -n "${ATLASSIAN_VERSION}" ]; then
    ATLASSIAN_VERSION="$(curl -s https://my.atlassian.com/download/feeds/jira-software.rss | grep -Po "(\d{1,2}\.){2,3}\d" | uniq)";
fi

git_tag=$(git tag -l --points-at HEAD)
if [ ! -n "${VERSION}" ] && [ ! -z "$git_tag" ]; then
	echo "set version to git tag"
	VERSION="$git_tag"
fi

jenkins_branch=${GIT_BRANCH##origin/}
if [ ! -n "${VERSION}" ] && [ ! -z "$jenkins_branch" ]; then
	echo "set version to jenkins branch"
	VERSION="$jenkins_branch"
fi

git_branch=$(git rev-parse --abbrev-ref HEAD)
if [ ! -n "${VERSION}" ] && [  ! -z "$git_branch" ] && [ ! "$git_branch" = "HEAD" ]; then
	echo "set version to git branch"
	VERSION="$git_branch"
fi

if [ ! -n "${VERSION}" ]; then
	echo "set version to latest"
	VERSION="latest"
fi

VERSION="${ATLASSIAN_VERSION}-${VERSION}"

echo "VERSION=${VERSION} ATLASSIAN_VERSION=${ATLASSIAN_VERSION}"

VERSION=${VERSION} ATLASSIAN_VERSION=${ATLASSIAN_VERSION} make build
VERSION=${VERSION} ATLASSIAN_VERSION=${ATLASSIAN_VERSION} make upload
VERSION=${VERSION} ATLASSIAN_VERSION=${ATLASSIAN_VERSION} make clean || true
