;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/04/04.13:03:58

;;==================================================================================================
;; ECB setup                                                                                        
;;==================================================================================================



;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


;; !!!!! trick patch for error
;; error > can't load semantic-ctxt
;; patch begin
(require 'semantic/analyze)
(provide 'semantic-analyze)
(provide 'semantic-ctxt)
(provide 'semanticdb)
(provide 'semanticdb-find)
(provide 'semanticdb-mode)
(provide 'semantic-load)
;; patch end


;; load path addition
(add-to-list 'load-path (expand-file-name ".ecb-2.40/" path-plugins))

(setq semantic-load-turn-useful-things-on t)


(load-library "ecb")




;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; 起動時の tip-of-the-day を表示しない
(setq ecb-tip-of-the-day nil)


;; ecb メソッド等のウィンドウ幅の割合
(setq ecb-windows-width 0.28)
(setq ecb-windows-height 0.33)

(setq ecb-layout-window-sizes nil)

;; other-window 実行時のフォーカス移動 (all, only-edit, edit-and-compile, smart)
(setq ecb-other-window-behavior 'smart)

(defun ecb-toggle ()
  (interactive)
  (if ecb-minor-mode
      (ecb-deactivate)
    (ecb-activate)
  )
)

(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(ecb-options-version "2.40"))
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )



;;------------------------------------------------------------------------------
;; Global Key Bind
;;------------------------------------------------------------------------------


;; ECB ウィンドウのトグル
(global-set-key [f4] 'ecb-toggle)






(provide 'setup.ecb)
;;--------------------------------------------------------------------------------------------------
;; EOF
