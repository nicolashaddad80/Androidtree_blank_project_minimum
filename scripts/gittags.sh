#!/usr/bin/env bash

if [ $# != 1 ]; then
    echo $0: wrong number of arguments:
    echo Usage: $(basename $0) OUTPUT_FILE_NAME
    exit 2
fi

OUTPUT_FILE=$1

OLD_CONTENT="empty"
if [ -f "$OUTPUT_FILE" ]; then
    # read previous file content
    OLD_CONTENT=$(grep 'public static final String VERSION_NAME = ' $OUTPUT_FILE  | cut -d'"' -f2)
fi

# change directory
pushd "$(dirname "${BASH_SOURCE[0]}")"

BOSCHRADAR_VERSION=$(cat '../version.txt')

# Check git availability
git --version > /dev/null 2>&1 || { echo "not a git repository" && exit 2; }

# Use git to get tags
tag="$(env -i git describe --tags --always 2>/dev/null)"
if [ "$tag" == "" ]; then
    tag="unknown"
fi

branch="$(env -i git branch --show-current 2>/dev/null)"
if [ "$branch" != "" ]; then
    branch="-${branch}"
fi

# dirty should be done by git status --dirty but it does not work on the git
# version available on the server for now... thus do it manually
dirty=

if [ "$(env -i git status -s 2>/dev/null)" != "" ]
then
    dirty="-dirty"
fi

tag="${tag}${branch}${dirty}"

popd

VERSION_NAME="rel_${BOSCHRADAR_VERSION}_git_${tag}"

if [ "$OLD_CONTENT" != "$VERSION_NAME" ]; then
    {
        # Display header file content
        echo '/**'
        echo '* Automatically generated file. DO NOT MODIFY'
        echo '*/'
        echo 'package com.renault.car.boschradar;'
        echo 'public final class BuildConfig {'
        echo 'public static final String VERSION_NAME = "'${VERSION_NAME}'";'
        echo '}'
    } > $OUTPUT_FILE
fi
