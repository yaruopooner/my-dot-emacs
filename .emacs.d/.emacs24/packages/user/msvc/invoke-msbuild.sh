# -*- mode: shell-script ; coding: utf-8-unix -*-
# last updated : 2014/09/25.03:19:40
#! /bin/sh


# current path change to package directory
# _INSTALLED_PACKAGE_DIR=`dirname "$0"`
_INSTALLED_PACKAGE_DIR="${0%/*}"
cd "${_INSTALLED_PACKAGE_DIR}"



# set arguments
_MS_VS_SHELL=$1
_MS_VS_SHELL_ARG=$2
_MSB_RSP_FILE=$3
_LOG_FILE=$4



# exec MSBuild
# ./call-msbuild.bat
cmd \\/c "call-msbuild.bat" "$_MS_VS_SHELL" "$_MS_VS_SHELL_ARG" "$_MSB_RSP_FILE"


# display to STDOUT
if [ -n "${_LOG_FILE}" ]; then
    cat "${_LOG_FILE}"
fi

