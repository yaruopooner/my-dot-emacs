;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2015/10/13.11:28:22


;;==================================================================================================
;; scratch-ext setup                                                                                    
;;==================================================================================================




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


(require 'scratch-ext)




;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


(setq scratch-ext-log-directory (expand-file-name "scratch/" de:path-dot-emacs-root))
(unless (file-accessible-directory-p scratch-ext-log-directory)
  (make-directory scratch-ext-log-directory))


;; emacs起動時、初期化後
(add-hook 'after-init-hook 'scratch-ext-restore-last-scratch)






(provide 'setup.scratch-ext)
;;--------------------------------------------------------------------------------------------------
;; EOF
