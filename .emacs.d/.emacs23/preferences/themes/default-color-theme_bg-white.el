;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/04/16.16:56:21


;;==============================================================================
;; Emacs Default Color Customize                                                
;;==============================================================================


;; カスタマイズテーマ名
(setq emacs-color-theme-name "BG-BaseColor-White")


;;==============================================================================
;; User Color Condition                                                         
;; Frame Background カラーはホワイト系であることが前提の設定                    
;;==============================================================================

;; ect- == Emacs Color Theme 
;; fgc- == Foreground Color
;; bgc- == Background Color

;;------------------------------------------------------------------------------


;; フレーム環境用カラー変数セット


;; アクティブウィンドウ透明度
(setq ect-frame-semi-transparency-active-window                 1.0)
;; 非アクティブウィンドウ透明度
(setq ect-frame-semi-transparency-inactive-window               0.8)

;; フレームカラー
(setq ect-frame-face-foreground-color                           "#000000")
(setq ect-frame-face-background-color                           "#fffff0")

;; ノーマルカーソルカラー
(setq ect-frame-face-cursor-color                               "black")
;; マウスカーソル表示色
(setq ect-frame-face-mouse-color                                "mediumpurple")
;; 選択しているフレームの境界色
(setq ect-frame-face-border-color                               "#ff0000")

;; IME On/Off の時のカーソルカラー
(setq ect-frame-face-cursor-color-ime-on                        "blue")
(setq ect-frame-face-cursor-color-ime-off                       "black")

;; モードライン
(setq ect-frame-face-fgc-modeline                               "white")
(setq ect-frame-face-bgc-modeline                               "black")

;; モードライン（アクティブでないバッファ）
(setq ect-frame-face-fgc-mode-line-inactive                     "white")
(setq ect-frame-face-bgc-mode-line-inactive                     "black")

;; 選択範囲
(setq ect-general-face-fgc-region                               nil)
(setq ect-general-face-bgc-region                               "gray")

;; dired-mode:ディレクトリカラー
(setq ect-dired-face-fgc-directory                              "DeepSkyBlue1")
(setq ect-dired-face-bgc-directory                              nil)



;; CC-Mode Face Color Change

;; 組み込み系
(setq ect-cc-mode-face-fgc-builtin                              nil)
(setq ect-cc-mode-face-bgc-builtin                              nil)

;; コメント
(setq ect-cc-mode-face-fgc-comment                              "#000000")
(setq ect-cc-mode-face-bgc-comment                              "#c0c0c0")

;; コメント区切り
(setq ect-cc-mode-face-fgc-comment-delimiter                    "#000000")
(setq ect-cc-mode-face-bgc-comment-delimiter                    "#c0c0c0")

;; 定数＆ラベル
(setq ect-cc-mode-face-fgc-constant                             "#008000")
(setq ect-cc-mode-face-bgc-constant                             nil)

;; ドキュメント
(setq ect-cc-mode-face-fgc-doc                                  nil)
(setq ect-cc-mode-face-bgc-doc                                  nil)

;; 関数定義部分
(setq ect-cc-mode-face-fgc-function-name                        "#000000")
(setq ect-cc-mode-face-bgc-function-name                        nil)

;; 制御文＆識別子＆指定子＆型修飾子＆記憶クラス指定子
(setq ect-cc-mode-face-fgc-keyword                              "#8080ff")
(setq ect-cc-mode-face-bgc-keyword                              nil)

;; 文字
(setq ect-cc-mode-face-fgc-negation-char                        "#800000")
(setq ect-cc-mode-face-bgc-negation-char                        nil)

;; プリプロセッサ
(setq ect-cc-mode-face-fgc-preprocessor                         nil)
(setq ect-cc-mode-face-bgc-preprocessor                         nil)

;; 正規表現
(setq ect-cc-mode-face-fgc-regexp-grouping-construct            "#800000")
(setq ect-cc-mode-face-bgc-regexp-grouping-construct            nil)

;; 正規表現バックスラッシュ
(setq ect-cc-mode-face-fgc-regexp-grouping-backslash            nil)
(setq ect-cc-mode-face-bgc-regexp-grouping-backslash            nil)

;; 文字列
(setq ect-cc-mode-face-fgc-string                               "#800000")
(setq ect-cc-mode-face-bgc-string                               nil)

;; 型指定子＆構造体宣言部＆クラス
(setq ect-cc-mode-face-fgc-type                                 "#0000ff")
(setq ect-cc-mode-face-bgc-type                                 nil)

;; 変数名宣言部
(setq ect-cc-mode-face-fgc-variable-name                        nil)
(setq ect-cc-mode-face-bgc-variable-name                        nil)

;; 警告
(setq ect-cc-mode-face-fgc-warning                              nil)
(setq ect-cc-mode-face-bgc-warning                              nil)


;; User Face Color Set

;; クラス
(setq ect-face-fgc-cc-mode_class                                "#00ffff")
(setq ect-face-bgc-cc-mode_class                                nil)

;; コメント
(setq ect-face-fgc-cc-mode_comment                              "#ff0000")
(setq ect-face-bgc-cc-mode_comment                              "#c0c0c0")

;; プリプロセッサ
(setq ect-face-fgc-cc-mode_preprocessor                         "#008000")
(setq ect-face-bgc-cc-mode_preprocessor                         nil)

;; コンディションレジスタ
(setq ect-face-fgc-cc-mode_register_condition                   "#00ffff")
(setq ect-face-bgc-cc-mode_register_condition                   nil)

;; 浮動小数レジスタ
(setq ect-face-fgc-cc-mode_register_float                       "#00ffff")
(setq ect-face-bgc-cc-mode_register_float                       nil)

;; 整数レジスタ
(setq ect-face-fgc-cc-mode_register_int                         "#00ffff")
(setq ect-face-bgc-cc-mode_register_int                         nil)

;; スペシャルレジスタ
(setq ect-face-fgc-cc-mode_register_special                     "#00ffff")
(setq ect-face-bgc-cc-mode_register_special                     nil)

;; 識別子＆型定義指定子＆型修飾子＆記憶クラス指定子
(setq ect-face-fgc-cc-mode_structure                            "#8080ff")
(setq ect-face-bgc-cc-mode_structure                            nil)

;; 型指定子
(setq ect-face-fgc-cc-mode_variable                             "#0000ff")
(setq ect-face-bgc-cc-mode_variable                             nil)


;; 識別子
(setq ect-face-fgc-cc-mode_type-identifier                      nil)
(setq ect-face-bgc-cc-mode_type-identifier                      nil)

;; （記憶クラス|構造体|共用体|列挙型）指定子
(setq ect-face-fgc-cc-mode_type-specifier-0                     "#8080ff")
(setq ect-face-bgc-cc-mode_type-specifier-0                     nil)

;; （型指定|型修飾）子
(setq ect-face-fgc-cc-mode_type-specifier-1                     "#0000ff")
(setq ect-face-bgc-cc-mode_type-specifier-1                     nil)

;; 型修飾子
(setq ect-face-fgc-cc-mode_type-qualifier                       "#8080ff")
(setq ect-face-bgc-cc-mode_type-qualifier                       nil)






(provide 'default-color-theme_bg-white)
;;==============================================================================
;; EOF
