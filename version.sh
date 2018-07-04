#!/bin/bash

# this script will read the current box version or generate a new box version (format: major.minor.buildnumber)

export BUILD_VERSION=$(<version)

if [ -f build_version ]; then
	export BUILD_BOX_VERSION=$(<build_version)
else
	export BUILD_BOX_VERSION=$BUILD_VERSION.$(date -u +%Y%m%d%H%M%S)
	echo $BUILD_BOX_VERSION > build_version
fi
