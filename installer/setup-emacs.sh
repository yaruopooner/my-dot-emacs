# -*- mode: shell-script ; coding: utf-8-unix -*-
#! /bin/sh


declare -r EMACS_ARCHIVE_URI="http://ftp.gnu.org/gnu/emacs/emacs-26.1.tar.xz"
# declare -r EMACS_ARCHIVE_URI="http://ftp.gnu.org/gnu/emacs/emacs-25.3.tar.xz"
declare -r EMACS_ARCHIVE_NAME=$( basename "${EMACS_ARCHIVE_URI}" )
declare -r EMACS_VERSION_NAME=$( echo "${EMACS_ARCHIVE_NAME}" | sed -r "s/(emacs-[0-9]+\.[0-9]+).*/\1/" )


wget --timestamping "${EMACS_ARCHIVE_URI}"

# archive expand
if $( [ ! -d "${EMACS_VERSION_NAME}" ] && [ -e "${EMACS_ARCHIVE_NAME}" ] ); then
    tar -xvf "${EMACS_ARCHIVE_NAME}"
fi

pushd "${EMACS_VERSION_NAME}"


# for ubuntu 18.04 passed
sudo -E apt -y install libgtk-3-dev
sudo -E apt -y install libxpm-dev libjpeg-dev libgif-dev libtiff5-dev
sudo -E apt -y install libncurses5-dev


./configure --with-modules --without-compress-install

# 一部のディレクトリがrootで作成されている？ため sudo じゃないとmakeが通らない
sudo make -j8
# sudo make install
