;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/03/22.16:50:04


;;==================================================================================================
;; browse yank setup                                                                                    
;;==================================================================================================




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


(load-library "browse-yank")




;;------------------------------------------------------------------------------
;; Global Key Bind
;;------------------------------------------------------------------------------


;; browse-yank[yank の機能拡張版] kill-ring バッファを参照できる
(global-set-key (kbd "C-x C-y") 'browse-yank)






(provide 'setup.browse-yank)
;;--------------------------------------------------------------------------------------------------
;; EOF