;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/04/28.21:53:05

;;==============================================================================
;; Shell Command Options                                                        
;; for Win32                                                                    
;;==============================================================================


(let (
      (enable-bash t)
      (enable-zsh nil)
      (enable-cmd nil)
      )
  

;;------------------------------------------------------------------------------
;; bash.exe (GNU-Win32)                                                         
;;------------------------------------------------------------------------------

(if enable-bash
    (progn
      (setq explicit-shell-file-name "bash") 
      (setq shell-file-name "bash") 
      (setq shell-command-switch "-c") 
    )
)


;;------------------------------------------------------------------------------
;; zsh
;;------------------------------------------------------------------------------

(if enable-zsh
    (progn
      (setq explicit-shell-file-name "zsh.exe") 
      (setq shell-file-name "zsh.exe") 
      (setq shell-command-switch "-c") 
    )
)


;;------------------------------------------------------------------------------
;; CMD.EXE (WindowsNT)                                                          
;;------------------------------------------------------------------------------

(if enable-cmd
    (progn
      (setq explicit-shell-file-name "cmd.exe") 
      (setq shell-file-name "cmd.exe") 
      (setq shell-command-switch "\\/c") 
    )
)


)





(provide 'win32/shell.config)
;;------------------------------------------------------------------------------
;; EOF
