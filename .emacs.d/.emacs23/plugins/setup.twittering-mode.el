;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/09/03.03:46:18


;;==================================================================================================
;; twittering-mode-2.0.0 setup                                                                                    
;;==================================================================================================


;; load path addition
(add-to-list 'load-path (expand-file-name "twittering-mode/" path-plugins))



;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


(require 'twittering-mode)




;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; 認証設定
(setq twittering-use-master-password t)

(setq twittering-curl-program (expand-file-name "twittering-mode/win-curl/curl.exe" path-plugins))
(setq twittering-cert-file (expand-file-name "twittering-mode/win-curl/curl-ca-bundle.crt" path-plugins))


;; network preference
(setq twittering-proxy-use t)
(setq twittering-proxy-server de:proxy-server)
(setq twittering-proxy-port de:proxy-port)


;; サーバ証明書の認証を無効化する
;(setq twittering-allow-insecure-server-cert t)


;; plugin preference
(setq twittering-icon-mode t)





(provide 'setup.twittering-mode)
;;--------------------------------------------------------------------------------------------------
;; EOF
