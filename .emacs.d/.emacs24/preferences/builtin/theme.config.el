;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2014/10/28.02:15:01


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
                    black-bg-based
                    white-bg-based
                    ))
  (load-theme theme t t))


(enable-theme 'black-bg-based)
;; (enable-theme 'white-bg-based)

;; (add-hook 'after-init-hook '(lambda ()
;;                               (enable-theme 'black-bg-based)
;;                               ))



(provide 'theme.config)
;;------------------------------------------------------------------------------
;; EOF
