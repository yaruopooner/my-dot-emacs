# -*- mode: shell-script ; coding: utf-8-unix -*-
# last updated : 2019/09/18.16:24:53

# cygwin version 1.7x~


# export


# 日時表記はなるべく英語にしておく必要がある
# Emacs で ls のresultを利用するようなコマンドは日時表記が英語でないと正常動作しなくなる
# LC_TIME は LANGより優先されるため LANG="ja_JP.UTF-8" であっても LC_TIME が英語なら問題ない
export  LC_TIME="en_US.UTF-8"


if $cygwin; then 
    export	MY_EMACS_INSTALLED_PARENT_DIRECTORY="${USR_SHARE_TOOLS_PATH}/emacs"
    export	MY_EMACS_DEFAULT_OPTIONS="--debug-init"

    # alias
    # alias   meadow210="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/32/meadow2.10/bin/meadow.exe ${MY_EMACS_DEFAULT_OPTIONS}"
    # alias   meadow301="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/32/meadow3.01/bin/meadow.exe ${MY_EMACS_DEFAULT_OPTIONS}"

    # alias   emacs32-243-2="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/32/emacs-24.3-20130709/bin/emacs.exe ${MY_EMACS_DEFAULT_OPTIONS}"
    # alias   emacs32-251-ime="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/32/emacs-25.1-IME-patched/bin/runemacs.exe ${MY_EMACS_DEFAULT_OPTIONS}"

    # alias   emacs64-245="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/64/emacs-24.5/bin/runemacs.exe ${MY_EMACS_DEFAULT_OPTIONS}"
    # alias   emacs64-245-ime="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/64/emacs-24.5-IME-patched/bin/runemacs.exe ${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs64-251-ime="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/64/emacs-25.1-IME-patched/bin/runemacs.exe ${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs64-252-ime="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/64/emacs-25.2-IME-patched/bin/runemacs.exe ${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs64-253-ime="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/64/emacs-25.3-IME-patched/bin/runemacs.exe ${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs64-261-ime="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/64/emacs-26.1-IME-patched/bin/runemacs.exe ${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs64-262-ime="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/64/emacs-26.2-IME-patched/bin/runemacs.exe ${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs64-263-ime="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/64/emacs-26.3-IME-patched/bin/runemacs.exe ${MY_EMACS_DEFAULT_OPTIONS}"

    # alias   emacs32=emacs32-251-ime
    # alias   emacs64=emacs64-245-ime
    # alias   emacs64=emacs64-252-ime
    alias   emacs64=emacs64-253-ime
    # alias   emacs64=emacs64-261-ime
    # alias   emacs64=emacs64-262-ime
    # alias   emacs64=emacs64-263-ime

    # alias   emacs=emacs32
    alias   emacs=emacs64

    export  EMACS=emacs
fi



# EOF
