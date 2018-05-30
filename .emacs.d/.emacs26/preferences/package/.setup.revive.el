;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2013/04/20.19:59:52


;;==================================================================================================
;; revive setup                                                                                    
;;==================================================================================================




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


(eval-when-compile (require 'revive))


(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe Emacs" t)




;;------------------------------------------------------------------------------
;; basic setting
;;------------------------------------------------------------------------------


;; バッファ状態保存場所
(setq revive:configuration-file (expand-file-name ".revive" de:path-dot-emacs-root))


;; emacs終了時にバッファ状態を保存して、起動時に自動復元する機能を有効化
(defvar revive:auto-save-p t)
(defvar revive:auto-load-p t)




;;------------------------------------------------------------------------------
;; extend setting
;;------------------------------------------------------------------------------


;; emacs終了時にバッファ状態を保存
(defun revive-save-kill-emacs-hook ()
  (when revive:auto-save-p
    (save-current-configuration 1)))


;; emacs起動時にバッファ状態を復元
(defun revive-load-after-init-hook ()
  (when revive:auto-load-p
    (when (file-exists-p revive:configuration-file)
      (when (y-or-n-p "resume previous buffer state?")
        (resume 1)))))



;; emacs終了時
(add-hook 'kill-emacs-hook  'revive-save-kill-emacs-hook)
;; emacs起動時、初期化後
(add-hook 'after-init-hook  'revive-load-after-init-hook)
;; (add-hook 'term-setup-hook  'revive-load-after-init-hook)
;; (add-hook 'windows-setup-hook  'revive-load-after-init-hook)





;;------------------------------------------------------------------------------
;; Global Key Bind
;;------------------------------------------------------------------------------


(global-set-key (kbd "C-x S") 'save-current-configuration)
(global-set-key (kbd "C-x F") 'resume)
(global-set-key (kbd "C-x K") 'wipe)







(provide 'setup.revive)
;;--------------------------------------------------------------------------------------------------
;; EOF
