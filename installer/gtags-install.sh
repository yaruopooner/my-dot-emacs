# -*- mode: shell-script ; coding: utf-8-unix -*-
#! /bin/sh


declare -r WORK_DIR="${1-/tmp}"
pushd ${WORK_DIR}

echo ${WORK_DIR}
pushd ${WORK_DIR}

declare -r ARCHIVE_NAME="global-6.5.7"
declare -r ARCHIVE_FILE="${ARCHIVE_NAME}.tar.gz"

# wget --timestamping "ftp://ftp.gnu.org/pub/gnu/global/${ARCHIVE_FILE}"
wget --timestamping "http://tamacom.com/global/${ARCHIVE_FILE}"

if [ -d ./${ARCHIVE_NAME} ]; then
    pushd ./${ARCHIVE_NAME}
    make uninstall
    popd
    rm -rf ${ARCHIVE_NAME}
fi

tar -zxvf ${ARCHIVE_FILE}
pushd ./${ARCHIVE_NAME}
./configure
make install

popd

popd
