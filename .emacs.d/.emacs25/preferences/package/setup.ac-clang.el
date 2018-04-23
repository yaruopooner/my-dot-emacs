;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2018/04/23.11:27:08


;;==================================================================================================
;; ac-clang setup                                                                                      
;;==================================================================================================


;; load path addition
;; (add-to-list 'load-path (expand-file-name "ac-clang/" de:path-plugins))




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


;; Load Module
(require 'ac-clang)





;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; (setq ac-clang-server-type 'debug)
(setq clang-server-stdin-buffer-size 2)
(setq clang-server-stdout-buffer-size 2)
;; (setq clang-server-translation-unit-flags "CXTranslationUnit_PrecompiledPreamble|CXTranslationUnit_CacheCompletionResults")
;; (setq clang-server-translation-unit-flags "CXTranslationUnit_CacheCompletionResults")

;; (setq clang-server-complete-results-limit 500)
;; (setq clang-server-complete-results-limit 1000)
;; (setq clang-server-complete-results-limit 2000)
(setq w32-pipe-read-delay 0)

(ac-clang-initialize)






(provide 'setup.ac-clang)
;;--------------------------------------------------------------------------------------------------
;; EOF
