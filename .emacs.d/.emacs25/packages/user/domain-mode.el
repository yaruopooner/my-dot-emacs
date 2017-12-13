;;; -*- mode: emacs-lisp ; coding: utf-8-unix ; lexical-binding: nil -*-
;;; last updated : 2017/12/13.20:48:41



(require 'generic)
(require 's)


;; error message sample
;; [drive]:\[path0]\[path1]\....\[filename].Domain/[line]/[column]: Warning: Variable ?threata is unused.
;; [drive]:\[path0]\[path1]\....\[filename].Domain/[line]/[column]: Error: See call to axiom is_threat_valid/1 here.

(defconst domain--flymake-allowed-file-name-masks '(("\\.\\(?:domain\\)\\'" domain--flymake-command-generator)))

(defconst domain--flymake-err-line-patterns
  '(("^\\([[:alpha:]]:\\\\[^/]+\\)/\\([[:digit:]]+\\)/\\([[:digit:]]+\\):[[:space:]]\\(.*\\)$" 1 2 3 4))

  "  (REGEXP FILE-IDX LINE-IDX COL-IDX ERR-TEXT-IDX).")


(defun domain--flymake-command-generator ()
  (let ((compile-file (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace)))
    `("cmd"
      ("/c" "d:/Dev/JAC/NIP/Assets/Game_Assets/Tools/HtnTranslator/translate_file_so.bat" ,compile-file))))




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
      ;; flymake
      (local-set-key (kbd "M-[") #'flymake:display-prev-error)
      (local-set-key (kbd "M-]") #'flymake:display-next-error)
      (set (make-local-variable 'flymake-allowed-file-name-masks) domain--flymake-allowed-file-name-masks)
      (set (make-local-variable 'flymake-err-line-patterns) domain--flymake-err-line-patterns)
      ;; 複数バッファのflymakeが同時にenableになるとflymake-processでpipe errorになるのを抑制
      (set (make-local-variable 'flymake-start-syntax-check-on-find-file) nil)
      (flymake-mode t)
      )
    flymake:hook-functions
    auto-complete-mode
    helm-gtags-mode
    linum-mode)

  ;; mode DOCSTRING
  "Major mode for Domain text")


(defun domain-convert-to-upper-camel-case (name)
  ;; (eval `(concat ,@(mapcar #'capitalize (split-string name "[^[:word:]]")))))
  (s-upper-camel-case name))
  
  
(defun domain-convert-to-snake-case (name)
  ;; (setq name (replace-regexp-in-string "\\([[:lower:]]\\)\\([[:upper:]]\\)" "\\1_\\2" name))
  ;; (setq name (replace-regexp-in-string "\\([[:alpha:]_]+\\).*" "\\1" name))
  ;; (downcase name))
  (s-snake-case name))


(defun domain-convert-to-upper-camel-case-at-point ()
  (interactive)
  (kill-new (message "%s" (domain-convert-to-upper-camel-case (substring-no-properties (thing-at-point 'symbol))))))

(defun domain-convert-to-snake-case-at-point ()
  (interactive)
  (kill-new (message "%s" (domain-convert-to-snake-case (substring-no-properties (thing-at-point 'symbol))))))



(provide 'domain-mode)


;;--------------------------------------------------------------------------------------------------
;; EOF
