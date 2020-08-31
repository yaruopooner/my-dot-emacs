;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2018/07/06.10:25:16


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


;; (setq clang-server-type 'debug)
;; (setq clang-server-debug-log-buffer-p t)
;; (setq clang-server-debug-log-buffer-size (* 1024 1024))

(setq clang-server-stdin-buffer-size 2)
(setq clang-server-stdout-buffer-size 2)
;; (setq clang-server-translation-unit-flags "CXTranslationUnit_PrecompiledPreamble|CXTranslationUnit_CacheCompletionResults")
;; (setq clang-server-translation-unit-flags "CXTranslationUnit_CacheCompletionResults")

;; (setq clang-server-complete-results-limit 500)
;; (setq clang-server-complete-results-limit 1000)
;; (setq clang-server-complete-results-limit 2000)
(when (eq system-type 'windows-nt)
  (setq w32-pipe-read-delay 0))

(ac-clang-initialize)






(provide 'setup.ac-clang)
;;--------------------------------------------------------------------------------------------------
;; EOF
