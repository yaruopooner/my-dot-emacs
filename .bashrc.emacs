# -*- mode: shell-script ; coding: utf-8-unix -*-
# last updated : 2015/04/18.03:10:21

# cygwin version 1.7x~


# export


# 日時表記はなるべく英語にしておく必要がある
# Emacs で ls のresultを利用するようなコマンドは日時表記が英語でないと正常動作しなくなる
# LC_TIME は LANGより優先されるため LANG="ja_JP.UTF-8" であっても LC_TIME が英語なら問題ない
export  LC_TIME="en_US.UTF-8"


if $cygwin; then 
    export	MY_EMACS_INSTALLED_PARENT_DIRECTORY="${USR_SHARE_TOOLS_PATH}/emacs"
    export	MY_EMACS_DEFAULT_OPTIONS=" --debug-init"

    # alias
    alias   meadow210="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/32/meadow2.10/bin/meadow.exe${MY_EMACS_DEFAULT_OPTIONS}"
    alias   meadow301="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/32/meadow3.01/bin/meadow.exe${MY_EMACS_DEFAULT_OPTIONS}"

    alias   emacs32-223="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/32/emacs-22.3/bin/emacs.exe${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs32-231="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/32/emacs-23.1/bin/emacs.exe${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs32-233="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/32/emacs-23.3/bin/emacs.exe${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs32-234="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/32/emacs-23.4/bin/emacs.exe${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs32-241-0="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/32/emacs-24.1-20120610/bin/emacs.exe${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs32-241-1="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/32/emacs-24.1-20120616/bin/emacs.exe${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs32-241-2="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/32/emacs-24.1-20120716/bin/emacs.exe${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs32-242-0="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/32/emacs-24.2-20120902/bin/emacs.exe${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs32-242-1="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/32/emacs-24.2-20120922/bin/emacs.exe${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs32-242-2="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/32/emacs-24.2-20121208/bin/emacs.exe${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs32-243-0="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/32/emacs-24.3-20130317/bin/emacs.exe${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs32-243-1="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/32/emacs-24.3-20130503/bin/emacs.exe${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs32-243-2="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/32/emacs-24.3-20130709/bin/emacs.exe${MY_EMACS_DEFAULT_OPTIONS}"

    alias   emacs64-233="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/64/emacs-23.3/bin/runemacs.exe${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs64-234="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/64/emacs-23.4/bin/runemacs.exe${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs64-2435="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/64/emacs-w64-bzr116266/bin/runemacs.exe${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs64-244="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/64/emacs-24.4/bin/runemacs.exe${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs64-244-ime="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/64/emacs-24.4-IME-patched/bin/runemacs.exe${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs64-245="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/64/emacs-24.5/bin/runemacs.exe${MY_EMACS_DEFAULT_OPTIONS}"
    alias   emacs64-245-ime="${MY_EMACS_INSTALLED_PARENT_DIRECTORY}/64/emacs-24.5-IME-patched/bin/runemacs.exe${MY_EMACS_DEFAULT_OPTIONS}"

    alias   emacs32=emacs32-243-1
    # alias   emacs32=emacs32-243-2
    # alias   emacs64=emacs64-234
    # alias   emacs64=emacs64-244
    # alias   emacs64=emacs64-244-ime
    alias   emacs64=emacs64-245-ime

    # alias   emacs=emacs32
    alias   emacs=emacs64

    export  EMACS=emacs
fi



# EOF
