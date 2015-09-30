;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/04/28.21:53:05

;;==============================================================================
;; IME Environment                                                              
;; for Win32                                                                    
;;==============================================================================


(let (
      (enable-win32-ime nil)
      (enable-egg-custom nil)
      )

;;------------------------------------------------------------------------------
;; Win32 IME                                                                    
;;------------------------------------------------------------------------------

;(select-input-method "MW32-IME")
;(toggle-input-method)

;; IME の初期化
(if enable-win32-ime
    (progn
      (mw32-ime-initialize)
      (setq default-input-method "MW32-IME")
      (setq mw32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
      (setq-default mw32-ime-mode-line-state-indicator "[--]")

      ;; IME の on と off でカーソルの色を変える
      (add-hook 'mw32-ime-on-hook '(lambda () (set-cursor-color ect-frame-face-cursor-color-ime-on)))
      (add-hook 'mw32-ime-off-hook '(lambda () (set-cursor-color ect-frame-face-cursor-color-ime-off)))
    )
)


;;------------------------------------------------------------------------------
;; Canna for Emacs & Mule                                                       
;;------------------------------------------------------------------------------


;(if (and (boundp 'CANNA) CANNA)
;    (progn
;   (load-library "canna")
;   (canna) ))


;;------------------------------------------------------------------------------
;; egg                                                                          
;;------------------------------------------------------------------------------

(if enable-egg-custom
    (load-library "egg-custom")
)


)





(provide 'win32/ime.config)
;;------------------------------------------------------------------------------
;; EOF
