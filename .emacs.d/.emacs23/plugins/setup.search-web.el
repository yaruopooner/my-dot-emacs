;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/06/05.16:49:46


;;==================================================================================================
;; search-web Setup                                                                            
;;==================================================================================================




;;------------------------------------------------------------------------------
;; Load                                                                         
;;------------------------------------------------------------------------------


(require 'search-web)




;;------------------------------------------------------------------------------
;; add dictionary web site
;;------------------------------------------------------------------------------

(add-to-list 'search-engines '("Weblio" . "http://ejje.weblio.jp/content/%s"))




(provide 'setup.search-web)
;;--------------------------------------------------------------------------------------------------
;; EOF