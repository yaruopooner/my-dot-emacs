;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2013/01/24.20:56:22


;;==============================================================================
;; lua Mode setup
;;==============================================================================



;; Load Module
(require 'lua-mode)

(require 'flymake-lua)


;; ロードすると自動的に、拡張子関連付け、マジックコメント関連付けが行われる
;; auto-mode-alist, interpreter-mode-alist 




(defun lua-mode:setup-variables ()
  "lua Mode : setup common edit style parameters."

  (interactive)

  (setq tab-width 4)
  
  )


;; hook function
(defun lua-mode:hook-functions ()
  ;; lua-mode 書式共通変数設定
  (lua-mode:setup-variables)

  ;; flymake
  (flymake-lua-load)
  
  ;; font-lock enable
  (turn-on-font-lock)
  )







;;------------------------------------------------------------------------------
;; add hook                                                                     
;;------------------------------------------------------------------------------


(add-hook 'lua-mode-hook 'lua-mode:hook-functions)





(provide 'setup.lua-mode)
;;------------------------------------------------------------------------------
;; EOF
