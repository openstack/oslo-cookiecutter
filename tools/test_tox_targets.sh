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
# openstackdocstheme requires commits for last modified calculation
git config user.email "test@example.com"
git config user.name "Test Name"
git add .
git commit -m "Test commit"

# Create an "implementation" so we have an API to document
cat > $project_dir/oslo_testing/test.py << EOF
def test_api():
    """A docstring"""
    pass
EOF

tox -e pep8,py36,docs,lower-constraints,cover
