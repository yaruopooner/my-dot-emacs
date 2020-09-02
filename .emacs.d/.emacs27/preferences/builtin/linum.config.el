;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2015/07/29.14:47:52


;;==================================================================================================
;; linum setup                                                                                    
;;==================================================================================================

;; 昔は plugin だったが Emacs 23 から内部に取り込まれた

(require 'linum)





;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; デフォルトで linum-mode を有効にする
;; (global-linum-mode nil)

;; 表示フォーマット：指定桁分の領域を確保してライン行数のあとに1スペースを入れる
(setq linum-format "%5d ")


;; 重いので遅延有効化＋遅延スケジューリング
(setq linum-delay t)

(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))


;;------------------------------------------------------------------------------
;; デフォルトでライン行数を表示する対象を設定
;;------------------------------------------------------------------------------


;; メージャーモード/マイナーモードでの指定
(defconst linum:hook-list '(
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
                            js-mode-hook
                            js2-mode-hook
                            javascript-mode-hook
                            smarty-mode-hook
                            html-helper-mode-hook
                            ))



;; ファイル名での判定
(defconst linum:file-name-list '(
                                 ))

;; sample
;; (defvar linum:file-name-list '("hosts" "my_site"))



;; 拡張子での判定
(defconst linum:file-name-extension-list '(
                                           ))

;; sample
;; (defvar linum:file-name-extension-list '("conf" "bat"))


(defun linum:file-name ()
  (when (member (buffer-name) linum:file-name-list)
    (linum-mode t)))


(defun linum:file-name-extension ()
  (when (member (file-name-extension (buffer-file-name)) linum:file-name-extension)
    (linum-mode t)))





;;------------------------------------------------------------------------------
;; add hook                                                                     
;;------------------------------------------------------------------------------


;; リストに記述されているモードのみライン行数表示モードを適用
(cl-dolist (hook linum:hook-list)
  (add-hook hook '(lambda () (linum-mode t))))


;; 使用しないので無効化中
;; (add-hook 'find-file-hook 'linum:file-name)


;; 使用しないので無効化中
;; (add-hook 'find-file-hook 'linum:file-name-extension)





(provide 'linum.config)
;;--------------------------------------------------------------------------------------------------
;; EOF
