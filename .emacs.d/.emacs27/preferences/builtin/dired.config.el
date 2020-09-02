;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2012/09/25.20:28:46


;;==============================================================================
;; dired setup
;;==============================================================================


(require 'dired-x)

(require 'wdired)





;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; lsコマンドに渡す引数(-lは必須)
(setq dired-listing-switches "-lah")

;; ファイル名の大文字小文字無視でソート
(setq ls-lisp-ignore-case t)

;; ディレクトリとファイルを分けて表示
(setq ls-lisp-dirs-first t)

;; 日付表示フォーマット有効化
(setq ls-lisp-use-localized-time-format t)

;;表示フォーマット
(setq ls-lisp-format-time-list '("%Y-%m-%d %H:%M" "%Y-%m-%d %H:%M"))


;; ディレクトリを再帰的にコピー可能にする
;; `always' means copy recursively without asking.
;; `top' means ask for each directory at top level.
(setq dired-recursive-copies 'always)

;; ディレクトリを再帰的に削除可能にする(使用する場合は注意), 
;; `always' means delete recursively without asking.  This is DANGEROUS!
;; `top' means ask for each directory at top level, but delete its subdirectories
(setq dired-recursive-deletes 'top)


;; wdired 編集開始を dired-modeの "r" キーにバインド
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)


;; ゴミ箱を有効
;; diredからファイル削除時に、OSが提供するゴミ箱にファイルを移動。GNOMEとWindowsで動作を確認
(setq delete-by-moving-to-trash t) 





(provide 'dired.config)
;;------------------------------------------------------------------------------
;; EOF
