;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2014/10/03.01:44:48


;;==================================================================================================
;; powerline setup                                                                                    
;;==================================================================================================




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


;; powerline.el の gensymで cl が必要
(require 'cl-lib)
(require 'powerline)





;; propertize された文字列のフェイスから foreground-color を取得
(defun powerline:get-face-foreground (target)
  (let ((output-string (format-mode-line target)))
    (if (null output-string) 
        ""
      (let ((property (get-text-property 0 'face output-string)))
        (if (null property) 'unspecified (face-foreground property nil t))
        ))))




(defun powerline:arrow-right0-xpm (color1 color2)
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

(defun powerline:arrow-right1-xpm (color1 color2)
  "Return an XPM right0 arrow string representing."
  (format "/* XPM */
static char * arrow_right1[] = {
\"12 18 2 1\",
\". c %s\",
\"  c %s\",
\".           \",
\" .          \",
\"  .         \",
\"   .        \",
\"    .       \",
\"     .      \",
\"      .     \",
\"       .    \",
\"        .   \",
\"        .   \",
\"       .    \",
\"      .     \",
\"     .      \",
\"    .       \",
\"   .        \",
\"  .         \",
\" .          \",
\".           \"};"  color1 color2))

(defun powerline:v-separator-right-xpm (color1 color2)
  "Return an XPM right0 arrow string representing."
  (format "/* XPM */
static char * arrow_right1[] = {
\"8 18 2 1\",
\". c %s\",
\"  c %s\",
\"....... \",
\"....... \",
\"....... \",
\"....... \",
\"....... \",
\"....... \",
\"....... \",
\"....... \",
\"....... \",
\"....... \",
\"....... \",
\"....... \",
\"....... \",
\"....... \",
\"....... \",
\"....... \",
\"....... \",
\"....... \"};"  color1 color2))

(defun powerline:s-separator-right-xpm (color1 color2)
  "Return an XPM right0 arrow string representing."
  (format "/* XPM */
static char * arrow_right1[] = {
\"10 18 2 1\",
\". c %s\",
\"  c %s\",
\"......... \",
\"......... \",
\"........  \",
\"........  \",
\".......   \",
\".......   \",
\"......    \",
\"......    \",
\".....     \",
\".....     \",
\"....      \",
\"....      \",
\"...       \",
\"...       \",
\"..        \",
\"..        \",
\".         \",
\".         \"};"  color1 color2))


(defun powerline:arrow-left0-xpm (color1 color2)
  "Return an XPM left arrow string representing."
  (format "/* XPM */
static char * arrow_left[] = {
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


(defconst powerline:color-0 "gray0")
(defconst powerline:color-1 "gray15")
(defconst powerline:color-2 "gray30")
(defconst powerline:color-3 "gray45")
;; (defconst powerline:color-4 "gray60")
;; (defconst powerline:color-4 "#00688b")  ;;DeepSkyBlue4
(defconst powerline:color-4 "#0078c0")  ;;DeepSkyBlue4
;; (defconst powerline:color-5 "#0068a0")
(defconst powerline:color-5 "#00688b")
(defconst powerline:color-s "#0078f0")    ;; separator-color

(defvar powerline:separator-right-0 (create-image (powerline:arrow-right0-xpm powerline:color-0 powerline:color-1) 'xpm t :ascent 'center))
(defvar powerline:separator-right-1 (create-image (powerline:arrow-right0-xpm powerline:color-1 powerline:color-2) 'xpm t :ascent 'center))
(defvar powerline:separator-right-2 (create-image (powerline:arrow-right0-xpm powerline:color-2 powerline:color-3) 'xpm t :ascent 'center))
(defvar powerline:separator-right-3 (create-image (powerline:arrow-right0-xpm powerline:color-3 powerline:color-4) 'xpm t :ascent 'center))
(defvar powerline:separator-right-4 (create-image (powerline:v-separator-right-xpm powerline:color-4 powerline:color-5) 'xpm t :ascent 'center))
(defvar powerline:separator-right-5 (create-image (powerline:arrow-right0-xpm powerline:color-5 powerline:color-0) 'xpm t :ascent 'center))
;; (defvar powerline:separator-right-4-0 (create-image (powerline:arrow-right1-xpm powerline:color-s powerline:color-4) 'xpm t :ascent 'center))
(defvar powerline:separator-right-4-0 (create-image (powerline:v-separator-right-xpm powerline:color-s powerline:color-4) 'xpm t :ascent 'center))

;; (defvar powerline:separator-left-0 (create-image (powerline:arrow-left0-xpm powerline:color-0 powerline:color-1) 'xpm t :ascent 'center))
(defvar powerline:separator-left-1 (create-image (powerline:arrow-left0-xpm powerline:color-0 powerline:color-5) 'xpm t :ascent 'center))
(defvar powerline:separator-left-2 (create-image (powerline:arrow-left0-xpm powerline:color-1 powerline:color-2) 'xpm t :ascent 'center))
(defvar powerline:separator-left-3 (create-image (powerline:arrow-left0-xpm powerline:color-2 powerline:color-3) 'xpm t :ascent 'center))
(defvar powerline:separator-left-4 (create-image (powerline:arrow-left0-xpm powerline:color-3 powerline:color-0) 'xpm t :ascent 'center))



(make-face 'powerline:face-1)
(set-face-attribute 'powerline:face-1 nil :foreground "#fff" :background powerline:color-1 :weight 'bold)

(make-face 'powerline:face-2)
(set-face-attribute 'powerline:face-2 nil :foreground "#fff" :background powerline:color-2 :weight 'normal)

(make-face 'powerline:face-3)
(set-face-attribute 'powerline:face-3 nil :foreground "#fff" :background powerline:color-3 :weight 'normal)

(make-face 'powerline:face-4)
(set-face-attribute 'powerline:face-4 nil :foreground "#fff" :background powerline:color-4 :weight 'bold)

(make-face 'powerline:face-5)
(set-face-attribute 'powerline:face-5 nil :foreground "#fff" :background powerline:color-5 :weight 'bold)



(defun powerline:custom-theme ()
  "setup a user custom theme."
  (interactive)
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

                   (:eval (concat (propertize " " 'display powerline:separator-right-0)))

                   (:eval (concat (propertize "  %12b  " 'face 'powerline:face-1)
                                  (propertize " " 'display powerline:separator-right-1)))

                   (:eval (concat (propertize (format "%-10s " (if (null vc-mode) "" vc-mode)) 'face 'powerline:face-2)
                                  (propertize " " 'display powerline:separator-right-2)))

                   (:eval (concat (propertize " %6p (%5l:%3c)  %I " 'face 'powerline:face-3)
                                  (propertize " " 'display powerline:separator-right-3)))

                   (:eval (concat (propertize " " 'face 'powerline:face-4)
                                  (propertize mode-name 'face 'powerline:face-4)
                                  (propertize " " 'display powerline:separator-right-4)))

                   (:eval (concat (propertize "" 'face 'powerline:face-5)
                                  (propertize (if (null mode-line-process) "" (format-mode-line mode-line-process)) 'face `(:foreground ,(powerline:get-face-foreground mode-line-process) :background ,powerline:color-5 :weight bold))
                                  (propertize (format-mode-line minor-mode-alist) 'face 'powerline:face-5)
                                  (propertize " " 'face 'powerline:face-5)
                                  (propertize " " 'display powerline:separator-right-5)))
                   

                   ;; Justify right by filling with spaces to right fringe - 16
                   ;; (16 should be computed rahter than hardcoded)
                   (:eval (propertize " " 'display '((space :align-to (- right-fringe 35)))))
                                        ;         (:eval (propertize " " 'display '((space :align-to (- right-fringe 31)))))


                   ;; (:eval (concat (propertize " " 'display arrow-left-2)
                   ;;         (propertize "012" 'face 'powerline:face-2)))
                   (:eval (concat (propertize " " 'display powerline:separator-left-1)
                                  (propertize (format "    %-31s     " display-time-string) 'face 'powerline:face-5)))

                   ))))



(powerline:custom-theme)






(provide 'setup.powerline)
;;--------------------------------------------------------------------------------------------------
;; EOF
