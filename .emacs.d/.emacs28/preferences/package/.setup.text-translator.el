;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2014/07/06.14:40:10


;;==================================================================================================
;; text-translator setup                                                                                    
;;==================================================================================================


;; load path addition
;; (add-to-list 'load-path (expand-file-name "text-translator/" de:path-plugins))



;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


;; use autoload
(require 'text-translator-load)


;; use require

;;;; not autoload, use require
(require 'text-translator)




;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; use proxy
;; プロキシに対応しており, デフォルトで環境変数 HTTP_PROXY を参照する

;; if you are setting environment variables HTTP_PROXY,
;; you have not to set this.
;; (setq text-translator-proxy-server "proxy.hogehoge.com")
;; (setq text-translator-proxy-port   8080)



;; use translation type auto selection (english/japanese only)
;; set function that use auto selection
(setq text-translator-auto-selection-func 'text-translator-translate-by-auto-selection-enja)





(provide 'setup.text-translator)
;;--------------------------------------------------------------------------------------------------
;; EOF
