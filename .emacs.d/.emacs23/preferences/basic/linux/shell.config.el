;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/04/28.21:53:06

;;==============================================================================
;; Shell Command Options                                                        
;; for Linux                                                                    
;;==============================================================================


(let (
      (enable-bash t)
      (enable-tcsh nil)
      )


;;------------------------------------------------------------------------------
;; bash (GNU)                                                                   
;;------------------------------------------------------------------------------

(if enable-bash
    (progn
      (setq explicit-shell-file-name "bash") 
      (setq shell-file-name "bash") 
      (setq shell-command-switch "-c") 
    )
)


;;------------------------------------------------------------------------------
;; tcsh                                                                         
;;------------------------------------------------------------------------------

(if enable-tcsh
    (progn
      (setq explicit-shell-file-name "tcsh") 
      (setq shell-file-name "tcsh") 
      (setq shell-command-switch "-c") 
    )
)


)





(provide 'linux/shell.config)
;;------------------------------------------------------------------------------
;; EOF
