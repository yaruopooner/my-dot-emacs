;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2018/05/30.17:59:27


;;==================================================================================================
;; display-line-numbers setup                                                                                    
;;==================================================================================================

(require 'display-line-numbers)





;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; デフォルトで mode を有効にする
;; (global-display-line-numbers-mode)

;; 表示フォーマット：指定桁分の領域を確保してライン行数のあとに1スペースを入れる
;; (setq linum-format "%5d ")


;; 重いので遅延有効化＋遅延スケジューリング
;; (setq linum-delay t)

;; (defadvice linum-schedule (around my-linum-schedule () activate)
;;   (run-with-idle-timer 0.2 nil #'linum-update-current))


;;------------------------------------------------------------------------------
;; デフォルトでライン行数を表示する対象を設定
;;------------------------------------------------------------------------------


;; メージャーモード/マイナーモードでの指定
(defconst display-line-numbers:hooks '(
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
(defconst display-line-numbers:file-names '(
                                            ))

;; sample
;; (defvar display-line-numbers:file-names '("hosts" "my_site"))



;; 拡張子での判定
(defconst display-line-numbers:file-name-extensions '(
                                                      ))

;; sample
;; (defvar display-line-numbers:file-name-extensions '("conf" "bat"))


(defun display-line-numbers:file-name ()
  (when (member (buffer-name) display-line-numbers:file-names)
    (display-line-numbers-mode t)))


(defun display-line-numbers:file-name-extension ()
  (when (member (file-name-extension (buffer-file-name)) display-line-numbers:file-name-extension)
    (display-line-numbers-mode t)))





;;------------------------------------------------------------------------------
;; add hook                                                                     
;;------------------------------------------------------------------------------


;; リストに記述されているモードのみライン行数表示モードを適用
(cl-dolist (hook display-line-numbers:hooks)
  (add-hook hook '(lambda () (display-line-numbers-mode t))))


;; 使用しないので無効化中
;; (add-hook 'find-file-hook 'display-line-numbers:file-name)


;; 使用しないので無効化中
;; (add-hook 'find-file-hook 'display-line-numbers:file-name-extension)





(provide 'display-line-numbers.config)
;;--------------------------------------------------------------------------------------------------
;; EOF
