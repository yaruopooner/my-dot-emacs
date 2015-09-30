;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/06/14.15:23:17


;;==================================================================================================
;; linum setup                                                                                    
;;==================================================================================================

;; 昔は plugin だったが Emacs 23 から内部に取り込まれた

(require 'linum)



;; デフォルトで linum-mode を有効にする
;(global-linum-mode nil)

;; 表示フォーマット：4桁分の領域を確保してライン行数のあとにスペースを入れる
(setq linum-format "%5d ")




;;------------------------------------------------------------------------------
;; デフォルトでライン行数を表示する対象を設定
;;------------------------------------------------------------------------------


;; メージャーモード/マイナーモードでの指定
(defvar my-linum-hook-name '(
			    emacs-lisp-mode-hook
			    c-mode-common-hook
			    slime-mode-hook
			    sh-mode-hook
			    text-mode-hook
			    php-mode-hook
			    python-mode-hook
			    ruby-mode-hook
			    css-mode-hook
			    yaml-mode-hook
			    org-mode-hook
			    howm-mode-hook
			    lua-mode-hook
			    js2-mode-hook
			    javascript-mode-hook
			    smarty-mode-hook
			    html-helper-mode-hook
			    )
      )





;;------------------------------------------------------------------------------
;; add hook                                                                     
;;------------------------------------------------------------------------------


; リストに記述されているモードのみライン行数表示モードを適用
(dolist (hook-name my-linum-hook-name)
  (add-hook hook-name '(lambda () (linum-mode t)))
  )



;; ファイル名での判定
(defvar my-linum-file nil)

;; sample
;; (defvar my-linum-file '("hosts" "my_site"))

(defun my-linum-file-name ()
  (when (member (buffer-name) my-linum-file) (linum-mode t) )
  )

; 使用しないので無効化中
;(add-hook 'find-file-hook 'my-linum-file-name)


;; 拡張子での判定
(defvar my-linum-file-extension nil)

;; sample
;; (defvar my-linum-file-extension '("conf" "bat"))

(defun my-linum-file-extension ()
  (when (member (file-name-extension (buffer-file-name)) my-linum-file-extension) (linum-mode t) )
  )

; 使用しないので無効化中
;(add-hook 'find-file-hook 'my-linum-file-extension)






(provide 'linum.config)
;;--------------------------------------------------------------------------------------------------
;; EOF
