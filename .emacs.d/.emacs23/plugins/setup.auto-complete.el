;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/08/30.16:46:16


;;==================================================================================================
;; auto-complete setup                                                                                      
;;==================================================================================================


;;------------------------------------------------------------------------------
;; prepare variable setting                                                           
;;------------------------------------------------------------------------------


;; load path addition
(add-to-list 'load-path (expand-file-name "auto-complete/" path-plugins))




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


;; Load Module
(require 'auto-complete-config)




;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; function call
(ac-config-default)


;; 補完機能手動呼び出しキーバインド
(global-unset-key (kbd "M-\\"))
(ac-set-trigger-key "M-\\")


;; 補完開始有効文字数：指定文字数以上で補完が作動, nilで作動しない
(setq ac-auto-start nil)


;; 補完可能になるまでの遅延時間(sec)
(setq ac-delay 0.1)

;; 補完メニュー表示開始までの時間(sec)：nilで表示なし
(setq ac-auto-show-menu 0.8)

;; 補完メニュー表示時のみC-n/C-pで補完候補を選択する
(setq ac-use-menu-map t)

;; 補完中に1秒ほど待ったときに出てくるツールチップヘルプ on/off
(setq ac-use-quick-help t)

;; 補完メニューの高さ行数：一度に表示される補完対象数
(setq ac-menu-height 20)

;; 大文字・小文字を区別： t :しない, nil :する, 'smart :補完対象に大文字が含まれる場合のみ区別する
(setq ac-ignore-case 'nil)


;; face-name
;; ac-completion-face 	インライン補完の文字色
;; ac-candidate-face 	補完メニューの背景色
;; ac-selection-face 	補完メニューの選択色

;; インライン補完の文字色
(set-face-foreground 'ac-completion-face "darkgray")
;(set-face-background 'ac-completion-face "lightgray")
(set-face-underline-p 'ac-completion-face "white")

;; 補完メニューの背景色
(set-face-foreground 'ac-candidate-face "black")
(set-face-background 'ac-candidate-face "lightgray")
;(set-face-underline-p 'ac-candidate-face "black")

;; 補完メニューの選択色
(set-face-foreground 'ac-selection-face "white")
(set-face-background 'ac-selection-face "lightgray")
;(set-face-underline-p 'ac-selection-face "black")


;; hook
;(add-hook 'c-mode-common-hook, )



;;------------------------------------------------------------------------------
;; auto complete behavior setting                                               
;;------------------------------------------------------------------------------


;; 標準的な情報源の名前と説明を列挙します。それぞれ利用したいものをピックアップしてac-sourcesに設定してください。
;;
;; | 名前                                  | 説明                                                             
;; |———————————————————————————————————————+——————————————————————————————————————————————————————————————————
;; | ac-source-dictionary                  | メジャーモード辞書・拡張子辞書                                       
;; | ac-source-words-in-buffer             | 現在のバッファ内の単語を補完                                         
;; | ac-source-words-in-all-buffer         | 全てのバッファ内の単語を補完                                         
;; | ac-source-words-in-same-mode-buffers  | 同じメジャーモードのバッファ内の単語を補完。プログラミングに便利          
;; | ac-source-filename                    | ファイル名補完                                                     
;; | ac-source-semantic                    | CEDET::Semanticのための情報源です。C/C++でメンバー名補完として利用      
;; | ac-source-semantic-raw                | ac-source-semantic と違って、この情報源は生の名前空間でシンボルを補完するのに使います
;; | ac-source-gtags                       | gtagsの補完(defaultで組み込まれている)                               
;; | ac-source-symbols                     | Lispのシンボルを補完。Emacs Lispを書く人向け                         
;; | ac-source-abbrev                      | abbrevを補完                                                      
;; | ac-source-imenu                       | imenuの補完                                                       
;; | ac-source-yasnippet                   | yasnippetの補完                                                   
;;


;; C/C++ Mode 時の補完ソース拡張
(add-hook 'c-mode-common-hook '(lambda ()
				 (setq ac-sources '(
						    ac-source-dictionary
						    ac-source-semantic-raw
						    ac-source-semantic
						    ac-source-words-in-buffer
						    ac-source-words-in-same-mode-buffers
						    )
				       )
				 )
	  )




;; 補完開始キーワードマッチングの修正
;; 従来は dot(.), arrow(->)のみだったのので scope(::)を追加

;; 補完対象のユーザー定義マッチング関数
(defun ac-prefix-c-dot-ref-scope ()
  "C-like languages dot(.) and reference(->) and scope(::) prefix."
  (if (re-search-backward "\\(?:\\.\\|->\\|::\\)\\(\\(?:[a-zA-Z0-9][_a-zA-Z0-9]*\\)?\\)\\=" nil t)
      (match-beginning 1)))

;; 関連リストの標準関数をユーザー定義のマッチング関数で置換
(setcdr (assq 'c-dot-ref ac-prefix-definitions) 'ac-prefix-c-dot-ref-scope)
;; (defadvice ac-prefix-c-dot-ref (around ac-prefix-c-dot-ref-scope-replace () activate)
;;   (setq ad-return-value (ac-prefix-c-dot-ref-scope))
;;  )





(provide 'setup.auto-complete)
;;--------------------------------------------------------------------------------------------------
;; EOF
