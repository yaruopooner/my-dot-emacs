# -*- mode: shell-script ; coding: utf-8-unix -*-
#! /bin/sh

# sudo -E add-apt-repository ppa:ubuntu-elisp/ppa
sudo -E apt -y update

sudo -E apt -y install gnome-color-chooser

sudo -E apt -y install fonts-inconsolata

sudo -E apt -y install git subversion
sudo -E apt -y install make cmake
sudo -E apt -y install gcc g++


# sudo -E apt -y install build-essential


mkdir work
pushd work

../setup-emacs.sh
