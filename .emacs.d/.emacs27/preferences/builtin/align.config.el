;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2014/10/03.01:55:22


;;==============================================================================
;; align
;;==============================================================================


(require 'align)





;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; カスタムルールを適用するモードフックを指定
(defconst align:custom-rule-apply-mode-hook-list '(
                                                   c-mode-common-hook
                                                   lua-mode-hook
                                                   ))



;; オリジナルルールから除外するルール
(defconst align:exclude-key-list '(
                                   c-variable-declaration
                                   c-assignment
                                   ))


;; カスタムルール
;; モード毎のルールが増えてくるようならリストをモード別に分割して、フック時に連結させることも考慮すること.
(defvar align:custom-rules-list
  `(
    ;; c-common-mode
    ;; オリジナルとの違い
    ;; - regexp
    ;;   template< typename > の括弧内部に空白がある場合regexpにマッチしなかったのを修正
    ;; - valid
    ;;   除外キーワード群にマッチさせる正規表現がザルっぽいので厳しめに修正、大文字小文字識別を有効化
    (c-variable-declaration
     (regexp   . ,(concat "[*&0-9A-Za-z_]\\(?:\\s-*>\\)*[&*]*\\(\\s-+[*&]*\\)"
                          "[A-Za-z_][0-9A-Za-z:_]*\\s-*\\(\\()\\|"
                          "=[^=\n].*\\|(.*)\\|\\(\\[.*\\]\\)*\\)?"
                          "\\s-*[;,]\\|)\\s-*$\\)"))
     (group    . 1)
     (modes    . align-c++-modes)
     (justify  . t)
     (tab-stop . t)
     (valid    . ,(function
                   (lambda ()
                     (not (or (save-excursion
                                (goto-char (match-beginning 1))
                                (backward-word 1)
                                ;; 一時的に大文字小文字識別を有効化
                                (let ((case-fold-search nil))
                                  (looking-at
                                   "\\(goto\\|return\\|new\\|delete\\(?:\\[\\]\\)*\\|throw\\)\\s-+")))
                              (if (and (boundp 'font-lock-mode) font-lock-mode)
                                  (eq (get-text-property (point) 'face)
                                      'font-lock-comment-face)
                                (eq (caar (c-guess-basic-syntax)) 'c))))))))

    ;; オリジナルとの違い
    ;; - regexp
    ;;   operator % に対応していないので対応
    (c-assignment
     (regexp   . ,(concat "[^-=!^&*+<>/%| \t\n]\\(\\s-*[-=!^&*+<>/%|]*\\)"
                          "=\\(\\s-*\\)\\([^= \t\n]\\|$\\)"))
     (group    . (1 2))
     (modes    . align-c++-modes)
     (justify  . t)
     (tab-stop . nil))


    ;; lua-mode
    (lua-assignment
     (regexp   . ,(concat "[^~-=!^&*+<>/%| \t\n]\\(\\s-*[~-=!^&*+<>/%|]*\\)"
                          "=\\(\\s-*\\)\\([^= \t\n]\\|$\\)"))
     (group    . (1 2))
     (modes    . '(lua-mode))
     (justify  . t)
     (tab-stop . nil))

    ))



;; オリジナルルールをコピー
(defvar align:mode-rules-list (copy-tree align-rules-list))

;; オリジナルルールから align:exclude-key-list にあるルールを削除する
(cl-dolist (key align:exclude-key-list)
  (setq align:mode-rules-list (remove (assq key align:mode-rules-list) align:mode-rules-list)))

;; カスタムルールを連結
(setq align:mode-rules-list (append align:custom-rules-list align:mode-rules-list))




;;------------------------------------------------------------------------------
;; add hook                                                                     
;;------------------------------------------------------------------------------


;; 指定されたモードフックだけカスタムルールを適用
(cl-dolist (hook align:custom-rule-apply-mode-hook-list)
  (add-hook hook '(lambda () (setq align-mode-rules-list align:mode-rules-list))))





(provide 'align.config)
;;------------------------------------------------------------------------------
;; EOF
