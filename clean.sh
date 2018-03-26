#!/bin/bash -ue

. config.sh

echo "Suspending any running instances ..."
vagrant suspend && true
echo "Destroying current box ..."
vagrant destroy -f || true
echo "Removing box '$BUILD_BOX_NAME' ..."
vagrant box remove -f "$BUILD_BOX_NAME" 2>/dev/null || true
echo "Cleaning .vagrant dir ..."
rm -rf .vagrant/ || true
echo "Cleaning packer_cache ..."
rm -rf packer_cache/ || true
echo "Cleaning packer output-virtualbox-ovf dir ..."
rm -rf output-virtualbox-ovf || true
echo "Deleting any box file ..."
rm -f *.box || true
echo "Cleanup old logs ..."
rm -f packer.log || true
echo "All done. You may now run './build.sh' to build a new box."
