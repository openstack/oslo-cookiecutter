#!/bin/bash

set -eux -o pipefail

# Wrapper around test_template.sh that runs tox tests in the resulting
# repo to verify that our out-of-the-box configuration is valid

tmp_dir=$(mktemp -d)
trap "rm -rf $tmp_dir" EXIT

tools_dir="$(dirname $0)"
project_dir="$tmp_dir/output/oslo.testing"

$tools_dir/test_template.sh "$tmp_dir"

cd $project_dir

# PBR requires a git repo for versioning
git init .

tox -e pep8,py27,py36,py37,docs,lower-constraints,cover
