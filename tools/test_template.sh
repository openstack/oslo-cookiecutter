#!/bin/bash -x
#
# Test that the template can be applied
#
# Arguments:
#
#  tmp_dir - Directory where it is possible to create temporary files.

tmp_dir="$1"
out_dir="$tmp_dir/output"

# The templates are above the tools directory.
template_dir=$(dirname $(dirname $0))

rm -rf $out_dir
mkdir -p $out_dir
cd $out_dir

cookiecutter -v $template_dir <<EOF
testing
openstack
This package is for testing the templates.
EOF

echo "Files created:"
find .
