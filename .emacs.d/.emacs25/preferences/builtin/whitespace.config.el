;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2014/09/25.03:12:40


;;==================================================================================================
;; whitespace setup                                                                                    
;;==================================================================================================


(require 'whitespace)





;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; see whitespace.el for more details
(setq whitespace-style '(face spaces space-mark tabs tab-mark newline newline-mark))


(setq whitespace-display-mappings
      '(
        (space-mark   ?\x20  [?\xB7]  [?·])  ; normal space, ·
        ;; (space-mark   ?\xA0  [?\xA4]  [?_])  ; hard space - currency
        ;; (space-mark   ?\x8A0 [?\x8A4] [?_])  ; hard space - currency
        ;; (space-mark   ?\x920 [?\x924] [?_])  ; hard space - currency
        ;; (space-mark   ?\xE20 [?\xE24] [?_])  ; hard space - currency
        ;; (space-mark   ?\xF26 [?\xF2A] [?_])  ; hard space - currency
        (space-mark   ?　    [?□]    [?＿]) ; full-width space - square

        (tab-mark ?\t [?\xBB ?\t] [?\\ ?\t])

        (newline-mark ?\n    [?\xAB ?\n])    ; eol - right quote mark
        ;; (newline-mark ?\n    [?\xFFEC ?\n])  ; eol - '￬' mark
        ))


;; whitespace-mode で半角/全角スペース文字を可視化
(setq whitespace-space-regexp "\\( +\\|\x3000+\\)") 


;; 動作は軽くは無いので通常はoff 
;; (global-whitespace-mode 1)





(provide 'whitespace.config)
;;--------------------------------------------------------------------------------------------------
;; EOF
