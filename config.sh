#!/bin/bash

. version.sh

export BUILD_BOX_NAME="funtoo-core"
export BUILD_BOX_USERNAME="foobarlab"

export BUILD_PARENT_BOX_NAME="funtoo-stage3"
export BUILD_PARENT_BOX_VAGRANTCLOUD_NAME="$BUILD_BOX_USERNAME/$BUILD_PARENT_BOX_NAME"

export BUILD_GUEST_TYPE="Gentoo_64"
export BUILD_GUEST_CPUS="4"
export BUILD_GUEST_MEMORY="4096"

export BUILD_OUTPUT_FILE="$BUILD_BOX_NAME-$BUILD_BOX_VERSION.box"
export BUILD_OUTPUT_FILE_TEMP="$BUILD_BOX_NAME.tmp.box"

export BUILD_BOX_PROVIDER="virtualbox"

export BUILD_TIMESTAMP="$(date --iso-8601=seconds)"

export BUILD_BOX_RELEASE_NOTES="GCC 5.4.0-r1, VirtualBox Guest Additions 5.2.14"	# edit this to reflect actual setup

BUILD_BOX_DESCRIPTION="$BUILD_BOX_NAME version $BUILD_BOX_VERSION"
if [ -z ${BUILD_NUMBER+x} ] || [ -z ${BUILD_TAG+x} ]; then
	# without build number 
	BUILD_BOX_DESCRIPTION="$BUILD_BOX_DESCRIPTION custom build"
else
	# for jenkins builds we got some additional information: BUILD_NUMBER, BUILD_ID, BUILD_DISPLAY_NAME, BUILD_TAG, BUILD_URL
	BUILD_BOX_DESCRIPTION="$BUILD_BOX_DESCRIPTION build $BUILD_NUMBER ($BUILD_TAG)"
fi
export BUILD_BOX_DESCRIPTION="$BUILD_BOX_DESCRIPTION<br>created @$BUILD_TIMESTAMP<br>$BUILD_BOX_RELEASE_NOTES"

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
