;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2018/10/01.21:10:54


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

;; buffer-local-variable
;; ウィンドウの右端を越える行の表示を切り詰める
;; truncate-partial-width-windows が 非nilの場合はtruncate-partial-width-windowsで上書きされる.
(setq-default truncate-lines t)

;; ウィンドウの右端を越える行の表示を切り詰める(左右に並んだウィンドウの場合)
(setq truncate-partial-width-windows nil)

;; スクロール時の進行行数
(setq scroll-step 1)

;; カーソルが画面から出たときにスクロールする行数
(setq scroll-conservatively 1)

;; buffer-local-variable
;; タブの設定
(setq-default tab-width 4)

;; buffer-local-variable
;; インデントTABモード(t:TAB, nil:whitespace) （nilはTABをwhitespaceに変換）
(setq-default indent-tabs-mode nil)

;; 起動時のメッセージを表示しない
(setq inhibit-startup-message nil)        

;; *Messages* バッファ最大行数
(setq message-log-max 2000)

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
;; search & replace                                                             
;;------------------------------------------------------------------------------


;; buffer-local-variable
;; 検索時に大文字と小文字の区別をしない
(setq-default case-fold-search t)

;; 置換時に大文字・小文字の区別をする
(setq case-replace nil)

;; サーチでマッチした部分をハイライト表示する
(setq search-highlight t)

;; 確認置換モードでマッチした部分をハイライト表示する
(setq query-replace-highligh t)



;;------------------------------------------------------------------------------
;; diff & ediff                                                                 
;;------------------------------------------------------------------------------


;; diff のスイッチ
(setq diff-switches "-u")

;; ediff 実行時に小さなウィンドウが出るのを抑制
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; ediff 起動時のフレーム分割スタイル
;; 分割関数は、この変数をトグルしてから起動するので初期状態をhorizontallyにしておかないとvertically起動にならない
(setq ediff-split-window-function 'split-window-horizontally)

;; ediff ハイライトリミットバイト数
(setq ediff-auto-refine-limit 20000)



;;------------------------------------------------------------------------------
;; find & grep                                                                  
;;------------------------------------------------------------------------------


;; library file load
(require 'grep)

;; find & (grep | lgrep) C/C++ファイルを標準とした
(setq grep-find-command "find . -type f -iregex \".*\\.\\(cpp\\|hpp\\|inl\\|inc\\|c\\|h\\)$\" -print0 | xargs -0 -e grep -n -e ")
;; (setq grep-find-command "find . -type f -regex \".*\\.\\(cpp\\|hpp\\|inl\\|c\\|h\\)$\" -print0 | xargs -0 -e lgrep -n -Au8 -Ia ")

;; lgrep command line options
;; http://www.ff.iij4u.or.jp/~nrt/lv/index.html#option

;; フレーム移動せずに選択した行のファイルを開く
(defun grep:compile-goto-error-no-select ()
  (interactive)
  (let ((window (selected-window)))
    (compile-goto-error)
    (select-window window)))


;; anything準拠で C-z にした、 ibuffer準拠で C-o でもいいかも？
(define-key grep-mode-map (kbd "C-z") 'grep:compile-goto-error-no-select)




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
;; (quietly-read-abbrev-file)

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

;; buffer-local-variable
;; 文字を右から左に表示する
(setq-default bidi-display-reordering nil)

;; buffer-local-variable
;; 改行方向
(setq-default bidi-paragraph-direction 'left-to-right)


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


;; リージョンをハイライトする
(transient-mark-mode t)


;; 矩形選択を拡張
(cua-mode t)

;; cua-mode 標準キーバインドを無効化
(setq cua-enable-cua-keys nil)

;; C-h を delete-backward-char にバインドしているので、 cua-modeのdelete-backward-char乗っ取りを阻止する
;; これをしないとリージョン選択状態で M-x した時に delete-backward-char が無効になる
(define-key cua--region-keymap [remap delete-backward-char] 'nil)
(define-key cua--rectangle-keymap [remap delete-backward-char] 'nil)



;;------------------------------------------------------------------------------
;; Kill Ring
;;------------------------------------------------------------------------------


;; kill ring max
(setq kill-ring-max 30)



;;------------------------------------------------------------------------------
;; Garbage Collection
;;------------------------------------------------------------------------------


;; 以下の条件を満たすと実行される
;;
;; __consing-since-gc          : GC後に作成されたLispオブジェクトのバイト数、GC直後は0?
;; gc-cons-threshold           : __consing-since-gc に対する閾値、この値を超えるとGCが実行される
;; __bytes_of_all_lisp_objects : 作成された全Lispオブジェクトのバイト数
;; gc-cons-percentage          : 作成された全Lispオブジェクトのバイト数の何％をGC発動閾値とするかを指定
;; gc-relative-threshold       : __consing-since-gc に対する閾値、この値を超えるとGCが実行される
;; 
;; gc-relative-threshold = __bytes_of_all_lisp_objects * gc-cons-percentage
;; ( (__consing-since-gc > gc-cons-threshold) && (__consing-since-gc > gc-relative-threshold) )


;; GC後に作成されたLispオブジェクトのバイト数が gc-cons-threshold を超えるとGCが実行される
;; この値を増すとGC頻度が下がり、結果的に動作速度が向上する
(setq gc-cons-threshold (* 512 1024 1024))

;; GC後に作成されたLispオブジェクトのバイト数が全Lispオブジェクト * gc-cons-percentage を超えるとGCが実行される
(setq gc-cons-percentage 0.5)



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

;; (set-message-beep 'SOUND<SYMBOL>)


;;------------------------------------------------------------------------------
;; Misc                                                                         
;;------------------------------------------------------------------------------


(defun erase-escape-code ()
  (interactive)

  (replace-string "\" "" nil (point-min) (point-max)))

(defun untabify-all ()
  (interactive)

  (untabify (point-min) (point-max)))

(defun tabify-all ()
  (interactive)

  (tabify (point-min) (point-max)))


;; easy benchmark
(defvar bm-latest-time nil)
(defvar bm-time-record nil)
(defvar bm-time-records nil)
(defvar bm-average nil)

(defun bm-clear ()
  (interactive)

  (setq bm-latest-time nil
        bm-time-record nil))

(defun bm-push-time (name)
  (interactive)

  (unless bm-latest-time
    (setq bm-latest-time (current-time)))
  (let ((enter-time bm-latest-time))
    (setq bm-latest-time (current-time))
      (push `(,name . ,(float-time (time-subtract bm-latest-time enter-time))) bm-time-record)))

(defun bm-flush ()
  (interactive)

  (message "---bm-flush---")
  (let ((total-time 0))
    (dolist (record bm-time-record)
      (setq total-time (+ total-time (cdr record))))
    (push `("total-time" . ,total-time) bm-time-record))
  (let ((sorted (nreverse bm-time-record)))
    (dolist (record sorted)
      (message (format "%s" record)))
    (bm-push-record sorted))
  (bm-clear))

(defun bm-push-record (record)
  ;; (message (format "record %s" record))
  (push record bm-time-records))

(defun bm-flush-records-average ()
  (interactive)

  (let (acc
        (count (length bm-time-records)))
    (message (format "---bm-flush-records-average[%d]---" count))
    (dolist (records bm-time-records)
      (dolist (record records)
        (let* ((name (car record))
               (time (cdr record))
               (element (assoc name acc)))
          (if element
              (setf (cdr element) (+ (cdr element) time))
            ;; (push record acc)))))
            (push `(,name . ,time) acc)))))
    (setq bm-average nil)
    (dolist (element acc)
      (push `(,(car element) ,(/ (cdr element) count)) bm-average))
    (dolist (element bm-average)
      (message (format "%s" element)))
    ;; (setq bm-time-records nil)
    acc))



;;------------------------------------------------------------------------------
;; Local Environment                                                            
;;------------------------------------------------------------------------------

(let ((self-file-name "misc.config"))
  (deu:load-library-auto-select-platform-path self-file-name de:path-basic-configuration)
  )





(provide 'misc.config)
;;------------------------------------------------------------------------------
;; EOF
