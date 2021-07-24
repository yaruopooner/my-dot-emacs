# -*- mode: shell-script ; coding: utf-8-unix -*-
#! /bin/sh

pushd .ssh
chmod 600 config
chmod 600 id_rsa_github
chmod 600 id_rsa_github.pub
popd

eval `ssh-agent -s`
ssh-add ~/.ssh/id_rsa_github

# fingerprint conform skip
ssh-keyscan github.com >> ~/.ssh/known_hosts

# connection conform
ssh -vT git@github.com
