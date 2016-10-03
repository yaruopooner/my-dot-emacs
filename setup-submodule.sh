# -*- mode: shell-script ; coding: utf-8-unix -*-
#! /bin/sh

git submodule init
git submodule update --recursive

if [ -d .emacs.d/.emacs24 ]; then
    pushd .emacs.d/.emacs24/packages/user/ac-clang
    if [ -z "$(ls -A .)" ]; then
        git checkout -b develop origin/develop
    fi
    popd

    pushd .emacs.d/.emacs24/packages/user/msvc
    if [ -z "$(ls -A .)" ]; then
        git checkout -b develop origin/develop
    fi
    popd
fi

if [ -d .emacs.d/.emacs25 ]; then
    pushd .emacs.d/.emacs25/packages/user/ac-clang
    if [ -z "$(ls -A .)" ]; then
        git checkout -b develop origin/develop
    fi
    popd

    pushd .emacs.d/.emacs25/packages/user/msvc
    if [ -z "$(ls -A .)" ]; then
        git checkout -b develop origin/develop
    fi
    popd
fi


