;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/04/12.15:29:21


;;==================================================================================================
;; C# mode setup                                                                                    
;;==================================================================================================




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


(require 'csharp-mode)

;; diredなどのg keyにbindされているrevert-bufferで問題がおきるので
;; csharp-mode.el のオリジナルソースをfixした
;; Line2660
;;-         (and (fboundp 'flymake-mode)
;;+         (and (boundp 'flymake-mode)





;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; C#モード 共通フック
(add-hook 'csharp-mode-hook
          '(lambda ()
             (setq comment-column 40)
             (setq c-basic-offset 4)
             ;; オフセットの調整
             (c-set-offset 'substatement-open 0)
             (c-set-offset 'case-label '+)
             (c-set-offset 'arglist-intro '+)
             (c-set-offset 'arglist-close 0)
             )
          )





(provide 'setup.csharp-mode)
;;--------------------------------------------------------------------------------------------------
;; EOF