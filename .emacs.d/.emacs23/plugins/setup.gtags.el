;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/06/14.16:29:32


;;==================================================================================================
;; gtags setup                                                                                      
;;==================================================================================================




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


(autoload 'gtags-mode "gtags" "" t)




;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; ver6.0からcase-fold-search 変数に従った挙動をするようになった
;; case-fold-search が t の時は、globalコマンドの引数に i が追加される
;; nil の場合は完全一致のみ合致
;; インクリメンタルサーチ全般設定は /basic/misc.config.el で行われているのでプラグイン側で再設定はしない。
;; gtagsと通常インクリメンタルサーチ設定は分離したいので以下のように修正


;; 完全一致
(defvar gtags-case-fold-search nil)
;; 大文字小文字無視
;(defvar gtags-case-fold-search case-fold-search)


(defmacro make-gtags-caller (func)
  (let ((name (make-symbol (concat (symbol-name func) "-custom"))))
    `(defadvice ,func (around ,name activate)
       (let ((case-fold-search gtags-case-fold-search))
	 ad-do-it
	 )
       )
    )
  )
  

(make-gtags-caller gtags-find-tag)
(make-gtags-caller gtags-find-rtag)
(make-gtags-caller gtags-find-symbol)




;; local key bind
(setq gtags-mode-hook
      '(lambda ()
	 ;; 指定したクラスorメソッドが定義されている部分を探す
         (local-set-key (kbd "M-t") 'gtags-find-tag)

	 ;; 指定したクラスorメソッドが参照されている場所を探す
         (local-set-key (kbd "M-r") 'gtags-find-rtag)

	 ;; 指定した変数名が使用されている部分を探す
         (local-set-key (kbd "M-s") 'gtags-find-symbol)

	 ;; gtagsでジャンプする一つ前の状態に戻る
         (local-set-key (kbd "C-t") 'gtags-pop-stack)
         )
      )



;; cc-mode起動時にフック
(add-hook 'c-mode-common-hook
          '(lambda ()
	     ;; gtags自動有効化
             (gtags-mode 1)

	     ;; 補完機能ON
;             (gtags-make-complete-list)

	     ;; 複数候補時のジャンプ用バッファ生成は１つのみ
	     (setq gtags-select-buffer-single t)

	     ;; ジャンプ先パススタイル
	     (setq gtags-path-style 'relative)

	     ;; gtagsキーマップ有効化(これを有効にしないとキーバインドされない)
	     (setq gtags-suggested-key-mapping t)

	     ;; GLOBAL-6.0 released でキーバインドが変更になった、旧版利用時はこちら
;	     (setq gtags-use-old-key-map t)
             )
	  )





(provide 'setup.gtags)
;;--------------------------------------------------------------------------------------------------
;; EOF
