# -*- mode: shell-script ; coding: utf-8-unix -*-
#! /bin/sh

work_dir="/tmp"
if [ ${1} ] && [ -d ${1} ]; then
    work_dir="${1}"
fi
echo ${work_dir}
pushd ${work_dir}

archive_name="global-6.5.4"
archive_file="${archive_name}.tar.gz"

# wget --timestamping ftp://ftp.gnu.org/pub/gnu/global/${archive_file}
wget --timestamping http://tamacom.com/global/${archive_file}

if [ -d ./${archive_name} ]; then
    pushd ./${archive_name}
    make uninstall
    popd
    rm -rf ${archive_name}
fi

tar -zxvf ${archive_file}
pushd ./${archive_name}
./configure
make install
popd

popd
