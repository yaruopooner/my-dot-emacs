;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2012/09/25.21:42:02

;;==================================================================================================
;;==================================================================================================


(let ()
  (setq ede:project-name "test")
  (setq ede:project-file "./Project.ede")

  (setq ede:project-flymake-use-makefile nil)
  (setq ede:project-compiler 'vc++-2010)

  ;; project path
  (setq ede:path-project-root "~/")


  ;; Application
  (add-to-list 'ede:project-relative-include-path-list "/")
)



;;--------------------------------------------------------------------------------------------------
;; EOF
