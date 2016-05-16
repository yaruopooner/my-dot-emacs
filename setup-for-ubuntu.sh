# -*- mode: shell-script ; coding: utf-8-unix -*-
#! /bin/sh

sudo -E apt-get -y update
sudo -E apt-get -y install subversion
sudo -E apt-get -y install cmake
sudo -E apt-get -y install build-essential
sudo -E apt-get -y build-dep emacs24
sudo -E apt-get -y install fonts-inconsolata
# sudo -E apt-get -y install git
mkdir work
pushd work
wget http://ftp.gnu.org/gnu/emacs/emacs-24.5.tar.gz 
tar -zxf emacs-24.5.tar.gz
cd emacs-24.5
./configure
sudo make install
