;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2020/09/02.21:43:13


;;==============================================================================
;; .emacs (Emacs & Meadow)                                                      
;;==============================================================================



;;==============================================================================
;; Environment Path Variable                                                    
;;==============================================================================


;; ---- relative paths ---- 

;; Replace Built-in  : ($DOT_EMACS)/ からの相対パス
(defconst de:rpath-replace-builtins "replace-builtins/")
;; Preferences ディレクトリ名
(defconst de:rpath-preferences "preferences/")
;; User Preferences  : Basic Configuration File の置いてある ($DOT_EMACS)/preferences からの相対パス
(defconst de:rpath-basic-configuration "basic/")
;; User Preferences  : Built-in Configuration File の置いてある ($DOT_EMACS)/preferences からの相対パス
(defconst de:rpath-builtin-configuration "builtin/")
(defconst de:rpath-package-configuration "package/")
;; Emacs Plug-in & Plug-in Setup  : ($DOT_EMACS)/ からの相対パス
(defconst de:rpath-packages "packages/")



;; ---- absolute paths ---- 
(defconst de:path-replace-builtins      (expand-file-name de:rpath-replace-builtins       de:path-dot-emacs))
(defconst de:path-preferences           (expand-file-name de:rpath-preferences            de:path-dot-emacs))
(defconst de:path-basic-configuration   (expand-file-name de:rpath-basic-configuration    de:path-preferences))
(defconst de:path-builtin-configuration (expand-file-name de:rpath-builtin-configuration  de:path-preferences))
(defconst de:path-package-configuration (expand-file-name de:rpath-package-configuration  de:path-preferences))
(defconst de:path-packages              (expand-file-name de:rpath-packages               de:path-dot-emacs))




;;==============================================================================
;; load-path addition                                                           
;;==============================================================================


;; (add-to-list 'load-path de:path-replace-builtins)
;; (add-to-list 'load-path de:path-preferences)
;; (add-to-list 'load-path de:path-packages)



;;==============================================================================
;; Common Lisp Load
;;==============================================================================


;;------------------------------------------------------------------------------
;; Utilitiy Load (for dot emacs functions)
;;------------------------------------------------------------------------------


(de:auto-byte-compile (expand-file-name "dot-emacs-utility.el" de:path-dot-emacs))
(require 'dot-emacs-utility)


(deu:add-to-path-list-directory-recursive 'load-path de:path-dot-emacs)



;;==============================================================================
;; Emacs Built-ins Replace                                                      
;;==============================================================================


;; Load File List
(defconst de:replace-builtins-files-list '(
                       ;; "replace.cedet"         ;; Collection of Emacs Development Environment Tools(v1.1)
                       ))



;;==============================================================================
;; Emacs Internal Preferences Load : Basic Configuration                        
;;==============================================================================


;; Load File List
(defconst de:basic-config-files-list '(
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
                    ))



;;==============================================================================
;; Emacs Internal Preferences Load : Built-in Configuration                  
;;==============================================================================


;; Load File List
(defconst de:builtin-config-files-list '(
                      "font-lock.config"           ;; Font Lock Mode
                      "linum.config"               ;; ライン行数表示
                      "whitespace.config"          ;; 空白表示

                      "dired.config"               ;; dired
                      "ibuffer.config"             ;; buffer

                      "emacs-lisp-mode.config"     ;; Emacs Lisp Mode
                      "cc-mode.config"             ;; C/C++/Java Mode
                      "js-mode.config"             ;; Java Script Mode
                      "shell-script-mode.config"   ;; shell script Mode(sh/bat/ps1)
                      "align.config"               ;; text alignment
                      "cedet.config"               ;; Collection of Emacs Development Environment Tools
                      "flymake.config"             ;; flymake
                      "cedet+flymake"              ;; CEDET + flymake

                      "suffixes.config"            ;; suffixes connection
                      "autoinsert.config"          ;; auto insert (source template-file insert)
                      ;; "scratch.config"             ;; *scratch* auto backup & auto restore
                      "org-mode.config"            ;; Org Mode
                      "misc.config"                ;; その他ライブラリ
                      ;; "package.config"             ;; package install manager

                      "theme.config"               ;; Theme

                      "builtin-config-finalize"    ;; 一連の config 群の最後でないと実行できない要素があればここで設定
                      ))



;;==============================================================================
;; Emacs Plug-ins Load : Plug-ins Configuration                                   
;;==============================================================================


(defconst de:package-list '(
;;                            cygwin-mount  ;melpa
                            auto-complete ;melpa
                            pos-tip       ;melpa
                            fuzzy         ;melpa
                            ;; anything      ;melpa
                            ;; descbinds-anything ;marmalade
                            helm               ;melpa
                            helm-descbinds     ;melpa
                            helm-swoop         ;melpa
                            helm-ls-git        ;melpa
                            helm-c-yasnippet   ;melpa
                            helm-gtags         ;melpa
                            ;; helm-migemo        ;melpa
                            epl                ;melpa
                            ;; crosshairs ;melpa
                            powerline   ;melpa
                            ;; tabbar      ;melpa
                            scratch-ext ;melpa
                            recentf-ext ;melpa
                            session     ;melpa
                            ;; psession ;melpa
                            ;; revive      ;melpa
                            all-ext     ;melpa
                            grep-a-lot  ;melpa
                            wgrep       ;melpa
                            color-moccur ;melpa
                            ;; visual-regexp ;melpa
                            ;; imenu+ ;melpa
;;                            hideshowvis ;melpa
                            yasnippet   ;melpa
                            yasnippet-snippets   ;melpa
;;                            dropdown-list ;melpa
                            clang-format  ;melpa
                            ;; ggtags ;melpa
                            dsvn ;melpa
                            powershell ;melpa
                            lua-mode   ;melpa
                            csv-mode    ;gnu
                            bison-mode  ;melpa
                            ;; google-c-style ;melpa
                            ;; summarye       ;melpa
                            fold-dwim      ;melpa
                            flymake-lua    ;melpa
                            ;; disk ;melpa
                            search-web ;melpa
                            ;; auto-install ;melpa
                            magit ;melpa
                            ;; ac-clang  ;melpa
                            ;; msvc  ;melpa
                            csharp-mode  ;melpa
                            omnisharp   ;melpa
                            cmake-mode  ;melpa
                            google-translate ;melpa
                            p4 ; melpa
                            js2-mode ; melpa
                            flymake-jshint ; melpa
                            buttercup ; melpa
                            flycheck ; melpa
                            powershell ; melpa
                            ;; tern ; melpa
                            ;; tern-auto-complete ; melpa
                            ))


;; Load File List
(defconst de:package-setup-files-list '(
                    ;; "setup.browse-yank"      ;; yank拡張版
                    "setup.moccurs"          ;; color-moccur/moccur-edit
                    "setup.grep-exts"        ;; grep-a-lot/wgrep
                    ;; "setup.anything"         ;; 統合インターフェース
                    "setup.helm"             ;; 統合インターフェース

                    "setup.session"          ;; mini-buffer/kill-ring history復元
                    "setup.scratch-ext"      ;; *scratch* auto backup & auto restore
                    ;; "setup.revive"           ;; バッファ復元

                    "setup.auto-complete"    ;; 単語補完
                    ;; "setup.popwin"           ;; popwin
                    "setup.ac-clang"         ;; C/C++ source code completion by clang
                    "setup.clang-format"     ;; C/C++ source code format by clang
                    "setup.yasnippet"        ;; snippet
                    "setup.hideshowvis"      ;; hideshow拡張版
                    ;; "setup.navi"             ;; 関数プロトタイプナビゲーター
                    "setup.helm-gtags"       ;; helm-gtags
                    ;; "setup.gtags"            ;; gtags

                    "setup.msvc"             ;; Microsoft Visual C++ mode

                    ;; "setup.cedet"            ;; Collection of Emacs Development Environment Tools
                    ;; "setup.ecb"              ;; Emacs Code Browser

                    ;; "setup.google-c-style"   ;; google-c-style
                    "setup.lua-mode"         ;; lua Mode
                    ;; "setup.csharp-mode"      ;; C# Mode
                    ;; "setup.omnisharp"        ;; C# Mode

                    "setup.js2-mode"         ;; java scriptMode

                    ;; "setup.emacs-wiki"       ;; emacs wiki
                    "setup.dsvn"             ;; Subversion

                    ;; "setup.cask"             ;; cask

                    ;; "setup.tabbar"           ;; バッファのタブ化

                    ;; "setup.helm-migemo"       ;; helm-migemo
                    ;; "setup.auctex"           ;; AUCTeX
                    "setup.search-web"       ;; Webを利用した検索機能
                    ;; "setup.text-translator"  ;; Webを利用したテキスト翻訳機能
                    "setup.google-translate" ;; google translateを利用したテキスト翻訳機能
                    "setup.pdf-preview"      ;; PDF出力機能

                    "require.miscs"          ;; recentf-ext/imenu+/summarye/CSV Mode/menu-tree(emacs GUI Menu の日本語化)/yspel

                    "setup.cygwin"           ;; cygwin 関係, cygwin-mount:使用時のパス問題解決

                    ;; "setup.auto-install"     ;; 自動インストーラー(anythingに依存関係があるらしいので最後にセットアップ)

                    ;; "setup.twittering-mode"  ;; twitter
                    ;; "setup.skype"            ;; skype(linux only)
                    ;; "setup.mew"              ;; mew

                    "setup.powerline"        ;; mode-line color & style extension

                    ;; "msbuild-parser"         ;; MSBuild Parser

                    "emacs-package-finalize"  ;; 一連の package 群の最後でないと実行できない要素があればここで設定
                    ))



;;==============================================================================
;; Emacs Platform Dependency Plug-ins Load : Plug-ins Configuration             
;;==============================================================================


;; Load File List
(defconst de:emacs-platform-dependency-package-files-list '(
                             ;; Win32 only Library
                             (windows-nt (
                                      "uenox-dired"              ;; dired mode ext
                                      "uenox-ps-print"           ;; printer
                                      ))
                             ;; Linux only Library
                             (gnu/linux (
                                     ))
                             (ns nil)
                             (nil nil)
                             ))



;;==============================================================================
;; auto byte-compile
;;==============================================================================

;; (eval-after-load "gnutls" '(setq gnutls-trustfiles (mapcar 'expand-file-name gnutls-trustfiles)))

(load-library "package.config")
(deu:package-install de:package-list)

;; (deu:auto-byte-compile-recursive de:path-dot-emacs)
;; (deu:auto-byte-compile-recursive de:path-preferences)
;; (deu:auto-byte-compile-packages `(,de:path-packages ,de:path-packages))
;; (deu:auto-byte-compile-packages `(,de:path-packages))
(deu:auto-byte-compile-recursive de:path-dot-emacs)


;;==============================================================================
;; load execution
;;==============================================================================


(deu:load-libraries de:replace-builtins-files-list de:path-replace-builtins)
(deu:load-libraries de:basic-config-files-list de:path-basic-configuration)
(deu:load-libraries de:builtin-config-files-list de:path-builtin-configuration)


(deu:load-libraries de:package-setup-files-list)
(deu:load-libraries-auto-select-platform-list de:emacs-platform-dependency-package-files-list)




;;==============================================================================
;; Emacs server
;;==============================================================================


;; (server-start)



;; EOF
