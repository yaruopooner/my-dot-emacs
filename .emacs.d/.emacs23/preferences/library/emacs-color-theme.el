;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/09/04.04:48:53

;;==============================================================================
;; Font Lock Face :: ECT(Emacs Color Theme)                                     
;;==============================================================================


;;------------------------------------------------------------------------------
;; Emacs Color Theme 変数
;;------------------------------------------------------------------------------


;; カスタマイズテーマ名
(defvar emacs-color-theme-name                                   nil)


;; フレーム環境用カラー変数セット


;; アクティブウィンドウ透明度
(defvar ect-frame-semi-transparency-active-window                nil)
;; 非アクティブウィンドウ透明度
(defvar ect-frame-semi-transparency-inactive-window              nil)

;; フレームカラー
(defvar ect-frame-face-foreground-color                          nil)
(defvar ect-frame-face-background-color                          nil)

;; ノーマルカーソルカラー
(defvar ect-frame-face-cursor-color                              nil)
;; マウスカーソル表示色
(defvar ect-frame-face-mouse-color                               nil)
;; 選択しているフレームの境界色
(defvar ect-frame-face-border-color                              nil)

;; IME On/Off の時のカーソルカラー
(defvar ect-frame-face-cursor-color-ime-on                       nil)
(defvar ect-frame-face-cursor-color-ime-off                      nil)

;; モードライン
(defvar ect-frame-face-fgc-modeline                              nil)
(defvar ect-frame-face-bgc-modeline                              nil)

;; モードライン（アクティブでないバッファ）
(defvar ect-frame-face-fgc-mode-line-inactive                    nil)
(defvar ect-frame-face-bgc-mode-line-inactive                    nil)

;; 選択範囲
(defvar ect-general-face-fgc-region                              nil)
(defvar ect-general-face-bgc-region                              nil)

;; dired-mode:ディレクトリカラー
(defvar ect-dired-face-fgc-directory                             nil)
(defvar ect-dired-face-bgc-directory                             nil)


;; CC-Mode Face Color Change

;; 組み込み系
(defvar ect-cc-mode-face-fgc-builtin                             nil)
(defvar ect-cc-mode-face-bgc-builtin                             nil)

;; コメント
(defvar ect-cc-mode-face-fgc-comment                             nil)
(defvar ect-cc-mode-face-bgc-comment                             nil)

;; コメント区切り
(defvar ect-cc-mode-face-fgc-comment-delimiter                   nil)
(defvar ect-cc-mode-face-bgc-comment-delimiter                   nil)

;; 定数＆ラベル
(defvar ect-cc-mode-face-fgc-constant                            nil)
(defvar ect-cc-mode-face-bgc-constant                            nil)

;; ドキュメント
(defvar ect-cc-mode-face-fgc-doc                                 nil)
(defvar ect-cc-mode-face-bgc-doc                                 nil)

;; 関数定義部分
(defvar ect-cc-mode-face-fgc-function-name                       nil)
(defvar ect-cc-mode-face-bgc-function-name                       nil)

;; 制御文＆識別子＆指定子＆型修飾子＆記憶クラス指定子
(defvar ect-cc-mode-face-fgc-keyword                             nil)
(defvar ect-cc-mode-face-bgc-keyword                             nil)

;; 文字
(defvar ect-cc-mode-face-fgc-negation-char                       nil)
(defvar ect-cc-mode-face-bgc-negation-char                       nil)

;; プリプロセッサ
(defvar ect-cc-mode-face-fgc-preprocessor                        nil)
(defvar ect-cc-mode-face-bgc-preprocessor                        nil)

;; 正規表現
(defvar ect-cc-mode-face-fgc-regexp-grouping-construct           nil)
(defvar ect-cc-mode-face-bgc-regexp-grouping-construct           nil)

;; 正規表現バックスラッシュ
(defvar ect-cc-mode-face-fgc-regexp-grouping-backslash           nil)
(defvar ect-cc-mode-face-bgc-regexp-grouping-backslash           nil)

;; 文字列
(defvar ect-cc-mode-face-fgc-string                              nil)
(defvar ect-cc-mode-face-bgc-string                              nil)

;; 型指定子＆構造体宣言部＆クラス
(defvar ect-cc-mode-face-fgc-type                                nil)
(defvar ect-cc-mode-face-bgc-type                                nil)

;; 変数名宣言部
(defvar ect-cc-mode-face-fgc-variable-name                       nil)
(defvar ect-cc-mode-face-bgc-variable-name                       nil)

;; 警告
(defvar ect-cc-mode-face-fgc-warning                             nil)
(defvar ect-cc-mode-face-bgc-warning                             nil)






;;------------------------------------------------------------------------------
;; 汎用　Face のみの変更（mode に依存しないもの）                                     
;;------------------------------------------------------------------------------


(defun ect-general-face-setup ()
    "Emacs Color Theme Setup : General Face"
    (interactive)


;;------------------------------------------------------------------------------
;; all mode :: frame semi-transparency
;; フレーム透明度
    (deu:set-default-frame-parameter 'alpha `(,ect-frame-semi-transparency-active-window ,ect-frame-semi-transparency-inactive-window))


;;------------------------------------------------------------------------------
;; all mode :: frame
;; フレーム、カーソル、マウス、ボーダーのカラー変更
    (deu:set-default-frame-parameter 'foreground-color ect-frame-face-foreground-color)
    (deu:set-default-frame-parameter 'background-color ect-frame-face-background-color)
    (deu:set-default-frame-parameter 'cursor-color ect-frame-face-cursor-color)
    (deu:set-default-frame-parameter 'mouse-color ect-frame-face-mouse-color)
    (deu:set-default-frame-parameter 'border-color ect-frame-face-border-color)


;;------------------------------------------------------------------------------
;; all mode :: mode line
;; モードラインのカラー変更
    (set-face-foreground 'modeline ect-frame-face-fgc-modeline)
    (set-face-background 'modeline ect-frame-face-bgc-modeline)
    (set-face-bold-p 'modeline nil)
    (set-face-italic-p 'modeline nil)
    (set-face-underline-p 'modeline nil)


;;------------------------------------------------------------------------------
;; all mode :: mode line inactive
;; モードラインのカラー変更
    (set-face-foreground 'mode-line-inactive ect-frame-face-fgc-mode-line-inactive)
    (set-face-background 'mode-line-inactive ect-frame-face-bgc-mode-line-inactive)
    (set-face-bold-p 'mode-line-inactive nil)
    (set-face-italic-p 'mode-line-inactive nil)
    (set-face-underline-p 'mode-line-inactive nil)


;;------------------------------------------------------------------------------
;; all mode :: region
;; 選択範囲色
    (set-face-foreground 'region ect-general-face-fgc-region)
    (set-face-background 'region ect-general-face-bgc-region)
    (set-face-bold-p 'region nil)
    (set-face-italic-p 'region nil)
    (set-face-underline-p 'region nil)


;;------------------------------------------------------------------------------
;; all mode :: search
;; サーチ時の選択色
    (set-face-foreground 'isearch ect-general-face-fgc-region)
    (set-face-background 'isearch ect-general-face-bgc-region)


;;------------------------------------------------------------------------------
;; dired mode :: directory color
;; dired-modeのディレクトリカラー
    (make-face 'dired-directory)
    (set-face-foreground 'dired-directory ect-dired-face-fgc-directory)
    (set-face-background 'dired-directory ect-dired-face-bgc-directory)
    (set-face-bold-p 'dired-directory t)

)




;;------------------------------------------------------------------------------
;; font-lock-mode の時のみの face 変更（mode に依存するもの）                   
;;------------------------------------------------------------------------------


(defun ect-cc-mode-face-setup ()
    "Emacs Color Theme Setup : CC Mode Face"
    (interactive)
    (require 'font-lock)

;;------------------------------------------------------------------------------
;; font-lock を使用した face の作成                                             
; face の実体作成                                                               
; 関数 make-face により作成し、face の属性を設定する。                          
; 属性は set-face- という接頭辞を持つ関数により行う。                           
;                                                                               
;    (make-face '_user-face_xxxx_yyyy_zzzz)                                     
;    (set-face-foreground '_user-face_xxxx_yyyy_zzzz "#0000ff")                 
;    (set-face-background '_user-face_xxxx_yyyy_zzzz nil)                       
;    (set-face-bold-p '_user-face_xxxx_yyyy_zzzz t)                             
;    (set-face-italic-p '_user-face_xxxx_yyyy_zzzz nil)                         
;    (set-face-underline-p '_user-face_xxxx_yyyy_zzzz nil)                      
;                                                                               
; face 実体指定の変数                                                           
; 変数に face への symbol を設定します。                                        
;   (setq user-face_xxxx_yyyy_zzzz '_user-face_xxxx_yyyy_zzzz)                  
;                                                                               
;;------------------------------------------------------------------------------
;; user 側での prefix の取り決め（見やすいから・・）                            
; face 定義は _hoge-hoge  :: instance は hoge-hoge                              
; _xxxx :: mode name                                                            
; _yyyy :: target name                                                          
; _zzzz :: misc name (在れば)                                                   
;                                                                               
;;------------------------------------------------------------------------------

;;------------------------------------------------------------------------------
;;  font-lock-beginning-of-syntax-function
;;  font-lock-builtin-face
;; 主にプリプロセッサ
;;  font-lock-cache-position
;;  font-lock-cache-state
;;  font-lock-comment-face
;; コメント
;;  font-lock-constant-face
;; 定数＆ラベル
;;  font-lock-defaults
;;  font-lock-defaults-alist                 
;;  font-lock-doc-face
;;  font-lock-fontified                      
;;  font-lock-fontify-buffer-function
;;  font-lock-fontify-region-function        
;;  font-lock-function-name-face
;; 関数名、関数の定義部分だけ
;;  font-lock-global-modes                   
;;  font-lock-inhibit-thing-lock
;;  font-lock-keyword-face                   
;; switch, for, while, if, else.....& struct, typedef, enum
;;  font-lock-keywords
;;  font-lock-keywords-alist                 
;;  font-lock-keywords-case-fold-search
;;  font-lock-keywords-only                  
;;  font-lock-mark-block-function
;;  font-lock-maximum-decoration             
;;  font-lock-maximum-size
;;  font-lock-mode                           
;;  font-lock-mode-hook
;;  font-lock-multiline                      
;;  font-lock-reference-face
;;  font-lock-removed-keywords-alist         
;;  font-lock-set-defaults
;;  font-lock-string-face                    
;; ””で囲まれた文字列
;;  font-lock-support-mode
;;  font-lock-syntactic-face-function        
;;  font-lock-syntactic-keywords
;;  font-lock-syntactically-fontified        
;;  font-lock-syntax-table
;;  font-lock-type-face                      
;; variable, class, structure-name
;;  font-lock-unfontify-buffer-function
;;  font-lock-unfontify-region-function
;;  font-lock-variable-name-face             
;; variable-name
;; 宣言部のみ
;;  font-lock-verbose
;;  font-lock-warning-face
;;------------------------------------------------------------------------------


;;------------------------------------------------------------------------------
;; cc-mode :: builtin
;; 主に組み込み系
    (set-face-foreground 'font-lock-builtin-face ect-cc-mode-face-fgc-builtin)
    (set-face-background 'font-lock-builtin-face ect-cc-mode-face-bgc-builtin)
    (set-face-bold-p 'font-lock-builtin-face t)
    (set-face-italic-p 'font-lock-builtin-face nil)
    (set-face-underline-p 'font-lock-builtin-face nil)


;;------------------------------------------------------------------------------
;; cc-mode :: comment
;; コメント
    (set-face-foreground 'font-lock-comment-face ect-cc-mode-face-fgc-comment)
    (set-face-background 'font-lock-comment-face ect-cc-mode-face-bgc-comment)
;    (set-face-intangible-p 'font-lock-comment-face t)
    (set-face-bold-p 'font-lock-comment-face t)
    (set-face-italic-p 'font-lock-comment-face nil)
    (set-face-underline-p 'font-lock-comment-face nil)


;;------------------------------------------------------------------------------
;; cc-mode :: comment-delimiter
;; コメント区切り
    (set-face-foreground 'font-lock-comment-delimiter-face ect-cc-mode-face-fgc-comment-delimiter)
    (set-face-background 'font-lock-comment-delimiter-face ect-cc-mode-face-bgc-comment-delimiter)
;    (set-face-intangible-p 'font-lock-comment-delimiter-face t)
    (set-face-bold-p 'font-lock-comment-delimiter-face t)
    (set-face-italic-p 'font-lock-comment-delimiter-face nil)
    (set-face-underline-p 'font-lock-comment-delimiter-face nil)


;;------------------------------------------------------------------------------
;; cc-mode :: constant and label
;; 定数＆ラベル
    (set-face-foreground 'font-lock-constant-face ect-cc-mode-face-fgc-constant)
    (set-face-background 'font-lock-constant-face ect-cc-mode-face-bgc-constant)
    (set-face-bold-p 'font-lock-constant-face t)
    (set-face-italic-p 'font-lock-constant-face nil)
    (set-face-underline-p 'font-lock-constant-face nil)


;;------------------------------------------------------------------------------
;; cc-mode :: document
;; ドキュメント
    (set-face-foreground 'font-lock-doc-face ect-cc-mode-face-fgc-doc)
    (set-face-background 'font-lock-doc-face ect-cc-mode-face-bgc-doc)
    (set-face-bold-p 'font-lock-doc-face t)
    (set-face-italic-p 'font-lock-doc-face nil)
    (set-face-underline-p 'font-lock-doc-face nil)


;;------------------------------------------------------------------------------
;; cc-mode :: function-name
;; 関数名
;; 関数の定義部分だけ
    (set-face-foreground 'font-lock-function-name-face ect-cc-mode-face-fgc-function-name)
    (set-face-background 'font-lock-function-name-face ect-cc-mode-face-bgc-function-name)
    (set-face-bold-p 'font-lock-function-name-face t)
    (set-face-italic-p 'font-lock-function-name-face nil)
    (set-face-underline-p 'font-lock-function-name-face nil)


;;------------------------------------------------------------------------------
;; cc-mode :: keyword
;; switch, for, while, if, else.....& class, struct, typedef, enum
    (set-face-foreground 'font-lock-keyword-face ect-cc-mode-face-fgc-keyword)
    (set-face-background 'font-lock-keyword-face ect-cc-mode-face-bgc-keyword)
    (set-face-bold-p 'font-lock-keyword-face t)
    (set-face-italic-p 'font-lock-keyword-face nil)
    (set-face-underline-p 'font-lock-keyword-face nil)


;;------------------------------------------------------------------------------
;; cc-mode :: negation-char
;; ''で囲まれた文字
    (set-face-foreground 'font-lock-negation-char-face ect-cc-mode-face-fgc-negation-char)
    (set-face-background 'font-lock-negation-char-face ect-cc-mode-face-bgc-negation-char)
    (set-face-bold-p 'font-lock-negation-char-face t)
    (set-face-italic-p 'font-lock-negation-char-face nil)
    (set-face-underline-p 'font-lock-negation-char-face nil)


;;------------------------------------------------------------------------------
;; cc-mode :: preprocessor
;; 主にプリプロセッサ
    (set-face-foreground 'font-lock-preprocessor-face ect-cc-mode-face-fgc-preprocessor)
    (set-face-background 'font-lock-preprocessor-face ect-cc-mode-face-bgc-preprocessor)
    (set-face-bold-p 'font-lock-preprocessor-face t)
    (set-face-italic-p 'font-lock-preprocessor-face nil)
    (set-face-underline-p 'font-lock-preprocessor-face nil)


;;------------------------------------------------------------------------------
;; cc-mode :: regexp-grouping-construct
;; 正規表現
    (set-face-foreground 'font-lock-regexp-grouping-construct ect-cc-mode-face-fgc-regexp-grouping-construct)
    (set-face-background 'font-lock-regexp-grouping-construct ect-cc-mode-face-bgc-regexp-grouping-construct)
    (set-face-bold-p 'font-lock-regexp-grouping-construct t)
    (set-face-italic-p 'font-lock-regexp-grouping-construct nil)
    (set-face-underline-p 'font-lock-regexp-grouping-construct nil)


;;------------------------------------------------------------------------------
;; cc-mode :: regexp-grouping-backslash
;; 正規表現バックスラッシュ
    (set-face-foreground 'font-lock-regexp-grouping-backslash ect-cc-mode-face-fgc-regexp-grouping-backslash)
    (set-face-background 'font-lock-regexp-grouping-backslash ect-cc-mode-face-bgc-regexp-grouping-backslash)
    (set-face-bold-p 'font-lock-regexp-grouping-backslash t)
    (set-face-italic-p 'font-lock-regexp-grouping-backslash nil)
    (set-face-underline-p 'font-lock-regexp-grouping-backslash nil)


;;------------------------------------------------------------------------------
;; cc-mode :: string
;; ””で囲まれた文字列
    (set-face-foreground 'font-lock-string-face ect-cc-mode-face-fgc-string)
    (set-face-background 'font-lock-string-face ect-cc-mode-face-bgc-string)
    (set-face-bold-p 'font-lock-string-face t)
    (set-face-italic-p 'font-lock-string-face nil)
    (set-face-underline-p 'font-lock-string-face nil)


;;------------------------------------------------------------------------------
;; cc-mode :: type and class-names and struct-names
;; type-name, class-name, structure-name
    (set-face-foreground 'font-lock-type-face ect-cc-mode-face-fgc-type)
    (set-face-background 'font-lock-type-face ect-cc-mode-face-bgc-type)
    (set-face-bold-p 'font-lock-type-face t)
    (set-face-italic-p 'font-lock-type-face nil)
    (set-face-underline-p 'font-lock-type-face nil)


;;------------------------------------------------------------------------------
;; cc-mode :: variable-name
;; variable-name
;; 宣言部のみ
    (set-face-foreground 'font-lock-variable-name-face ect-cc-mode-face-fgc-variable-name)
    (set-face-background 'font-lock-variable-name-face ect-cc-mode-face-bgc-variable-name)
    (set-face-bold-p 'font-lock-variable-name-face nil)
    (set-face-italic-p 'font-lock-variable-name-face nil)
    (set-face-underline-p 'font-lock-variable-name-face nil)


;;------------------------------------------------------------------------------
;; cc-mode :: warning??
;; いまのところ不明
;    (set-face-foreground 'font-lock-warning-face ect-cc-mode-face-fgc-warning)
;    (set-face-background 'font-lock-warning-face ect-cc-mode-face-bgc-warning)
;    (set-face-bold-p 'font-lock-warning-face nil)
;    (set-face-italic-p 'font-lock-warning-face nil)
;    (set-face-underline-p 'font-lock-warning-face nil)


)




;;------------------------------------------------------------------------------
;; Theme Loader
(defun ect-load (theme-file-path)
  (interactive
   (list (read-file-name "Theme File :" path-themes nil t))
   )

  (message "[Emacs Color Theme]")
  (if (stringp (locate-library theme-file-path))
      (progn
	(load-library theme-file-path)

	(ect-general-face-setup)

;; 汎用以外は各add-hookで反映
 	(ect-cc-mode-face-setup)


	(message "  Active : %s" emacs-color-theme-name)
	)
    (progn
	(message "  Theme File Not Found : %s" theme-file-path)
      )
    )
  )






(provide 'emacs-color-theme)
;;------------------------------------------------------------------------------
;; EOF
