;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2015/04/18.15:34:46


;;==============================================================================
;; IME Environment                                                              
;; for Win32                                                                    
;;==============================================================================


(let (
      (enable-win32-ime (fboundp 'w32-ime-initialize))
      (enable-egg-custom nil)
      )

;;------------------------------------------------------------------------------
;; Win32 IME                                                                    
;;------------------------------------------------------------------------------

;; (select-input-method "MW32-IME")
;; (toggle-input-method)

;; IME の初期化
  (if enable-win32-ime
      (progn
        ;; (set-language-environment "UTF-8") ;; UTF-8でも問題ないので適宜コメントアウトしてください
        (setq default-input-method "W32-IME")
        (setq-default w32-ime-mode-line-state-indicator "[--]")
        (setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
        (w32-ime-initialize)

        ;; 日本語入力時にカーソルの色を変える設定 (色は適宜変えてください)
        ;; (add-hook 'w32-ime-on-hook '(lambda () (set-cursor-color "coral4")))
        ;; (add-hook 'w32-ime-off-hook '(lambda () (set-cursor-color "black")))
        ))


;;------------------------------------------------------------------------------
;; Canna for Emacs & Mule                                                       
;;------------------------------------------------------------------------------


;; (if (and (boundp 'CANNA) CANNA)
;;    (progn
;;   (load-library "canna")
;;   (canna) ))


;;------------------------------------------------------------------------------
;; egg                                                                          
;;------------------------------------------------------------------------------

  (when enable-egg-custom
    (load-library "egg-custom")))





(provide 'win32/ime.config)
;;------------------------------------------------------------------------------
;; EOF
