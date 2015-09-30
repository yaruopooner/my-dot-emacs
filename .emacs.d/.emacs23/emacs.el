;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/09/04.04:48:10


;;==============================================================================
;; .emacs (Emacs & Meadow)                                                      
;;==============================================================================



;;==============================================================================
;; Environment Path Variable                                                    
;;==============================================================================


;; ---- relative paths ---- 

;; Preferences ディレクトリ名
(defconst rpath-preferences "preferences/")
;; User Preferences  : Basic Configuration File の置いてある ($DOT_EMACS)/preferences からの相対パス
(defconst rpath-basic-configuration "basic/")
;; User Preferences  : Library Configuration File の置いてある ($DOT_EMACS)/preferences からの相対パス
(defconst rpath-library-configuration "library/")
;; User Color Theme  : color theme file の置いてある ($DOT_EMACS)/preferences からの相対パス
(defconst rpath-themes "themes/")
;; Emacs Plugin & Plugin Setup  : ($DOT_EMACS)/ からの相対パス
(defconst rpath-plugins "plugins/")



;; ---- absolute paths ---- 
(defconst path-preferences           (expand-file-name rpath-preferences            de:path-dot-emacs))
(defconst path-basic-configuration   (expand-file-name rpath-basic-configuration    path-preferences))
(defconst path-library-configuration (expand-file-name rpath-library-configuration  path-preferences))
(defconst path-themes                (expand-file-name rpath-themes                 path-preferences))
(defconst path-plugins               (expand-file-name rpath-plugins                de:path-dot-emacs))




;;==============================================================================
;; load-path addition                                                           
;;==============================================================================


(add-to-list 'load-path path-preferences)
(add-to-list 'load-path path-plugins)




;;==============================================================================
;; Common Lisp Load
;;==============================================================================


(eval-when-compile (require 'cl))



;;------------------------------------------------------------------------------
;; Utilitiy Load (for dot emacs functions)
;;------------------------------------------------------------------------------


(de:auto-byte-compile (expand-file-name "dot-emacs-utility.el" de:path-dot-emacs))
(require 'dot-emacs-utility)



;; 自動バイトコンパイル
;(deu:auto-byte-compile-recursive de:path-dot-emacs)
(deu:auto-byte-compile-recursive path-preferences)
(deu:auto-byte-compile-plugins path-plugins)



;;==============================================================================
;; Emacs Color Theme                                                            
;;==============================================================================


;; theme ファイルを設定
;(defvar ect-file-path "default-color-theme_bg-white")
(defvar ect-file-path "default-color-theme_bg-black")
;; ユーザーカラーテーマを作る場合は上記ファイルをコピーしてリネーム
;; デフォルトテーマを無効化して下記を有効にする
;(defvar ect-file-path "usr-color-theme_bg-black")



;;==============================================================================
;; Emacs Internal Preferences Load : Basic Configuration                        
;;==============================================================================


(let (basic-config-files-list)
;; Load File List
    (setq basic-config-files-list (list 
			       "device.config"              ;; Device (Mouse, Keyboard)
			       "key-binding.config"         ;; Key Binding

			       "misc.config"                ;; Miscellaneous (各種設定)
			       "frame.config"               ;; Frame

			       "coding-system.config"       ;; Coding System
			       "font.config"                ;; Font
			       "ime.config"                 ;; IME

			       "shell.config"               ;; Shell Command Options
			       "vc.config"                  ;; Version Controll
			       
			       "basic-config-finalize"      ;; 一連の config 群の最後でないと実行できない要素があればここで設定
			       )
	  )

;; Load Execution
    (deu:load-libraries basic-config-files-list path-basic-configuration)
)



;;==============================================================================
;; Emacs Internal Preferences Load : Library Configuration                  
;;==============================================================================


(let (library-config-files-list)
;; Load File List
    (setq library-config-files-list (list 
			       "font-lock.config"           ;; Font-Lock & Emacs Color Theme Face Setup

			       "ibuffer.config"             ;; buffer の拡張版
			       "linum.config"               ;; ライン行数表示
			       "whitespace.config"          ;; 空白表示

			       "cc-mode.config"             ;; C/C++/Java Mode
			       "cedet.config"               ;; Collection of Emacs Development Environment Tools
			       "flymake.config"             ;; flymake

			       "suffixes.config"            ;; Suffixes Connection
			       "autoinsert.config"          ;; Auto Insert (Source Template File Insert)
;			       "scratch.config"             ;; *scratch* auto backup & auto restore
			       "org-mode.config"            ;; org-mode
			       "misc.config"                ;; その他ライブラリ

			       "library-config-finalize"    ;; 一連の config 群の最後でないと実行できない要素があればここで設定
			       )
	  )

;; Load Execution
    (deu:load-libraries library-config-files-list path-library-configuration)
)



;;==============================================================================
;; Emacs Plugins Load : Plugins Configuration & Load                              
;;==============================================================================


(let (plugin-setup-files-list)
;; Load File List
    (setq plugin-setup-files-list (list 
;			       "setup.browse-yank"      ;; yank拡張版
			       "setup.moccurs"          ;; color-moccur/moccur-edit
			       "setup.grep-exts"        ;; grep-a-lot/grep-edit
			       "setup.anything"         ;; 統合インターフェース

			       "setup.session"          ;; mini-buffer/kill-ring history復元
			       "setup.scratch-ext"      ;; *scratch* auto backup & auto restore
;			       "setup.revive"           ;; バッファ復元

			       "setup.auto-complete"    ;; 単語補完
			       "setup.hideshowvis"      ;; hideshow拡張版
			       "setup.navi"             ;; 関数プロトタイプナビゲーター
			       "setup.gtags"            ;; gtags

;			       "setup.cedet"            ;; Collection of Emacs Development Environment Tools
;			       "setup.ecb"              ;; Emacs Code Browser

;			       "setup.google-c-style"   ;; google-c-style
			       "setup.lua-mode"         ;; lua Mode
			       "setup.csharp-mode"      ;; C# Mode

			       "setup.emacs-wiki"       ;; emacs wiki
			       "setup.dsvn"             ;; Subversion

;			       "setup.tabbar"           ;; バッファのタブ化

			       "setup.auctex"           ;; AUCTeX
			       "setup.search-web"       ;; Webを利用した検索機能
			       "setup.text-translator"  ;; Webを利用したテキスト翻訳機能
			       "setup.pdf-preview"      ;; PDF出力機能

			       "require.miscs"          ;; recentf-ext/summarye/CSV Mode/menu-tree(emacs GUI Menu の日本語化)/

			       "setup.cygwin-mount"     ;; cygwin使用時のパス問題解決

;			       "setup.auto-install"     ;; 自動インストーラー(anythingに依存関係があるらしいので最後にセットアップ)

;			       "setup.twittering-mode"  ;; twitter
;			       "setup.skype"            ;; skype(linux only)

			       "setup.powerline"        ;; mode-line color & style extension
			       "setup.color-theme"      ;; color-theme

			       "emacs-plugin-finalize"  ;; 一連の plugin 群の最後でないと実行できない要素があればここで設定
			       )
	  )

;; Load Execution
    (deu:load-libraries plugin-setup-files-list)
)



;;==============================================================================
;; Emacs Internal Preferences Load : Library Configuration                      
;;==============================================================================


(let (emacs-platform-dependency-library-files-list)
  ;; Load File List
    (setq emacs-platform-dependency-library-files-list (list 
				    ;; Win32 only Library
				    `(windows-nt ,@(list
					     "uenox-dired"              ;; dired mode ext
					     "uenox-ps-print"           ;; printer
					     )
					  )
				    ;; Linux only Library
				    `(gnu/linux ,@(list
					   )
					)
				    `(ns nil)
				    `(nil nil)
				    )
     )

;; Load Execution
    (deu:load-libraries-auto-select-platform-list emacs-platform-dependency-library-files-list)
)



;;==============================================================================
;; Emacs server
;;==============================================================================


;(server-start)



;; EOF
