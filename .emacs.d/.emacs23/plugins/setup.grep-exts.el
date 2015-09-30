;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/03/30.15:33:26


;;==================================================================================================
;; grep extensions Setup                                                                            
;;==================================================================================================




;;------------------------------------------------------------------------------
;; Load                                                                         
;;------------------------------------------------------------------------------


;; grep-a-lot
(require 'grep-a-lot)


;; grep-edit
(require 'grep-edit)




;;------------------------------------------------------------------------------
;; Global Key Bind
;;------------------------------------------------------------------------------


;(grep-a-lot-setup-keys)  ; keyバインドはしない


; grep-edit 時に以下のキーを無効化しないと、p,n キーの入力ができない
; 同様の機能は "C-c C-f" 後の "C-p" "C-n" で可能
(add-hook 'grep-setup-hook
          '(lambda ()
;	     (define-key grep-mode-map (kbd "p") nil)
;	     (define-key grep-mode-map (kbd "n") nil)
;	     (define-key grep-mode-map (kbd "C-c C-c") 'grep-edit-finish-edit)
	     (local-unset-key (kbd "p"))
	     (local-unset-key (kbd "n"))
	     (local-set-key (kbd "C-c C-c") 'grep-edit-finish-edit)
	     )
	  )





(provide 'setup.grep-exts)
;;--------------------------------------------------------------------------------------------------
;; EOF
