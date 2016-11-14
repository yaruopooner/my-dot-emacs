;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2016/11/14.19:52:26


;;==============================================================================
;; shell-script-mode setup
;;==============================================================================


;; shell-script-mode
;; (autoload 'shell-script-mode "shell-script-mode" "shell-script Edit Mode" t)




;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; http://www.geocities.co.jp/SiliconValley-Bay/9285/EMACS-JA/emacs_257.html#SEC258
;; or
;; describe-variable c-offsets-alist

(defun shell-script-mode:setup-variables ()
  "shell-script Mode : setup common edit style parameters."

  (interactive)

  ;;キーバインド
  ;; (define-key c-mode-map "\177" 'backward-delete-char) 
  ;; (define-key c++-mode-map "\177" 'backward-delete-char)


  ;; 動的略語展開では大文字小文字を区別(t:しない,nil:する)
  ;; (make-variable-buffer-local 'dabbrev-case-fold-search)
  ;; (setq dabbrev-case-fold-search nil)
  ;; 略語の大文字小文字のパターンを保存(t:する,nil:しない)
  ;; (make-variable-buffer-local 'dabbrev-case-replace)
  ;; (setq dabbrev-case-replace nil)


  ;; mode behavior setting

  ;; buffer-local-variable
  (setq tab-width 4)                  ;タブ幅
  ;; buffer-local-variable
  ;; (setq lisp-indent-offset nil)       ;インデントサイズ

  ;; インデントは3つのモードがあります
  ;; 1. 自動インデントなし
  ;;    インデント量はすべてユーザが明示的に空白やTABコードを入れて行います。
  ;; 2. 半自動インデント
  ;;    [TAB]キーを押した場合にはその行が、[C-j]による改行を実施した場合には次の行がインデントされます。
  ;; 3. 全自動インデント     
  ;;    中括弧、セミコロン、コロン、改行などを入力した時点でその行がインデントされ、さらに自動的に改行が挿入され、次の行のインデント位置にキャレットが移動します。

  ;; buffer-local-variable
  (setq c-auto-newline t)             ;自動改行設定(t:enable, nil:disable)
  (setq tab-always-indent nil)        ;インデント設定 [TAB]or[C-i] キーで(t:インデント実施, nil:TABコードを入力)
  ;; buffer-local-variable
  (setq indent-tabs-mode nil)         ;インデントTABモード(t:TAB, nil:whitespace) （nilはTABをwhitespaceに変換）
  )


(defun bat-mode:setup-variables ()
  "BAT Mode : setup common edit style parameters."

  (interactive)

  ;;キーバインド
  ;; (define-key c-mode-map "\177" 'backward-delete-char) 
  ;; (define-key c++-mode-map "\177" 'backward-delete-char)


  ;; 動的略語展開では大文字小文字を区別(t:しない,nil:する)
  ;; (make-variable-buffer-local 'dabbrev-case-fold-search)
  ;; (setq dabbrev-case-fold-search nil)
  ;; 略語の大文字小文字のパターンを保存(t:する,nil:しない)
  ;; (make-variable-buffer-local 'dabbrev-case-replace)
  ;; (setq dabbrev-case-replace nil)


  ;; mode behavior setting

  ;; buffer-local-variable
  (setq tab-width 4)                  ;タブ幅
  ;; buffer-local-variable
  ;; (setq lisp-indent-offset nil)       ;インデントサイズ

  ;; インデントは3つのモードがあります
  ;; 1. 自動インデントなし
  ;;    インデント量はすべてユーザが明示的に空白やTABコードを入れて行います。
  ;; 2. 半自動インデント
  ;;    [TAB]キーを押した場合にはその行が、[C-j]による改行を実施した場合には次の行がインデントされます。
  ;; 3. 全自動インデント     
  ;;    中括弧、セミコロン、コロン、改行などを入力した時点でその行がインデントされ、さらに自動的に改行が挿入され、次の行のインデント位置にキャレットが移動します。

  ;; buffer-local-variable
  (setq c-auto-newline t)             ;自動改行設定(t:enable, nil:disable)
  (setq tab-always-indent nil)        ;インデント設定 [TAB]or[C-i] キーで(t:インデント実施, nil:TABコードを入力)
  ;; buffer-local-variable
  (setq indent-tabs-mode nil)         ;インデントTABモード(t:TAB, nil:whitespace) （nilはTABをwhitespaceに変換）

  (setq comment-start "@rem ")
  )


(defun powershell-mode:setup-variables ()
  "PowerShell Mode : setup common edit style parameters."

  (interactive)

  ;;キーバインド
  ;; (define-key c-mode-map "\177" 'backward-delete-char) 
  ;; (define-key c++-mode-map "\177" 'backward-delete-char)


  ;; 動的略語展開では大文字小文字を区別(t:しない,nil:する)
  ;; (make-variable-buffer-local 'dabbrev-case-fold-search)
  ;; (setq dabbrev-case-fold-search nil)
  ;; 略語の大文字小文字のパターンを保存(t:する,nil:しない)
  ;; (make-variable-buffer-local 'dabbrev-case-replace)
  ;; (setq dabbrev-case-replace nil)


  ;; mode behavior setting

  ;; buffer-local-variable
  (setq tab-width 4)                  ;タブ幅
  ;; buffer-local-variable
  ;; (setq lisp-indent-offset nil)       ;インデントサイズ

  ;; インデントは3つのモードがあります
  ;; 1. 自動インデントなし
  ;;    インデント量はすべてユーザが明示的に空白やTABコードを入れて行います。
  ;; 2. 半自動インデント
  ;;    [TAB]キーを押した場合にはその行が、[C-j]による改行を実施した場合には次の行がインデントされます。
  ;; 3. 全自動インデント     
  ;;    中括弧、セミコロン、コロン、改行などを入力した時点でその行がインデントされ、さらに自動的に改行が挿入され、次の行のインデント位置にキャレットが移動します。

  ;; buffer-local-variable
  (setq c-auto-newline t)             ;自動改行設定(t:enable, nil:disable)
  (setq tab-always-indent nil)        ;インデント設定 [TAB]or[C-i] キーで(t:インデント実施, nil:TABコードを入力)
  ;; buffer-local-variable
  (setq indent-tabs-mode nil)         ;インデントTABモード(t:TAB, nil:whitespace) （nilはTABをwhitespaceに変換）
  )



;; hook function
(defun shell-script-mode:hook-functions ()
  ;; shell-script-mode 書式共通変数設定
  (shell-script-mode:setup-variables)
  
  ;; font-lock enable
  (turn-on-font-lock))

(defun bat-mode:hook-functions ()
  ;; bat-mode 書式共通変数設定
  (bat-mode:setup-variables)
  
  ;; font-lock enable
  (turn-on-font-lock))

(defun powershell-mode:hook-functions ()
  ;; powershell-mode 書式共通変数設定
  (powershell-mode:setup-variables)
  
  ;; font-lock enable
  (turn-on-font-lock))



;;------------------------------------------------------------------------------
;; add hook                                                                     
;;------------------------------------------------------------------------------


(add-hook 'shell-script-mode-hook 'shell-script-mode:hook-functions)
(add-hook 'bat-mode-hook 'bat-mode:hook-functions)
(add-hook 'powershell-mode-hook 'powershell-mode:hook-functions)






(provide 'shell-script-mode.config)
;;------------------------------------------------------------------------------
;; EOF
