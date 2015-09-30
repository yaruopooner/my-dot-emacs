;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2015/05/25.00:35:07


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
(setq ac-clang-server-stdin-buffer-size 2)
(setq ac-clang-server-stdout-buffer-size 2)
;; (setq ac-clang-clang-translation-unit-flags "CXTranslationUnit_PrecompiledPreamble|CXTranslationUnit_CacheCompletionResults")
;; (setq ac-clang-clang-translation-unit-flags "CXTranslationUnit_CacheCompletionResults")

;; (setq ac-clang-clang-complete-results-limit 500)
;; (setq ac-clang-clang-complete-results-limit 1000)
;; (setq ac-clang-clang-complete-results-limit 2000)
(setq w32-pipe-read-delay 0)

(ac-clang-initialize)






(provide 'setup.ac-clang)
;;--------------------------------------------------------------------------------------------------
;; EOF
