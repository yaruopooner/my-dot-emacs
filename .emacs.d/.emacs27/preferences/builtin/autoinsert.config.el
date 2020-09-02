;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2020/02/19.21:11:57


;;==============================================================================
;; Auto Insert setup                                                            
;;==============================================================================


(require 'autoinsert)





;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; Suffixes <---> Mode  Connection                                              

;; Template File at Directory 
(setq auto-insert-directory (expand-file-name "template/" de:path-builtin-configuration))


(setq auto-insert-alist (append '(
                                  ("\\.c$"               . "c++-mode.c.template")
                                  ("\\.h$"               . "c++-mode.h.template")
                                  ("\\.cpp$"             . "c++-mode.cpp.template")
                                  ("\\.hpp$"             . "c++-mode.hpp.template")
                                  ("\\.inl$"             . "c++-mode.inl.template")
                                  ("\\.el$"              . "emacs-lisp-mode.template")
                                  ("\\.\\(txt\\|org\\)$" . "org-mode.template")
                                  ("\\.snpt$"            . "snippet.template")
                                  (makefile-mode         . "makefile-mode.template")
                                  (emacs-lisp-mode       . "lisp-mode.template")
                                  (lisp-mode             . "lisp-mode.template")
                                  (perl-mode             . "perl-mode.template")
                                  (html-helper-mode      . "html-mode.template")
                                  (snippet-mode          . "snippet.template")
                                  )
                                auto-insert-alist))



;;------------------------------------------------------------------------------
;; add hook                                                                     
;;------------------------------------------------------------------------------


(add-hook 'find-file-hooks 'auto-insert)





(provide 'autoinsert.config)
;;------------------------------------------------------------------------------
;; EOF
