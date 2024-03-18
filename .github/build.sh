#!/bin/bash

### Helper functions ###

function header() {
    echo "\033[1;34m$1\033[0m"
}

function info() {
    echo "\033[0;32m$1\033[0m"
}

function debug() {
    echo "\033[0;33m$1\033[0m"
}

function success() {
    echo "\033[0;32m$1\033[0m"
}

function error() {
    echo "\033[0;31m$1\033[0m"
}

# Header

header "Application Builder"
header "======================"


cwd=$(pwd)

info "Build Context: $cwd"

info "Removing old binaries"


success "Removed old binaries"

# Options

AppVersion=""
OutDir=$cwd/dist

rm -rf $OutDir
mkdir -p $OutDir

if [ -n "$VERSION" ]; then
    AppVersion="$VERSION"
fi

debug "App Version: $AppVersion"
debug "Out Dir: $OutDir"

# Build

AppSuffix=""

if [[ AppVersion != "" ]]; then
    AppSuffix="-v$AppVersion"
fi

cp -r $cwd/python-project $OutDir/project
cp -r $cwd/vue-project/dist $OutDir/frontend

cd $OutDir
zip -rm $OutDir/build_$AppVersion.zip *
success "Bundle built"

cd $cwd