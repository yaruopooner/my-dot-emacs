;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2013/04/20.19:38:09


;;==============================================================================
;; Key Binding                                                                  
;; for Win32                                                                    
;;==============================================================================


;; (keyboard-translate ?\C-h ?\C-?)

(if nil
    (progn
      ;; caps <-> ctrl swap
      ;; うまく動かない
      (w32-set-modifier-key 20 'ctrl)
      (w32-set-modifier-key 240 'ctrl))
  (progn 
    ()
    ))


;; キーカスタマイズ(win32 only)

;; CapsLock ==> L_Control(101 key)
;; (w32-set-modifier-key 20 'ctrl)

;; CapsLock ==> L_Control(106 key)
;; (w32-set-modifier-key 240 'ctrl)

;; 
;; (w32-set-modifier-key 162 'capslock)





(provide 'win32/key-binding.config)
;;------------------------------------------------------------------------------
;; EOF
