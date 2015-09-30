;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/04/12.16:03:58


;;==================================================================================================
;; hideshowvis setup                                                                                    
;;==================================================================================================




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


;; hideshow 自体 Emacs 標準機能
;(require 'hideshow)

(autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")

(autoload 'hideshowvis-minor-mode "hideshowvis" "Will indicate regions foldable with hideshow in the fringe." 'interactive)




;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


(dolist (hook '(
		emacs-lisp-mode-hook
		c-mode-common-hook
		)
	      )
  (add-hook hook 'hideshowvis-enable)
  )



;; ソース全体のhide/showをトグル化する関数を追加
(defvar my-hs-all-hide nil "Current state of hideshow for toggling all.")

(defun my-hs-all-toggle-hiding () "Toggle hideshow all."
  (interactive)
  (setq my-hs-all-hide (not my-hs-all-hide))
  (if my-hs-all-hide
      (hs-hide-all)
    (hs-show-all)
    )
  )



;;------------------------------------------------------------------------------
;; global key bind
;;------------------------------------------------------------------------------


;(define-key hs-minor-mode-map (kbd "C-@") 'hs-toggle-hiding)
(add-hook 'hs-minor-mode-hook
	  '(lambda ()
	     (local-set-key (kbd "C-@") 'hs-toggle-hiding)
	     (local-set-key (kbd "C-M-@") 'my-hs-all-toggle-hiding)
	     )
	  )





(provide 'setup.hideshowvis)
;;--------------------------------------------------------------------------------------------------
;; EOF
