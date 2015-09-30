;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/07/15.08:26:11


;;==================================================================================================
;; powerline setup                                                                                    
;;==================================================================================================




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


;; ロードはしない
;; ロードするとバイトコンパイルエラー
;; ロードせずに powerline.elの必要関数のみ使用


;; powerline.el



;; propertize された文字列のフェイスから foreground-color を取得
(defun pl::get-face-foreground (target)
  (let ((output-string (format-mode-line target)))
    (if (null output-string) 
	""
      (let ((property (get-text-property 0 'face output-string)))
	(if (null property) 'unspecified (face-foreground property nil t))
	)
      )
    )
  )




(defun arrow-right-xpm (color1 color2)
  "Return an XPM right arrow string representing."
  (format "/* XPM */
static char * arrow_right[] = {
\"12 18 2 1\",
\". c %s\",
\"  c %s\",
\".           \",
\"..          \",
\"...         \",
\"....        \",
\".....       \",
\"......      \",
\".......     \",
\"........    \",
\".........   \",
\".........   \",
\"........    \",
\".......     \",
\"......      \",
\".....       \",
\"....        \",
\"...         \",
\"..          \",
\".           \"};"  color1 color2))

(defun arrow-left-xpm (color1 color2)
  "Return an XPM right arrow string representing."
  (format "/* XPM */
static char * arrow_right[] = {
\"12 18 2 1\",
\". c %s\",
\"  c %s\",
\"           .\",
\"          ..\",
\"         ...\",
\"        ....\",
\"       .....\",
\"      ......\",
\"     .......\",
\"    ........\",
\"   .........\",
\"   .........\",
\"    ........\",
\"     .......\",
\"      ......\",
\"       .....\",
\"        ....\",
\"         ...\",
\"          ..\",
\"           .\"};"  color2 color1))


(defconst pl::color-0 "gray0")
(defconst pl::color-1 "gray15")
(defconst pl::color-2 "gray30")
(defconst pl::color-3 "gray45")
(defconst pl::color-4 "gray60")
(defconst pl::color-5 "gray75")

(defvar pl::arrow-right-0 (create-image (arrow-right-xpm pl::color-0 pl::color-1) 'xpm t :ascent 'center))
(defvar pl::arrow-right-1 (create-image (arrow-right-xpm pl::color-1 pl::color-2) 'xpm t :ascent 'center))
(defvar pl::arrow-right-2 (create-image (arrow-right-xpm pl::color-2 pl::color-3) 'xpm t :ascent 'center))
(defvar pl::arrow-right-3 (create-image (arrow-right-xpm pl::color-3 pl::color-4) 'xpm t :ascent 'center))
(defvar pl::arrow-right-4 (create-image (arrow-right-xpm pl::color-4 pl::color-0) 'xpm t :ascent 'center))

;(defvar arrow-left-0 (create-image (arrow-left-xpm pl::color-0 pl::color-1) 'xpm t :ascent 'center))
(defvar arrow-left-1 (create-image (arrow-left-xpm pl::color-0 pl::color-1) 'xpm t :ascent 'center))
(defvar arrow-left-2 (create-image (arrow-left-xpm pl::color-1 pl::color-2) 'xpm t :ascent 'center))
(defvar arrow-left-3 (create-image (arrow-left-xpm pl::color-2 pl::color-3) 'xpm t :ascent 'center))
(defvar arrow-left-4 (create-image (arrow-left-xpm pl::color-3 pl::color-0) 'xpm t :ascent 'center))



(make-face 'pl::face-1)
(set-face-attribute 'pl::face-1 nil :foreground "#fff" :background pl::color-1)

(make-face 'pl::face-2)
(set-face-attribute 'pl::face-2 nil :foreground "#fff" :background pl::color-2)

(make-face 'pl::face-3)
(set-face-attribute 'pl::face-3 nil :foreground "#fff" :background pl::color-3)

(make-face 'pl::face-4)
(set-face-attribute 'pl::face-4 nil :foreground "#fff" :background pl::color-4)




(setq-default mode-line-format
	      (list  
	       `(
		 "%e"
		 "-"
		 mode-line-mule-info
		 mode-line-client
		 mode-line-modified
		 mode-line-remote
		 " "

		 (:eval (concat (propertize " " 'display pl::arrow-right-0)))

		 (:eval (concat (propertize "  %12b  " 'face 'pl::face-1)
				(propertize " " 'display pl::arrow-right-1)))

		 (:eval (concat (propertize " %6p (%5l:%3c)  %I " 'face 'pl::face-2)
				(propertize " " 'display pl::arrow-right-2)))

		 (:eval (concat (propertize (format "%-10s " (if (null vc-mode) "" vc-mode)) 'face 'pl::face-3)
				(propertize " " 'display pl::arrow-right-3)))

		 (:eval (concat (propertize " " 'face 'pl::face-4)
				(propertize mode-name 'face 'pl::face-4)
				(propertize (if (null mode-line-process) "" (format-mode-line mode-line-process)) 'face `(:foreground ,(pl::get-face-foreground mode-line-process) :background ,pl::color-4))
				(propertize (format-mode-line minor-mode-alist) 'face 'pl::face-4)
				(propertize " " 'face 'pl::face-4)
				(propertize " " 'display pl::arrow-right-4)))
		 

		 ;; Justify right by filling with spaces to right fringe - 16
		 ;; (16 should be computed rahter than hardcoded)
		 (:eval (propertize " " 'display '((space :align-to (- right-fringe 35)))))
;		 (:eval (propertize " " 'display '((space :align-to (- right-fringe 31)))))


		 ;; (:eval (concat (propertize " " 'display arrow-left-2)
		 ;; 		(propertize "012" 'face 'pl::face-2)))
		 (:eval (concat (propertize " " 'display arrow-left-1)
				(propertize (format "    %-31s     " display-time-string) 'face 'pl::face-1)))

		 )
	       )
	      )







(provide 'setup.powerline)
;;--------------------------------------------------------------------------------------------------
;; EOF
