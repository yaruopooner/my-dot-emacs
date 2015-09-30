;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2011/08/09.16:03:41


;;==============================================================================
;; Font Environment                                                             
;; for BDF                                                                      
;;==============================================================================

;;; TrueType-font Setting
(setq w32-use-w32-font-dialog t)

(setq scalable-fonts-allowed t)
(setq w32-enable-synthesized-fonts t)

(insert (prin1-to-string (x-list-fonts "*")))

(create-fontset-from-fontset-spec
 "-*-Courier New-normal-r-*-*-12-*-*-*-c-*-fontset-shinonome,
 japanese-jisx0208:-outline-BDF東雲ゴシック-*-*-normal-normal-12-*-96-96-c-*-jisx0208-sjis,
 latin-jisx0201:-outline-BDF東雲ゴシック-*-*-normal-normal-12-*-96-96-c-*-jisx0201-latin,
 katakana-jisx0201:-outline-BDF東雲ゴシック-*-*-normal-normal-12-*-96-96-c-*-jisx0201-katakana" t)

(setq font-encoding-alist
      (append '(("JISX0201"        (latin-jisx0201 . 0))
                ("JISX0208"        (japanese-jisx0208 . 0))
                ) font-encoding-alist))

;;; Frame parameters
(setq default-frame-alist
      (append '(
		(font . "-outline-BDF東雲ゴシック-*-*-normal-normal-12-*-96-96-c-*-jisx0208-sjis")
                )
              default-frame-alist))

(setq initial-frame-alist default-frame-alist)


;;------------------------------------------------------------------------------
;; EOF
