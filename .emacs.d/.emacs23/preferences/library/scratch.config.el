;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/09/03.03:40:43

;;==============================================================================
;; *scratch* auto backup & auto restore
;;==============================================================================


(defvar my-scratch-map-file (expand-file-name ".scratch" de:path-dot-emacs-root))


(defun scratch-save-kill-emacs-hook ()
  (let ((scratch-buf (get-buffer "*scratch*")))
    (when scratch-buf
      (with-current-buffer scratch-buf
        (when (not (string= initial-scratch-message (buffer-string)))
          (write-file my-scratch-map-file nil)
	  )
	)
      )
    )
  )


(defun scratch-save-kill-buffer-hook ()
  (when (equal (current-buffer) (get-buffer "*scratch*"))
    (unless (string= initial-scratch-message (buffer-string))
      (write-file my-scratch-map-file nil)
      )
    )
  )


(defun scratch-read-after-init-hook ()
  (when (file-exists-p my-scratch-map-file)
    (let ((scratch-buf (get-buffer "*scratch*")))
      (when scratch-buf
	(with-current-buffer scratch-buf
	  (erase-buffer)
	  (insert-file-contents my-scratch-map-file))
	)
      )
    )
  )



;;------------------------------------------------------------------------------
;; add hook                                                                     
;;------------------------------------------------------------------------------


;; emacs終了時
(add-hook 'kill-emacs-hook  'scratch-save-kill-emacs-hook)
;; *scratch*バッファ終了時
(add-hook 'kill-buffer-hook 'scratch-save-kill-buffer-hook)
;; emacs起動時、初期化後
(add-hook 'after-init-hook  'scratch-read-after-init-hook)






(provide 'scratch.config)
;;------------------------------------------------------------------------------
;; EOF
