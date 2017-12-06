# -*- mode: shell-script ; coding: utf-8-unix -*-
#! /bin/sh

declare -r WORK_DIR="${1-/tmp}"
pushd ${WORK_DIR}

declare -r CHECKOUT_DIR=global


if [ ! -d ${CHECKOUT_DIR} ]; then
    cvs -z3 -d:pserver:anonymous@cvs.savannah.gnu.org:/sources/global co ${CHECKOUT_DIR}
    pushd ${CHECKOUT_DIR}
else
    pushd ${CHECKOUT_DIR}
    cvs update
fi

sh reconf.sh 
./configure
make install

