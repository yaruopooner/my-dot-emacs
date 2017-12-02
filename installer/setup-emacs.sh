# -*- mode: shell-script ; coding: utf-8-unix -*-
#! /bin/sh


EMACS_ARCHIVE_URI="http://ftp.gnu.org/gnu/emacs/emacs-25.3.tar.xz"
readonly EMACS_ARCHIVE_NAME=$( basename "${EMACS_ARCHIVE_URI}" )
readonly EMACS_VERSION_NAME=$( echo "${EMACS_ARCHIVE_NAME}" | sed -r "s/(emacs-[0-9]+\.[0-9]+).*/\1/" )


wget --timestamping "${EMACS_ARCHIVE_URI}"

# archive expand
if $( [ ! -d "${EMACS_VERSION_NAME}" ] && [ -e "${EMACS_ARCHIVE_NAME}" ] ); then
    tar -xvf "${EMACS_ARCHIVE_NAME}"
fi

pushd "${EMACS_VERSION_NAME}"

./configure --with-modules --without-compress-install

# 一部のディレクトリがrootで作成されている？ため sudo じゃないとmakeが通らない
sudo make -j8
# sudo make install
