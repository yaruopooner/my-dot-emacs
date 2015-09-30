;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/04/18.20:21:58


;;==================================================================================================
;; navi 1.43 setup                                                                                    
;;==================================================================================================




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


(require 'navi)




;;------------------------------------------------------------------------------
;; patch                                                                        
;;------------------------------------------------------------------------------


;; overwrite > key is regular expression
(setq navi-regexp-alist
      '(
		("^Assembler$"              . "\\(^[ \t]*[^\n#/\\*=]+[0-9a-zA-Z_ \t\\*,\.:]+{[^\n;]*\\)$")
		("^Autoconf$"               . "^\\(^AC_DEFUN.*\\)$")
		("^Basic$"                  . "^\\(\\([Pp][Rr][Ii][Vv][Aa][Tt][Ee]\\|[Pp][Uu][Bb][Ll][Ii][Cc]\\|[Ss][Uu][Bb]\\|[F][U][N][C][T][I][O][N]\\)[ \t]+.*\\)$")
		("^C\\+\\+\\(/l?a?\\)?$"    . "\\(^@[^end \t]+[^\n]+\\|^#pragma[ \t]+mark[ \t]+[^\n]+\\|^[^ \t\n#/]+[0-9a-zA-Z_ \t\\*\\&:]+([^\n;]*\\)$")
		("^C\\(/l?a?\\)?$"          . "\\(^@[^end \t]+[^\n]+\\|^#pragma[ \t]+mark[ \t]+[^\n]+\\|^[^ \t\n#/]+[0-9a-zA-Z_ \t\\*\\&:]+([^\n;]*\\)$")
		("^CPerl$"                  . "^\\([ \t]*sub[ \t]+.*\\)$")
		("^Diff$"                   . "^\\(^[0-9*]+.*\\)$")
		("^Emacs-Lisp$"             . "^\\([ \t]*(defun[ \t]+.*\\)$")
		("^Lisp Interaction$"       . "^\\([ \t]*(defun[ \t]+.*\\)$")
		("^HTML$"                   . "^\\([ \t]*<[Hh][123456].*\\|[ \t]*<[Hh][Ee][Aa][Dd].*\\|[ \t]*<[Bb][Oo][Dd][Yy].*\\|[ \t]*<[Ff][Oo][Rr][Mm].*\\)$")
		("^Java$"                   . "\\(^[ \t]*[^\n#/\\*=]+[0-9a-zA-Z_ \t\\*,\.()]+{[^\n;]*\\)$")
		("^JavaScript$"             . "\\(^@[^end \t]+[^\n]+\\|^function[ \t]*(.*\\|^[^ \t\n#/]+[0-9a-zA-Z_ \t\\*\\&:]+([^\n;]*\\)$")
		("^m4$"                     . "^\\(^AC_DEFUN.*\\)$")
		("^ObjC\\(/l?a?\\)?$"       . "\\(^@[^end \t]+[^\n]+\\|^#pragma[ \t]+mark[ \t]+[^\n]+\\|^[^ \t\n#/]+[0-9a-zA-Z_ \t\\*\\&:]+([^\n;]*\\)$")
		("^Pascal$"                 . "^\\([Pp][Rr][Oo][Cc][Ee][Dd][Uu][Rr][Ee].*\\)$")
		("^Perl$"                   . "^\\([ \t]*sub[ \t]+.*\\)$")
		("^Ruby$"                   . "^\\([ \t]*\\(class\\|module\\|def\\|alias\\)[ \t]+.*\\)$")
		("^Text$"                   . "^\\([ \t]*[1234567890]+[\.]+.*\\)$")
		("^TeX$"                    . "^\\(\\\\chapter.*\\|\\\\section.*\\|\\\\subsection.*\\|\\\\subsubsection.*\\)$")
        )
      )



; add other modes and regexps for navi.el.
; below, 
; (1) I added a regexp ';@.*' to Emacs-Lisp mode.
; (2) I wrote over the regexp of navi.el for C++ mode.
; (3) I added a new mode-name and regexp for editing xml.
;     Originaly, navi.el does not know how to get tags from a buffer of xml-mode.
;     But in navi-regexp-alist, you can add a key as modename, and a value 
;     as the regexp which navi.el use how to get tags.
;     In this case, I was editing a xml file having tags <section NNN> and <titile NNN>.

(setq navi-regexp-alist
  (append
    '(
      ("^Emacs-Lisp$"             . "^\\([ \t]*(\\(defun\\|defcustom\\|defvar\\|defgroup\\)[ \t]+.*\\|;@.*\\)$")
;      ("^C\\+\\+\\(/l?a?\\)?$"    . "\\(^#pragma[ \t]+mark[ \t]+[^\n]+\\|^using[ \t]+[^\n]+\\|^class[ \t]+[^\n]+\\|^namespace[ \t]+[^\n]+\\|^[^ \t\n#/{}\\(\\)]+[0-9a-zA-Z_ \t\\*\\&:]+([^\n;]*\\|^[\\+\\-]+[0-9a-zA-Z_ \t\\*\\&:]+([^\n]*\\)$")
      ("^C\\+\\+\\(/l?a?\\)?$"    .
"\\(\
^#pragma[ \t]+mark[ \t]+[^\n]+\\|\
^using[ \t]+[^\n]+\\|\
^class[ \t]+[^\n]+\\|\
^namespace[ \t]+[^\n]+\\|\
^[^ \t\n#/{}\\(\\)]+[0-9a-zA-Z_ \t\\*\\&:]+([^\n;]*\\|\
^[\\+\\-]+[0-9a-zA-Z_ \t\\*\\&:]+([^\n]*\
\\)$")

      ("^xml$"                    . "^\\([ \t]*<section.*\\|[ \t]*<title.*\\|<.+>.*\\)$")
      ) navi-regexp-alist)
  )





(defadvice assoc-ignore-case (around assoc-ignore-case-regexp (key alist) disable)
  (dolist (value alist)
    (when (string-match (car value) key)
      (setq ad-return-value value)
      (return)
      )
    )
  )



(defadvice navi (around navi-patch (b) activate)
  (ad-enable-regexp "assoc-ignore-case-regexp")
  (ad-activate-regexp "assoc-ignore-case-regexp")
  ad-do-it
  (ad-deactivate-regexp "assoc-ignore-case-regexp")
  (ad-disable-regexp "assoc-ignore-case-regexp")
  )




;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; naviフレーム内のカラー設定
(setq navi-color-mode "yellow")
(setq navi-color-file "green")
(setq navi-color-func "white")


;(when window-system
;  (setq navi-color-mode "red")(setq navi-color-file "green")(setq navi-color-func "black")
;)


;; naviフレーム内のサイズ設定
(setq navi-listing-window-height 18)
(setq navi-listing-window-shrink-size 1)
(setq navi-source-window-scroll-size 1)


;; call function
(defun browse-navi ()
  (interactive)
  (navi (buffer-name))
  )




;;------------------------------------------------------------------------------
;; global key bind
;;------------------------------------------------------------------------------


;; navi 関数プロトタイプナビゲーター
(global-set-key (kbd "C-x C-l") 'browse-navi)







(provide 'setup.navi)
;;--------------------------------------------------------------------------------------------------
;; EOF
