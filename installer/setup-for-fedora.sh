# -*- mode: shell-script ; coding: utf-8-unix -*-
#! /bin/sh

# sudo -E add-apt-repository ppa:ubuntu-elisp/ppa
sudo -E dnf -y update

sudo -E dnf -y install gnome-color-chooser

sudo -E dnf -y install fonts-inconsolata

# sudo -E dnf -y install git
sudo -E dnf -y install subversion
sudo -E dnf -y install cmake

sudo -E dnf -y install build-essential
sudo -E dnf -y build-dep emacs24

# sudo -E dnf -y install emacs24 emacs24-el emacs24-common-non-dfsg

mkdir work
pushd work

wget http://ftp.gnu.org/gnu/emacs/emacs-24.5.tar.gz 
tar -zxf emacs-24.5.tar.gz
cd emacs-24.5
./configure
sudo make install
