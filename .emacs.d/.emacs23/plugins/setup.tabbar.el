;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/03/22.16:52:47


;;==================================================================================================
;; tabbar 1.3 setup                                                                                      
;;==================================================================================================




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


(require 'tabbar)

;(require 'cl)




;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; グループ化せずに*scratch*以外のタブを表示
(when (require 'tabbar nil t)
  (setq tabbar-buffer-groups-function
	(lambda (b) (list "All Buffers"))
	)
  (setq tabbar-buffer-list-function
	(lambda ()
	  (remove-if
	   (lambda (buffer)
	     (find (aref (buffer-name buffer) 0) " *")
	     )
	   (buffer-list)
	   )
	  )
	)
  (tabbar-mode)
  )


;; 左に表示されるボタンを無効化
;(setq tabbar-home-button-enabled "")
;(setq tabbar-scroll-left-button-enabled "")
;(setq tabbar-scroll-right-button-enabled "")
;(setq tabbar-scroll-left-button-disabled "")
;(setq tabbar-scroll-right-button-disabled "")



;; 色設定

;; バー自体の色
(set-face-attribute
 'tabbar-default-face nil
 :background "gray90"
 )

;; 非アクティブなタブ
(set-face-attribute
 'tabbar-unselected-face nil
 :background "gray90"
 :foreground "black"
 :box nil
 )

;;アクティブなタブ
(set-face-attribute
 'tabbar-selected-face nil
 :background "black"
 :foreground "white"
 :box nil
 )


;; 幅設定
(set-face-attribute
 'tabbar-separator-face nil
 :height 1.0
 )




;;------------------------------------------------------------------------------
;; Global Key Bind
;;------------------------------------------------------------------------------


;; Firefoxライクなキーバインドに
(global-set-key (kbd "C-<tab>") 'tabbar-forward)
(global-set-key (kbd "C-S-<tab>") 'tabbar-backward)







(provide 'setup.tabbar)
;;--------------------------------------------------------------------------------------------------
;; EOF
