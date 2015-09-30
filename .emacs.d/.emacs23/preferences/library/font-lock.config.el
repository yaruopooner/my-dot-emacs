;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/09/04.04:44:40

;;==============================================================================
;; Font Lock :: Default Face  Extension & Connection                            
;;==============================================================================


(let (my-custom-face-file-list)
    ;; Load File List
    (setq my-custom-face-file-list (list 
;				"emacs-color-theme"     ;; Emacs Color Theme Utilitiy
;				"user-face-00"          ;; User Face Type 00
				)
	  )

    ;; Load Execution
    (deu:load-libraries my-custom-face-file-list path-library-configuration)

    ;; ect load & enable
;    (ect-load ect-file-path)
)



;;------------------------------------------------------------------------------
;; add hook                                                                     
;;------------------------------------------------------------------------------


;; 関連づけるものはここに記述する
(add-hook 'font-lock-mode-hook '(lambda ()
;				  (ect-cc-mode-face-setup)
;				  (user-face-00-create)
				  )
	  )



;;------------------------------------------------------------------------------
;; font-lock-mode                                                               
;;------------------------------------------------------------------------------


;; フォントバッファ最大サイズを指定
(setq font-lock-maximum-size (* 8 (* 1024 1024)))

;; フォントロックモード
(setq font-lock-support-mode 'jit-lock-mode)

;; fast-lock は emacs23では使われなくなっている



;;------------------------------------------------------------------------------
;; lazy-lock-mode                                                               
;;------------------------------------------------------------------------------

;; 遅延ロックモード
;(setq font-lock-support-mode 'lazy-lock-mode)

;; フォント表示化遅延時間
;(setq lazy-lock-defer-time 0)





(provide 'font-lock.config)
;;------------------------------------------------------------------------------
;; EOF
