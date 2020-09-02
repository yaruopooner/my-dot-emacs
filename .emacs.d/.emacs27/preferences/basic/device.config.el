;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2013/04/20.19:33:28


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
  (deu:load-library-auto-select-platform-path self-file-name de:path-basic-configuration)
  )


;;------------------------------------------------------------------------------
;; test condition
(if nil
    (let ((self-file-name "device.config"))
      (cond
       ;; Emacs
       ((eq de:emacs-type 'emacs)
        (load-library (concat de:rpath-basic-configuration (concat de:rpath-Env-Linux self-file-name))))
       ;; Meadow
       ((eq de:emacs-type 'meadow)
        (load-library (concat de:rpath-basic-configuration (concat de:rpath-Env-Win32 self-file-name)))))))





(provide 'device.config)
;;------------------------------------------------------------------------------
;; EOF
