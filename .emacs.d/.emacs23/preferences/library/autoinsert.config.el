;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/05/06.14:20:45

;;==============================================================================
;; Auto Insert                                                                  
;;==============================================================================


(require 'autoinsert)



;;------------------------------------------------------------------------------
;; Suffixes <---> Mode  Connection                                              
;;------------------------------------------------------------------------------


;; Template File at Directory 
(setq auto-insert-directory (expand-file-name "template/" path-library-configuration))


(setq auto-insert-alist (append '(
				  ("\\.c$" . "c-mode.c.template")
				  ("\\.h$" . "c-mode.h.template")
				  ("\\.cpp$" . "c++mode.cpp.template")
				  ("\\.hpp$" . "c++mode.hpp.template")
				  ("\\.inl$" . "c++mode.inl.template")
				  ("\\.el$" . "lisp-mode.template")
				  ("\\.\\(txt\\|org\\)$" . "org-mode.template")
				  (makefile-mode . "makefile-mode.template")
				  (emacs-lisp-mode . "lisp-mode.template")
				  (lisp-mode . "lisp-mode.template")
				  (perl-mode . "perl-mode.template")
				  (html-helper-mode . "html-mode.template")
				  )
				auto-insert-alist)
      )



;;------------------------------------------------------------------------------
;; add hook                                                                     
;;------------------------------------------------------------------------------


(add-hook 'find-file-hooks 'auto-insert)





(provide 'autoinsert.config)
;;------------------------------------------------------------------------------
;; EOF
