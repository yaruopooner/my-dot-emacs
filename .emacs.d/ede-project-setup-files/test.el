;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2012/09/25.21:42:03

;;==================================================================================================
;; Score Engine all sources
;;==================================================================================================


(let (
	)
  (setq ede:project-name "test")
  (setq ede:project-file "./Project.ede")


  (setq ede:project-flymake-enable t)

  (setq ede:project-flymake-use-makefile nil)
  (setq ede:project-compiler 'g++)


  (setq ede:project-root-path "~/")

  ;; (setq ede:project-spp-table '(
  ;; 				      ("ENGINE_API" . "")
  ;; 				      ("ALIGN" . "")
  ;; 				      ))
  ;; (setq ede:project-spp-files '(
  ;; 				     "anzu/src/engine/Types.h"
  ;; 				     "anzu/src/engine/Compiler.h"
  ;; 				     ))


  (add-to-list 'ede:project-relative-include-path-list ede:project-root-path)
)



;;--------------------------------------------------------------------------------------------------
;;--------------------------------------------------------------------------------------------------

;;-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
;;-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+


;;--------------------------------------------------------------------------------------------------
;; EOF
