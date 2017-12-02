# -*- mode: shell-script ; coding: utf-8-unix -*-
#! /bin/sh

# sudo -E add-apt-repository ppa:ubuntu-elisp/ppa
sudo -E apt-get -y update

sudo -E apt-get -y install gnome-color-chooser

sudo -E apt-get -y install fonts-inconsolata

# sudo -E apt-get -y install git
sudo -E apt-get -y install subversion
sudo -E apt-get -y install cmake

sudo -E apt-get -y install build-essential
sudo -E apt-get -y build-dep emacs25

# sudo -E apt-get -y install emacs25 emacs25-el emacs25-common-non-dfsg

mkdir work
pushd work

wget --timestamping http://ftp.gnu.org/gnu/emacs/emacs-25.3.tar.gz 
tar -zxf emacs-25.3.tar.gz
cd emacs-25.3
./configure
sudo make install
