;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2013/04/20.19:50:43


;;==============================================================================
;; js-mode setup
;;==============================================================================


(require 'js)





;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; 選択リージョンをリフォーマット
(defun js-mode:json-reformat-region (beg end)
  (interactive "r")
  (shell-command-on-region beg end "python -m json.tool" nil t))


;; バッファをリフォーマット
(defun js-mode:json-reformat-buffer ()
  (interactive)
  (call-process-region (point-min) (point-max) shell-file-name t t nil shell-command-switch "python -m json.tool"))

;; バッファをリフォーマットプレビュー
(defun js-mode:json-reformat-buffer-preview ()
  (interactive)
  (let ( (default-major-mode nil) (buffer (get-buffer-create (format "*Json Reformat Preview<%s>*" (buffer-name)))) )
    (set-buffer-major-mode buffer)
    (call-process-region (point-min) (point-max) shell-file-name nil buffer nil shell-command-switch "python -m json.tool")
    (display-buffer buffer)))




(define-key js-mode-map (kbd "C-c j") 'js-mode:json-reformat-buffer)





(provide 'js-mode.config)
;;------------------------------------------------------------------------------
;; EOF
