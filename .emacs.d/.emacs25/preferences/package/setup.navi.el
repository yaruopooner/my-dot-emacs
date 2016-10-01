;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2014/10/03.01:56:15


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
        ))



; add other modes and regexps for navi.el.
; below, 
; (1) I added a regexp ';@.*' to Emacs-Lisp mode.
; (2) I wrote over the regexp of navi.el for C++ mode.
; (3) I added a new mode-name and regexp for editing xml.
;     Originaly, navi.el does not know how to get tags from a buffer of xml-mode.
;     But in navi-regexp-alist, you can add a key as modename, and a value 
;     as the regexp which navi.el use how to get tags.
;     In this case, I was editing a xml file having tags <section NNN> and <titile NNN>.

(setq navi-regexp-alist (append '(
      ("^Emacs-Lisp$"           .    "^\\([ \t]*(\\(defun\\|defcustom\\|defvar\\|defgroup\\)[ \t]+.*\\|;@.*\\)$")
;      ("^C\\+\\+\\(/l?a?\\)?$" .    "\\(^#pragma[ \t]+mark[ \t]+[^\n]+\\|^using[ \t]+[^\n]+\\|^class[ \t]+[^\n]+\\|^namespace[ \t]+[^\n]+\\|^[^ \t\n#/{}\\(\\)]+[0-9a-zA-Z_ \t\\*\\&:]+([^\n;]*\\|^[\\+\\-]+[0-9a-zA-Z_ \t\\*\\&:]+([^\n]*\\)$")
      ("^C\\+\\+\\(/l?a?\\)?$"  .    
"\\(\
^#pragma[ \t]+mark[ \t]+[^\n]+\\|\
^using[ \t]+[^\n]+\\|\
^class[ \t]+[^\n]+\\|\
^namespace[ \t]+[^\n]+\\|\
^[^ \t\n#/{}\\(\\)]+[0-9a-zA-Z_ \t\\*\\&:]+([^\n;]*\\|\
^[\\+\\-]+[0-9a-zA-Z_ \t\\*\\&:]+([^\n]*\
\\)$")

      ("^xml$"                  .    "^\\([ \t]*<section.*\\|[ \t]*<title.*\\|<.+>.*\\)$")
      ) navi-regexp-alist))




;; navi.el内で navi-regexp-alist 走査時に assoc-ignore-case を単純に使用するだけなので
;; mode-name に微妙なsuffixがある場合に正常動作しなかった
;; そのため、 リスト側のキーデータを正規表現にして、引数にマッチするかチェックするように修正した。
;; もっとマシな方法は・・？
(defadvice assoc-ignore-case (around assoc-ignore-case-regexp (key alist) disable)
  (cl-dolist (value alist)
    (when (string-match (car value) key)
      (setq ad-return-value value)
      (return))))



;; navi 起動時だけ上記関数を有効化
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
;; color-theme を使用している場合は color-theme が優先されます
(setq navi-color-mode "yellow")
(setq navi-color-file "green")
(setq navi-color-func "white")


;; face が起動毎に作成されるのを回避
;; color-theme のfaceを利用させるため、faceが無い場合のみ作成させる
(defadvice navi-overlay-make-faces (around navi-face-create () activate)
  (unless (facep 'navi-mode)
    ad-do-it))




;; (when window-system
;;   (setq navi-color-mode "red")(setq navi-color-file "green")(setq navi-color-func "black")
;;   )


;; naviフレーム内のサイズ設定
(setq navi-listing-window-height 18)
(setq navi-listing-window-shrink-size 1)
(setq navi-source-window-scroll-size 1)


;; call function
(defun browse-navi ()
  (interactive)
  (navi (buffer-name)))




;;------------------------------------------------------------------------------
;; local keybind
;;------------------------------------------------------------------------------


;; navi 関数プロトタイプナビゲーター
;; (global-set-key (kbd "C-x C-l") 'browse-navi)

;; セットアップ時点ではモードマップ変数が生成されていないので使うときにマップへ登録する
(cl-dolist (target-mode '(
                       (c-mode-common-hook   . c-mode-map)
                       (c-mode-common-hook   . c++-mode-map)
                       (java-mode-hook       . java-mode-map)
                       (emacs-lisp-mode-hook . emacs-lisp-mode-map)
                       (lisp-mode-hook       . lisp-mode-map)
                       (lua-mode-hook        . lua-mode-map)
                       ))
  (add-hook (car target-mode) `(lambda ()
                                 (define-key ,(cdr target-mode) (kbd "C-x C-l") 'browse-navi))))






(provide 'setup.navi)
;;--------------------------------------------------------------------------------------------------
;; EOF
