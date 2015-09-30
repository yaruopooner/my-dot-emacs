;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/03/22.16:49:52

;;==================================================================================================
;; auto-install setup                                                                                     
;;==================================================================================================


;; pluginがインストールされる場所
;(add-to-list 'load-path "~/.emacs.d/auto-install/")
(setq auto-install-directory path-plugins)

; 変数 auto-install-use-wget == t の時は
; 環境変数 http_proxy （小文字）にproxy server urlとポートを設定
; export http_proxy=server_url:port

; 変数 auto-install-use-wget を nil に設定して, 明示的に wget の使用を避けている場合は, ↓を設定
;(setq url-proxy-services '(("http" . "server_url:port")))




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------

(require 'auto-install)




;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; 起動時にEmacsWikiページ名を補完候補に入れる
(auto-install-update-emacswiki-package-name t)

;; install-elisp.el互換モード
(auto-install-compatibility-setup)

; ediff関連のバッファを１つにまとめる
(setq ediff-windows-setup-function 'ediff-windows-plain)




(provide 'setup.auto-install)
;;--------------------------------------------------------------------------------------------------
;; EOF
