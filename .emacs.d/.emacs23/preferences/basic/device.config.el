;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/09/04.04:45:10

;;==============================================================================
;; Device (Mouse, Keyboard)                                                     
;;==============================================================================


;;------------------------------------------------------------------------------
;; Common Environment                                                           
;;------------------------------------------------------------------------------



;;------------------------------------------------------------------------------
;; Local Environment                                                            
;;------------------------------------------------------------------------------

(let ((self-file-name "device.config"))
    (deu:load-library-auto-select-platform-path self-file-name path-basic-configuration)
)


;;------------------------------------------------------------------------------
; test condition
(if nil
    (let ((self-file-name "device.config"))
	(cond
	 ;; Emacs
	 ((eq de:emacs-type 'emacs)
	  (load-library (concat rpath-basic-configuration (concat rpath-Env-Linux self-file-name)))
	  )
	 ;; Meadow
	 ((eq de:emacs-type 'meadow)
	  (load-library (concat rpath-basic-configuration (concat rpath-Env-Win32 self-file-name)))
	  )
	)
    )
)





(provide 'device.config)
;;------------------------------------------------------------------------------
;; EOF
