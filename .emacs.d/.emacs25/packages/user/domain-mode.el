;;; -*- mode: emacs-lisp ; coding: utf-8-unix ; lexical-binding: nil -*-
;;; last updated : 2017/12/05.19:04:09



(require 'generic)


(define-generic-mode domain-mode
  ;; COMMENT-LIST
  nil

  ;; KEYWORD-LIST
  nil

  ;; FONT-LOCK-LIST
  '(("(:domain\\s-+\\([^[:space:]\n]+\\).*$" . font-lock-keyword-face)
    ("(:include\\s-+\\([^)]+\\).*$" . font-lock-preprocessor-face)
    ("(:constant\\s-+(\\(.+\\)$" . font-lock-constant-face)
    ("(:method\\s-+(\\([^)]+\\).*$" . font-lock-function-name-face)
    ("(:axiom\\s-+(\\([^)]+\\).*$" . font-lock-function-name-face)
    ("\\(//.*$\\)" . font-lock-comment-face)
    )

  ;; AUTO-MODE-LIST
  ;; auto-mode target file regex
  '("\\.domain$")

  ;; FUNCTION-LIST
  ;; major mode initial functions
  '((lambda ()
      (setq imenu-generic-expression
            '(
              ("domain" "(:domain\\s-+\\([^[:space:]\n]+\\).*$" 1)
              ("include" "(:include\\s-+\\([^)]+\\).*$" 1)
              ("constant" "(:constant\\s-+(\\(.+\\)$" 1)
              ("method" "(:method\\s-+(\\([^)]+\\).*$" 1)
              ("axiom" "(:axiom\\s-+(\\([^)]+\\).*$" 1)
              ))))

  ;; mode DOCSTRING
  "Major mode for Domain text")



(provide 'domain-mode)


;;--------------------------------------------------------------------------------------------------
;; EOF
