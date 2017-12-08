;;; -*- mode: emacs-lisp ; coding: utf-8-unix ; lexical-binding: nil -*-
;;; last updated : 2017/12/08.18:32:15



(require 'generic)


(define-generic-mode 'domain-mode
  ;; COMMENT-LIST
  '("//")

  ;; KEYWORD-LIST
  '("and" "or" "=" "not" "call")

  ;; FONT-LOCK-LIST
  '((":domain\\s-+\\([^[:space:]\n]+\\).*$" . font-lock-keyword-face)
    (":include\\s-+\\([^)]+\\).*$" . font-lock-preprocessor-face)
    (":constant[[:space:]\n]+" . font-lock-constant-face)
    ("\\(:\\(?:method\\|axiom\\)\\s-+([[:alpha:]_]+\\)" 1 font-lock-function-name-face)
    ("\\([?@][[:alpha:]_]+\\)" 1 font-lock-constant-face)
    ("\\([!#][[:alpha:]_]+\\)" 1 font-lock-builtin-face)
    )

  ;; AUTO-MODE-LIST
  ;; auto-mode target file regex
  '("\\.domain$")

  ;; FUNCTION-LIST
  ;; major mode initial functions
  '((lambda ()
      (setq tab-width 4)                  ;タブ幅
      (setq indent-tabs-mode nil)         ;インデントTABモード(t:TAB, nil:whitespace) （nilはTABをtab-width分のwhitespaceに変換）
      (setq imenu-generic-expression
            '(
              ("domain" ":domain\\s-+\\([^[:space:]\n]+\\).*$" 1)
              ("include" ":include\\s-+\\([^)]+\\).*$" 1)
              ("constant" ":constant\\s-*[\n]?" 0)
              ("method" ":method\\s-+(\\([[:alpha:]_]+\\)" 1)
              ("axiom" ":axiom\\s-+(\\([[:alpha:]_]+\\)" 1)
              ))
      (setq ac-sources '(ac-source-imenu ac-source-gtags))
      (local-set-key (kbd "<tab>") #'auto-complete)
      )
    auto-complete-mode
    helm-gtags-mode
    linum-mode)

  ;; mode DOCSTRING
  "Major mode for Domain text")


(defun domain-convert-to-upper-camel-case (name)
  (eval `(concat ,@(mapcar #'capitalize (split-string name "[^[:word:]]")))))

(defun domain-convert-to-snake-case (name)
  (setq name (replace-regexp-in-string "\\([[:lower:]]\\)\\([[:upper:]]\\)" "\\1_\\2" name))
  (setq name (replace-regexp-in-string "\\([[:alpha:]_]+\\).*" "\\1" name))
  (downcase name))

(defun domain-convert-to-upper-camel-case-at-point ()
  (interactive)
  (message "%s" (domain-convert-to-upper-camel-case (substring-no-properties (thing-at-point 'symbol)))))

(defun domain-convert-to-snake-case-at-point ()
  (interactive)
  (message "%s" (domain-convert-to-snake-case (substring-no-properties (thing-at-point 'symbol)))))



(provide 'domain-mode)


;;--------------------------------------------------------------------------------------------------
;; EOF
