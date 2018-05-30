;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2014/10/20.12:08:21


;;==================================================================================================
;; helm-migemo setup                                                                   
;;==================================================================================================



;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------




(when (setq migemo-command (executable-find "cmigemo"))
  (require 'migemo)
  (require 'helm-migemo)

  (setq migemo-dictionary "/usr/local/share/migemo/utf-8/migemo-dict")
  (setq migemo-options '("-q" "--emacs" "-i" "\a"))
  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix)
  (load-library "migemo")

  (migemo-init))



(provide 'setup.helm-migemo)
;;--------------------------------------------------------------------------------------------------
;; EOF
