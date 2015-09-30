;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/09/04.04:45:11

;;==============================================================================
;; Shell Command Options                                                        
;;==============================================================================



;;------------------------------------------------------------------------------
;; Common Environment                                                           
;;------------------------------------------------------------------------------


;; shell コマンド引数の入力補完を行う
(add-hook 'shell-mode-hook 'pcomplete-shell-setup)



;;------------------------------------------------------------------------------
;; Local Environment                                                            
;;------------------------------------------------------------------------------

(let ((self-file-name "shell.config"))
    (deu:load-library-auto-select-platform-path self-file-name path-basic-configuration)
)





(provide 'shell.config)
;;------------------------------------------------------------------------------
;; EOF