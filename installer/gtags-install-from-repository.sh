# -*- mode: shell-script ; coding: utf-8-unix -*-
#! /bin/sh

declare -r WORK_DIR="${1-/tmp}"
pushd ${WORK_DIR}

declare -r CHECKOUT_DIR=global


if [ ! -d ${CHECKOUT_DIR} ]; then
    cvs -z3 -d ":pserver:anonymous@cvs.savannah.gnu.org:/sources/global" co ${CHECKOUT_DIR}
    # cvs -z3 -d ":pserver;proxy=${http_proxy_url};proxyport=${http_proxy_port}:anonymous@cvs.savannah.gnu.org:/sources/global" co ${CHECKOUT_DIR}
    RESULT=$?
    pushd ${CHECKOUT_DIR}
else
    pushd ${CHECKOUT_DIR}
    cvs update
    RESULT=$?
fi

if [ ${RESULT} -ne 0 ]; then
    echo -e "\n--- download_repository : checkout faild ---\n"
    exit 1
fi


sh reconf.sh 
./configure
make install

