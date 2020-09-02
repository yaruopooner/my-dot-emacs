;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2014/09/25.03:11:15


;;==============================================================================
;; *scratch* auto backup & auto restore
;;==============================================================================





;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


(defvar scratch:map-file (expand-file-name ".scratch" de:path-dot-emacs-root))


(defun scratch:save-kill-emacs-hook ()
  (let ((scratch-buf (get-buffer "*scratch*")))
    (when scratch-buf
      (with-current-buffer scratch-buf
        (when (not (string= initial-scratch-message (buffer-string)))
          (write-file scratch:map-file nil))))))



(defun scratch:save-kill-buffer-hook ()
  (when (equal (current-buffer) (get-buffer "*scratch*"))
    (unless (string= initial-scratch-message (buffer-string))
      (write-file scratch:map-file nil))))


(defun scratch:read-after-init-hook ()
  (when (file-exists-p scratch:map-file)
    (let ((scratch-buf (get-buffer "*scratch*")))
      (when scratch-buf
        (with-current-buffer scratch-buf
          (erase-buffer)
          (insert-file-contents scratch:map-file))))))



;;------------------------------------------------------------------------------
;; add hook                                                                     
;;------------------------------------------------------------------------------


;; emacs終了時
(add-hook 'kill-emacs-hook  'scratch:save-kill-emacs-hook)
;; *scratch*バッファ終了時
(add-hook 'kill-buffer-hook 'scratch:save-kill-buffer-hook)
;; emacs起動時、初期化後
(add-hook 'after-init-hook  'scratch:read-after-init-hook)





(provide 'scratch.config)
;;------------------------------------------------------------------------------
;; EOF
