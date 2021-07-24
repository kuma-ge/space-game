#!/bin/sh

PLATFORM=$1

if [ -z $PLATFORM ]; then
    echo "Platform not specified"
    exit
fi

if [ "$PLATFORM" != "mac" ]; then
    pushd build/$PLATFORM && zip -r $PLATFORM.zip *
    popd
fi