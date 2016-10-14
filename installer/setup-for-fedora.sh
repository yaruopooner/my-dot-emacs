# -*- mode: shell-script ; coding: utf-8-unix -*-
#! /bin/sh

# sudo -E add-apt-repository ppa:ubuntu-elisp/ppa
sudo -E dnf -y update
sudo -E dnf -y upgrade

sudo -E dnf -y groupinstall "Development Tools"

# sudo -E dnf -y install gnome-color-chooser

# sudo -E dnf -y install fonts-inconsolata
sudo -E dnf -y install levien-inconsolata-fonts

# sudo -E dnf -y install git
sudo -E dnf -y install subversion
sudo -E dnf -y install cmake

# sudo -E dnf -y install build-essential
# sudo -E dnf -y build-dep emacs24

sudo -E dnf -y gcc
sudo -E dnf -y gcc-c++

sudo -E dnf -y install texinfo libotf-devel ncurses-devel imagemagic imagemagic-devel libxml2 libxml2-devel gnutls-devel
sudo -E dnf -y install libXpm libXpm-devel libjpeg libjpeg-devel libtiff libtiff-devel giflib giflib-devel libpng libpng-devel libxaw libxaw-devel

# sudo -E dnf -y install emacs24 emacs24-el emacs24-common-non-dfsg

mkdir work
pushd work

wget --timestamping http://ftp.gnu.org/gnu/emacs/emacs-24.5.tar.gz 
tar -zxf emacs-24.5.tar.gz
cd emacs-24.5
./configure
make
sudo make install
