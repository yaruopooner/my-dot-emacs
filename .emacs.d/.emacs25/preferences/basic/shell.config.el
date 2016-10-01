;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2015/02/23.00:18:34


;;==============================================================================
;; Shell Command Options                                                        
;;==============================================================================


(require 'cl-lib)




;;------------------------------------------------------------------------------
;; Common Environment                                                           
;;------------------------------------------------------------------------------


;; shell コマンド引数の入力補完を行う
(add-hook 'shell-mode-hook 'pcomplete-shell-setup)


;; shell info
(defconst shell:info-alist
  '(
    (bash                                    . (
                         (explicit-file-name . "bash")
                         (file-name          . "bash")
                         (command-switch     . "-c")
                         ))
    (zsh                                     . (
                         (explicit-file-name . "zsh")
                         (file-name          . "zsh")
                         (command-switch     . "-c")
                         ))
    (tcsh                                    . (
                         (explicit-file-name . "tcsh")
                         (file-name          . "tcsh")
                         (command-switch     . "-c")
                         ))
    (cmd                                     . (
                         (explicit-file-name . "cmdproxy")
                         (file-name          . "cmdproxy")
                         (command-switch     . "\\/c")
                         ))
    ))



;; shell setup function
(defun shell:setup (shell-name)
  (cl-labels (
           ;; shell info queries
           (shell:get-info (shell)
                           (cdr (assq shell shell:info-alist)))

           (shell:get-detail (shell-info detail-name)
                             (cdr (assq detail-name shell-info)))
           )

    (let ((info (shell:get-info shell-name)))
      (setq explicit-shell-file-name (shell:get-detail info 'explicit-file-name))
      (setq shell-file-name (shell:get-detail info 'file-name))
      (setq shell-command-switch (shell:get-detail info 'command-switch)))))




;;------------------------------------------------------------------------------
;; Local Environment                                                            
;;------------------------------------------------------------------------------

(let ((self-file-name "shell.config"))
  (deu:load-library-auto-select-platform-path self-file-name de:path-basic-configuration)
  )






(provide 'shell.config)
;;------------------------------------------------------------------------------
;; EOF
