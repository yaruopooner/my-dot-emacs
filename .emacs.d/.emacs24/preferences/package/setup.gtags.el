;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2014/10/03.01:56:15


;;==================================================================================================
;; gtags setup                                                                                      
;;==================================================================================================




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


(require 'gtags)






;; gtagsモードのコマンドと補完候補生成コマンドの対応表
;; |-----------------------------+------------------------+----------------------|
;; | 検索コマンド                | 補完候補               | コマンドライン       |
;; |-----------------------------+------------------------+----------------------|
;; | gtags-find-tag              | 定義タグ               | global -c   ＜引数＞ |
;; | gtags-find-rtag             | 参照タグ               | global -cr  ＜引数＞ |
;; | gtags-find-symbol           | 「その他シンボル」タグ | global -cs  ＜引数＞ |
;; | gtags-find-with-grep        | なし                   | なし                 |
;; | gtags-find-with-idutils  ※ | トークン               | global -cI  ＜引数＞ |
;; | gtags-find-file             | パス名                 | global -cPo ＜引数＞ |
;; | gtags-parse-file            | ファイル名             | なし                 |
;; |-----------------------------+------------------------+----------------------|
;; ※ gtags-find-with-idutilsコマンドを使うにはgtagsを-Iォプション付きで実行しておく必要があります。


;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; gtags-mode を有効化するモードのフック
(defconst gtags:hook-list '(
                            c-mode-common-hook
                            lua-mode-hook
                            ))



;; ver6.0からcase-fold-search 変数に従った挙動をするようになった
;; case-fold-search は buffer-local-variable である.
;; case-fold-search が t の時は、globalコマンドの引数に i が追加される
;; nil の場合は完全一致のみ合致
;; インクリメンタルサーチ全般設定は /basic/misc.config.el で行われているのでプラグイン側で再設定はしない.
;; バッファローカル変数なので gtags-hook で設定してもよいが、これだと gtags-mode が動作するバッファのインクリメンタルサーチ全般に影響がでる.
;; これを回避して、汎用サーチ設定に影響を及ぼさず gtags 機能使用時だけサーチ設定を変えたい.
;; gtagsと汎用インクリメンタルサーチ設定は分離したいので以下のように修正


;; 完全一致
(defvar gtags:case-fold-search nil)
;; 汎用設定準拠：大文字小文字無視
;; (defvar gtags:case-fold-search case-fold-search)


(defmacro make-gtags-caller (func)
  (let ((name (make-symbol (concat (symbol-name func) "-custom"))))
    `(defadvice ,func (around ,name activate)
       (let ((case-fold-search gtags:case-fold-search))
         ad-do-it))))


(make-gtags-caller gtags-find-tag)
(make-gtags-caller gtags-find-rtag)
(make-gtags-caller gtags-find-symbol)




;;------------------------------------------------------------------------------
;; local keybind
;;------------------------------------------------------------------------------


(defvar gtags-mode-hook
  '(lambda ()
     ;; 指定したクラスorメソッドが定義されている部分を探す
     (local-set-key (kbd "M-t") 'gtags-find-tag)

     ;; 指定したクラスorメソッドが参照されている場所を探す
     (local-set-key (kbd "M-r") 'gtags-find-rtag)

     ;; 指定した変数名が使用されている部分を探す
     (local-set-key (kbd "M-s") 'gtags-find-symbol)

     ;; gtagsでジャンプする一つ前の状態に戻る
     (local-set-key (kbd "C-t") 'gtags-pop-stack)
     ))


(defvar gtags-select-mode-hook
  '(lambda ()
     ;; 強調表示(反転表示)
     ;; (hl-line-mode 1)
     ;; アンダーライン表示
     ;; (setq hl-line-face 'underline)
     ))




;;------------------------------------------------------------------------------
;; add hook                                                                     
;;------------------------------------------------------------------------------


;; ターゲットモードのフック登録
(cl-dolist (hook gtags:hook-list)
  (add-hook hook
            '(lambda ()
               ;; gtags自動有効化
               (gtags-mode 1)

               ;; 補完機能ON
               ;; (gtags-make-complete-list)

               ;; 複数候補時のジャンプ用バッファ生成は１つのみ
               (setq gtags-select-buffer-single t)

               ;; ジャンプ先パススタイル root/relative/absolute
               (setq gtags-path-style 'relative)

               ;; gtagsキーマップ有効化(これを有効にしないとキーバインドされない)
               (setq gtags-suggested-key-mapping t)

               ;; GLOBAL-6.0 released でキーバインドが変更になった、旧版利用時はこちら
               ;; (setq gtags-use-old-key-map t)
               )))







(provide 'setup.gtags)
;;--------------------------------------------------------------------------------------------------
;; EOF
