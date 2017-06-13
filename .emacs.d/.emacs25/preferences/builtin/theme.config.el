;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2017/06/13.16:10:52


;;==============================================================================
;; theme setup
;;==============================================================================


;; (require 'custom)




;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


(add-to-list 'custom-theme-load-path (locate-user-emacs-file "themes"))


;; 一括ロード
(cl-dolist (theme '(
                    msvs-like
                    black-bg-based
                    white-bg-based
                    ))
  (load-theme theme t t))


(enable-theme 'msvs-like)
;; (enable-theme 'black-bg-based)
;; (enable-theme 'white-bg-based)

;; (add-hook 'after-init-hook '(lambda ()
;;                               (enable-theme 'black-bg-based)
;;                               ))



(provide 'theme.config)
;;------------------------------------------------------------------------------
;; EOF
