;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/09/04.04:45:11

;;==============================================================================
;; Miscellaneous (各種設定)                                                     
;;==============================================================================



;;------------------------------------------------------------------------------
;; Common Environment                                                           
;;------------------------------------------------------------------------------


;; ファイルの最後は自動的に new line
(setq require-final-newline t)

;; ファイルの終端で next-line をしたときに新しい行を作る
(setq next-line-add-newlines nil)

;; C-k で１行を削除する時に、文末の改行も一緒に削除
(setq kill-whole-line t)                

;; 画面表示を右側で折り返す
(setq truncate-partial-width-windows nil)

;; スクロール時の進行行数
(setq scroll-step 1)

;; カーソルが画面から出たときにスクロールする行数
(setq scroll-conservatively 1)

;; タブの設定
(setq tab-width 4)

;; 起動時のメッセージを表示しない
(setq inhibit-startup-message nil)        

;; diff のスイッチ
(setq diff-switches "-u")

;; *Messages* バッファ最大行数
(setq message-log-max 1000)

;; 削除確認などでyes/noと入れる代わりにy/nが使えるようになる
(fset 'yes-or-no-p 'y-or-n-p)

;; ミニバッファ使用中に、ミニバッファを用いるコマンド実行を許可する
(setq enable-recursive-minibuffers t)



;;------------------------------------------------------------------------------
;; Buffer Menu                                                                  
;;------------------------------------------------------------------------------


;; buffer name length
(setq Buffer-menu-buffer+size-width 40)

;; buffer mode name length
(setq Buffer-menu-mode-width 20)


;; library file load
(require 'uniquify)

;; filename<dir> 形式のバッファ名にする
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; *で囲まれたバッファ名は対象外にする
(setq uniquify-ignore-buffers-re "*[^*]+*")



;;------------------------------------------------------------------------------
;; dired-mode                                                                   
;;------------------------------------------------------------------------------


;; lsコマンドに渡す引数(-lは必須)
(setq dired-listing-switches "-lah")

;; ファイル名の大文字小文字無視でソート
(setq ls-lisp-ignore-case t)

;; ディレクトリとファイルを分けて表示
(setq ls-lisp-dirs-first t)

;; 日付表示フォーマット有効化
(setq ls-lisp-use-localized-time-format t)

;;表示フォーマット
(setq ls-lisp-format-time-list '("%Y-%m-%d %H:%M" "%Y-%m-%d %H:%M"))

;; ディレクトリを再帰的にコピー可能にする
;; `always' means copy recursively without asking.
;; `top' means ask for each directory at top level.
(setq dired-recursive-copies 'always)

;; ディレクトリを再帰的に削除可能にする(使用する場合は注意), 
;; `always' means delete recursively without asking.  This is DANGEROUS!
;; `top' means ask for each directory at top level, but delete its subdirectories
(setq dired-recursive-deletes 'top)


;; dired 拡張(C-x C-j) でdired呼び出し可能
(require 'dired-x)

;; wdired 編集開始を dired-modeの "r" キーにバインド
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)


;; ゴミ箱を有効
;; diredからファイル削除時に、OSが提供するゴミ箱にファイルを移動。GNOMEとWindowsで動作を確認
(setq delete-by-moving-to-trash t) 



;;------------------------------------------------------------------------------
;; search & replace                                                             
;;------------------------------------------------------------------------------


;; 検索時に大文字と小文字の区別をしない
(setq case-fold-search t)

;; 置換時に大文字・小文字の区別をする
(setq case-replace nil)

;; サーチでマッチした部分をハイライト表示する
(setq search-highlight t)

;; 確認置換モードでマッチした部分をハイライト表示する
(setq query-replace-highligh t)



;;------------------------------------------------------------------------------
;; find & grep                                                                  
;;------------------------------------------------------------------------------


;; find & (grep | lgrep) C/C++ファイルを標準とした
(setq grep-find-command "find . -type f -regex \".*\\.\\(cpp\\|hpp\\|inl\\|c\\|h\\)$\" -print0 | xargs -0 -e grep -n -e ")
;(setq grep-find-command "find . -type f -regex \".*\\.\\(cpp\\|hpp\\|inl\\|c\\|h\\)$\" -print0 | xargs -0 -e lgrep -n -Au8 -Ia ")

;; lgrep command line options
;; http://www.ff.iij4u.or.jp/~nrt/lv/index.html#option



;;------------------------------------------------------------------------------
;; recentf
;;------------------------------------------------------------------------------


;; 過去に開いたファイル履歴の保存場所とファイル名
(setq recentf-save-file (expand-file-name ".recentf" de:path-dot-emacs-root))

;; ファイル・ディレクトリ履歴の最大記録数
(setq recentf-max-saved-items 3000)

;; GUI recentfメニューに表示する最大数
(setq recentf-max-menu-items 20)

;; ファイル履歴から除外するもの
(setq recentf-exclude '("~$" "\\.elc$" "/TAGS$" "/var/tmp/"))



;;------------------------------------------------------------------------------
;; An Abbreviation                                                              
;;------------------------------------------------------------------------------


;; ロードする略語ファイルの場所
(setq abbrev-file-name (expand-file-name ".abbrev_defs" de:path-dot-emacs-root))

;; 起動時に有効化
(setq default-abbrev-mode t)

;; 起動時に保存した略称を読み込む
;(quietly-read-abbrev-file)

;; 登録した略語をファイルへ保存する
(setq save-abbrevs t)



;;------------------------------------------------------------------------------
;; Display                                                                      
;;------------------------------------------------------------------------------


;; 対応する括弧を点滅させる
(setq blink-matching-paren t)

;; 対応する括弧を点滅させる秒数
(setq blink-matching-delay 1)

;; 対応する括弧をハイライトする
(show-paren-mode t)

;; リージョンをハイライトする
(transient-mark-mode t)



;;------------------------------------------------------------------------------
;; Auto Save                                                                    
;;------------------------------------------------------------------------------


;; オートセーブファイル間隔
(setq auto-save-interval 1000)

;; オートセーブの設定
(auto-save-mode -1)



;;------------------------------------------------------------------------------
;; Time Stamp                                                                   
;;------------------------------------------------------------------------------


;; library file load
(require 'time-stamp)

;; タイムスタンプを更新するか
(setq time-stamp-active t)

;; タイムスタンプの開始部分
(setq time-stamp-start "last updated : ")

;; タイムスタンプの終了部分
(setq time-stamp-end " \\|$")

;; 日付時間の出力フォーマット
(setq time-stamp-format "%04y/%02m/%02d.%02H:%02M:%02S")

;; 関数 time-stamp が実行されるタイミング（ファイルを保存する時）
(add-hook 'write-file-hooks 'time-stamp)



;;------------------------------------------------------------------------------
;; Find File                                                                    
;;------------------------------------------------------------------------------


;; バッファ内カーソル位置のファイル名・ＵＲＬで find-file(C-x C-f) すると対象ファイル名のフルパスに展開された状態でミニバッファが開く
(ffap-bindings)

;; 画像ファイルを表示
;; find-file で画像が見れます
(auto-image-file-mode)



;;------------------------------------------------------------------------------
;; Mark & Region
;;------------------------------------------------------------------------------


;; 矩形選択を拡張
(cua-mode t)

;; cua-mode 標準キーバインドを無効化
(setq cua-enable-cua-keys nil)



;;------------------------------------------------------------------------------
;; Misc                                                                         
;;------------------------------------------------------------------------------


;; この値を増すと garbage collections の頻度が下がり、結果的に動作速度が向上する
;; default value --> 400000
(setq gc-cons-threshold 5000000)

;; kill ring max
(setq kill-ring-max 30)



;;------------------------------------------------------------------------------
;; Sound                                                                        
;;------------------------------------------------------------------------------


;; ビープ音が鳴るのがうるさい
;; ビジブルベル(t:OFF nil:ON)
(setq visible-bell t)

;; ビープ音を変える
;; (set-message-beep SOUND)

;; SOUND は 'asterisk, 'exlamation, 'hand, 'question, 'ok を使う事
;; nil の場合は普通のビープ音

;; "SOUND" list
;; 'ok             # 一般の警告音
;; 'asterisk       # メッセージ（情報）
;; 'question       # メッセージ（問い合わせ）
;; 'exclamation    # メッセージ（警告）
;; 'hand           # システムエラー

;(set-message-beep 'SOUND<SYMBOL>)



;;------------------------------------------------------------------------------
;; Local Environment                                                            
;;------------------------------------------------------------------------------

(let ((self-file-name "misc.config"))
    (deu:load-library-auto-select-platform-path self-file-name path-basic-configuration)
)





(provide 'misc.config)
;;------------------------------------------------------------------------------
;; EOF
