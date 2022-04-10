;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2015/07/29.14:33:58


;;==================================================================================================
;; hideshowvis setup                                                                                    
;;==================================================================================================




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


;; hideshow 自体 Emacs 標準機能
(eval-when-compile (require 'hideshow))

(autoload 'hideshowvis-enable "hideshowvis" "Highlight foldable regions")

(autoload 'hideshowvis-minor-mode "hideshowvis" "Will indicate regions foldable with hideshow in the fringe." 'interactive)




;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


(cl-dolist (hook '(
                emacs-lisp-mode-hook
                ;; c-mode-common-hook
                js-mode-hook
                lua-mode-hook
                ))
  (add-hook hook 'hideshowvis-enable))



;; ソース全体のhide/showをトグル化する関数を追加
(defvar hs:all-hide nil "Current state of hideshow for toggling all.")

(defun hs:all-toggle-hiding () "Toggle hideshow all."
  (interactive)
  (setq hs:all-hide (not hs:all-hide))
  (if hs:all-hide
      (hs-hide-all)
    (hs-show-all)))




;; hide状態のリージョンをfringeで(+)表示
(define-fringe-bitmap 'hs-marker [0 24 24 126 126 24 24 0])

(defcustom hs-fringe-face 'hs-fringe-face
  "*Specify face used to highlight the fringe on hidden regions."
  :type 'face
  :group 'hideshow)

(defface hs-fringe-face
  '((t (:foreground "#888" :box (:line-width 2 :color "grey75" :style released-button))))
  "Face used to highlight the fringe on folded regions"
  :group 'hideshow)

(defcustom hs-face 'hs-face
  "*Specify the face to to use for the hidden region indicator"
  :type 'face
  :group 'hideshow)

(defface hs-face
  '((t (:background "#ff8" :box t)))
  "Face to hightlight the ... area of hidden regions"
  :group 'hideshow)

(defun display-code-line-counts (ov)
  (when (eq 'code (overlay-get ov 'hs))
    (let* ((marker-string "*fringe-dummy*")
           (marker-length (length marker-string))
           (display-string (format "(%d)..." (count-lines (overlay-start ov) (overlay-end ov))))
           )
      (overlay-put ov 'help-echo "Hiddent text. C-c,= to show")
      (put-text-property 0 marker-length 'display (list 'left-fringe 'hs-marker 'hs-fringe-face) marker-string)
      (overlay-put ov 'before-string marker-string)
      (put-text-property 0 (length display-string) 'face 'hs-face display-string)
      (overlay-put ov 'display display-string)
      )))

(setq hs-set-up-overlay 'display-code-line-counts)




;;------------------------------------------------------------------------------
;; local keybind
;;------------------------------------------------------------------------------


;; (define-key hs-minor-mode-map (kbd "C-@") 'hs-toggle-hiding)
(add-hook 'hs-minor-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-@") 'hs-toggle-hiding)
             (local-set-key (kbd "C-M-@") 'hs:all-toggle-hiding)
             ))





(provide 'setup.hideshowvis)
;;--------------------------------------------------------------------------------------------------
;; EOF
