#!/bin/bash

. version.sh

export BUILD_BOX_NAME="funtoo-core"

export BUILD_PARENT_BOX_NAME="funtoo-stage3"
export BUILD_PARENT_BOX_VAGRANTCLOUD_NAME="foobarlab/funtoo-stage3"

export BUILD_GUEST_TYPE="Gentoo_64"
export BUILD_GUEST_CPUS="4"
export BUILD_GUEST_MEMORY="4096"

export BUILD_BOX_PROVIDER="virtualbox"
export BUILD_BOX_USERNAME="foobarlab"

export BUILD_OUTPUT_FILE="$BUILD_BOX_NAME-$BUILD_BOX_VERSION.box"
export BUILD_OUTPUT_FILE_TEMP="$BUILD_BOX_NAME.tmp.box"

export BUILD_BOX_RELEASE_NOTES="GCC 5.4.0-r1, VirtualBox Guest Additions 5.2.12"
export BUILD_BOX_DESCRIPTION="$BUILD_BOX_RELEASE_NOTES<br>$BUILD_BOX_NAME build @$(date --iso-8601=seconds)"

export BUILD_GCC_VERSION=""				# specify which gcc version to install or leave empty to keep the default
export BUILD_REBUILD_SYSTEM=false		# set to true when gcc version is not default 

# get the latest parent version from vagrant cloud api call:
. parent_version.sh

if [ $# -eq 0 ]; then
	echo "Executing $0 ..."
	echo "=== Build settings ============================================================="
	env | grep BUILD_ | sort
	echo "================================================================================"
fi
