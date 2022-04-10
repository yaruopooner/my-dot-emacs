;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2014/10/03.01:47:06


;;==================================================================================================
;; tabbar 1.3 setup                                                                                      
;;==================================================================================================




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


(require 'cl-lib)
(require 'tabbar)





;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; グループ化せずに*scratch*以外のタブを表示
(setq tabbar-buffer-groups-function (lambda (b) (list "All Buffers")))

(setq tabbar-buffer-list-function
      '(lambda ()
         (cl-remove-if
          (lambda (buffer)
            (find (aref (buffer-name buffer) 0) " *"))
          (buffer-list))))


(tabbar-mode)


;; 左に表示されるボタンを無効化
;; (setq tabbar-home-button-enabled "")
;; (setq tabbar-scroll-left-button-enabled "")
;; (setq tabbar-scroll-right-button-enabled "")
;; (setq tabbar-scroll-left-button-disabled "")
;; (setq tabbar-scroll-right-button-disabled "")



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
