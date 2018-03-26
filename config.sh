#!/bin/bash

export BUILD_PARENT_BOX_NAME="funtoo-stage3"
export BUILD_PARENT_BOX_VAGRANTCLOUD_NAME="foobarlab/funtoo-stage3"
export BUILD_PARENT_BOX_VAGRANTCLOUD_VERSION="2018.03.21"

export BUILD_BOX_NAME="funtoo-core"
export BUILD_BOX_DESCRIPTION="Funtoo minimal core installation"
export BUILD_GUEST_TYPE="Gentoo_64"
export BUILD_GUEST_CPUS="8"
export BUILD_GUEST_MEMORY="8192"
export BUILD_OUTPUT_FILE="$BUILD_BOX_NAME.box"
export BUILD_OUTPUT_FILE_TEMP="$BUILD_BOX_NAME.tmp.box"

echo "Executing $0 ..."
echo "=== Build settings ============================================================="
env | grep BUILD_
echo "================================================================================"
