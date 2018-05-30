;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2014/10/19.04:30:31


;;==================================================================================================
;; gtags setup                                                                                      
;;==================================================================================================




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


(require 'helm-gtags)






;; helm-gtagsモードのコマンドと補完候補生成コマンドの対応表
;; |----------------------------------+------------------------+----------------------|
;; | 検索コマンド                     | 補完候補               | コマンドライン       |
;; |----------------------------------+------------------------+----------------------|
;; | helm-gtags-find-tag              | 定義タグ               | global -c   ＜引数＞ |
;; | helm-gtags-find-rtag             | 参照タグ               | global -cr  ＜引数＞ |
;; | helm-gtags-find-symbol           | 「その他シンボル」タグ | global -cs  ＜引数＞ |
;; | helm-gtags-find-with-grep        | なし                   | なし                 |
;; | helm-gtags-find-with-idutils  ※ | トークン               | global -cI  ＜引数＞ |
;; | helm-gtags-find-file             | パス名                 | global -cPo ＜引数＞ |
;; | helm-gtags-parse-file            | ファイル名             | なし                 |
;; |----------------------------------+------------------------+----------------------|
;; ※ helm-gtags-find-with-idutilsコマンドを使うにはhelm-gtagsを-Iォプション付きで実行しておく必要があります。


;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; helm-gtags-mode を有効化するモードのフック
(defconst helm-gtags:hook-list '(
                            c-mode-common-hook
                            lua-mode-hook
                            ))



;; ver6.0からcase-fold-search 変数に従った挙動をするようになった
;; case-fold-search は buffer-local-variable である.
;; case-fold-search が t の時は、globalコマンドの引数に i が追加される
;; nil の場合は完全一致のみ合致
;; インクリメンタルサーチ全般設定は /basic/misc.config.el で行われているのでプラグイン側で再設定はしない.
;; バッファローカル変数なので helm-gtags-hook で設定してもよいが、これだと helm-gtags-mode が動作するバッファのインクリメンタルサーチ全般に影響がでる.
;; これを回避して、汎用サーチ設定に影響を及ぼさず helm-gtags 機能使用時だけサーチ設定を変えたい.
;; helm-gtagsと汎用インクリメンタルサーチ設定は分離したいので以下のように修正


;; 完全一致
;; (defvar helm-gtags:case-fold-search nil)
;; 汎用設定準拠：大文字小文字無視
;; (defvar helm-gtags:case-fold-search case-fold-search)
(setq helm-gtags-ignore-case nil)


;; (defmacro make-helm-gtags-caller (func)
;;   (let ((name (make-symbol (concat (symbol-name func) "-custom"))))
;;     `(defadvice ,func (around ,name activate)
;;        (let ((case-fold-search helm-gtags:case-fold-search))
;;          ad-do-it))))


;; (make-helm-gtags-caller helm-gtags-find-tag)
;; (make-helm-gtags-caller helm-gtags-find-rtag)
;; (make-helm-gtags-caller helm-gtags-find-symbol)




;;------------------------------------------------------------------------------
;; local keybind
;;------------------------------------------------------------------------------


(add-hook 'helm-gtags-mode-hook
          '(lambda ()
             ;; 指定したクラスorメソッドが定義されている部分を探す
             (local-set-key (kbd "M-t") 'helm-gtags-find-tag)

             ;; 指定したクラスorメソッドが参照されている場所を探す
             (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)

             ;; 指定した変数名が使用されている部分を探す
             (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)

             ;; helm-gtagsでジャンプする一つ前の状態に戻る
             (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)

             (local-set-key (kbd "C-z") 'helm-gtags-find-tag-other-window)
             ))


(defvar helm-gtags-select-mode-hook
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
(cl-dolist (hook helm-gtags:hook-list)
  (add-hook hook
            '(lambda ()
               ;; helm-gtags自動有効化
               (helm-gtags-mode 1)

               ;; 補完機能ON
               ;; (helm-gtags-make-complete-list)

               ;; 複数候補時のジャンプ用バッファ生成は１つのみ
               ;; (setq helm-gtags-select-buffer-single t)

               ;; ジャンプ先パススタイル root/relative/absolute
               (setq helm-gtags-path-style 'relative)

               ;; helm-gtagsキーマップ有効化(これを有効にしないとキーバインドされない)
               (setq helm-gtags-suggested-key-mapping t)

               ;; GLOBAL-6.0 released でキーバインドが変更になった、旧版利用時はこちら
               ;; (setq helm-gtags-use-old-key-map t)
               )))







(provide 'setup.helm-gtags)
;;--------------------------------------------------------------------------------------------------
;; EOF
