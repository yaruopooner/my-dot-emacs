# -*- mode: shell-script ; coding: utf-8-unix -*-
#! /bin/sh

git submodule init
git submodule update --recursive

pushd .emacs.d/.emacs24/packages/user/ac-clang
git checkout -b develop origin/develop

popd
cd .emacs.d/.emacs24/packages/user/msvc
git checkout -b develop origin/develop

