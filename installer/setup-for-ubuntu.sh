# -*- mode: shell-script ; coding: utf-8-unix -*-
#! /bin/sh

# sudo -E add-apt-repository ppa:ubuntu-elisp/ppa
sudo -E apt-get -y update

sudo -E apt-get -y install gnome-color-chooser

sudo -E apt-get -y install fonts-inconsolata

sudo -E apt-get -y install git
sudo -E apt-get -y install subversion
sudo -E apt-get -y install cmake

sudo -E apt-get -y install build-essential


mkdir work
pushd work

../setup-emacs.sh
