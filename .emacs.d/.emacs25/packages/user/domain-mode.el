;;; -*- mode: emacs-lisp ; coding: utf-8-unix ; lexical-binding: nil -*-
;;; last updated : 2017/12/06.10:48:48



(require 'generic)


(define-generic-mode domain-mode
  ;; COMMENT-LIST
  '("//")

  ;; KEYWORD-LIST
  '("and" "or" "=" "not" "call")

  ;; FONT-LOCK-LIST
  '((":domain\\s-+\\([^[:space:]\n]+\\).*$" . font-lock-keyword-face)
    (":include\\s-+\\([^)]+\\).*$" . font-lock-preprocessor-face)
    (":constant[[:space:]\n]+" . font-lock-constant-face)
    ("\\(:\\(?:method\\|axiom\\)\\s-+([[:alpha:]_]+\\)" 1 font-lock-function-name-face)
    ("\\([?@#][[:alpha:]_]+\\)" 1 font-lock-constant-face)
    ("\\(![[:alpha:]_]+\\)" 1 font-lock-builtin-face)
    )

  ;; AUTO-MODE-LIST
  ;; auto-mode target file regex
  '("\\.domain$")

  ;; FUNCTION-LIST
  ;; major mode initial functions
  '((lambda ()
      (setq imenu-generic-expression
            '(
              ("domain" ":domain\\s-+\\([^[:space:]\n]+\\).*$" 1)
              ("include" ":include\\s-+\\([^)]+\\).*$" 1)
              ("constant" ":constant\\s-*[\n]?" 0)
              ("method" ":method\\s-+(\\([[:alpha:]_]+\\)" 1)
              ("axiom" ":axiom\\s-+(\\([[:alpha:]_]+\\)" 1)
              )))
    linum-mode)

  ;; mode DOCSTRING
  "Major mode for Domain text")



(provide 'domain-mode)


;;--------------------------------------------------------------------------------------------------
;; EOF
