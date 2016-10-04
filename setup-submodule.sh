# -*- mode: shell-script ; coding: utf-8-unix -*-
#! /bin/sh

git submodule init
git submodule update --recursive

if [ -d .emacs.d/.emacs24 ]; then
    pushd .emacs.d/.emacs24/packages/user/ac-clang
    git checkout -b develop origin/develop
    popd

    pushd .emacs.d/.emacs24/packages/user/msvc
    git checkout -b develop origin/develop
    popd
fi

if [ -d .emacs.d/.emacs25 ]; then
    pushd .emacs.d/.emacs25/packages/user/ac-clang
    git checkout -b develop origin/develop
    popd

    pushd .emacs.d/.emacs25/packages/user/msvc
    git checkout -b develop origin/develop
    popd
fi


