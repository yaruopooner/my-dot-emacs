;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2019/12/28.00:47:17


;;==============================================================================
;; Coding System Environment                                                   
;;==============================================================================



;; set-language-environment で言語を設定すると
;; 言語に関連付けられた各種環境設定値で設定を行う
;; そのうちの１つが coding-system で
;; coding-system に適切な値が環境設定から取得され
;; set-default-coding-systems で設定される
;; set-language-environment 後に優先させたいエンコーディングを prefer-coding-system で指定する
;; 複数回指定可能で、登録順番でプライオリティが決定される
;; ※最後に登録したものが highest priority になる
;; (coding-system-priority-list) を評価すると、現在の優先度がわかる
;; 最短設定だと↓のようになる
;;
;; (setenv "LANG" "ja_JP.UTF-8")
;; (set-language-environment "Japanese")
;; (prefer-coding-system 'utf-8)
;;



;; 環境変数 LANG にja_JP.UTF-8 が設定されている必要がある
;;(setenv "LANG" "ja_JP.UTF-8")


;; 言語は日本語
(set-language-environment "Japanese")


;; coding system

;; 通常は↓を設定すれば動作するが、
;; dired/grep/shellなどでの日本語表示が化けるので下記のように個別設定を行っている
(prefer-coding-system 'utf-8)

;; prefer-coding-system では BOM 付きの UTF-8 (utf-8-with-signature) を指定してはいけない。
;; サブプロセスでの文字コードも変わってしまうので、 grep やコンパイルなどで外部プログラムをちゃんと呼び出せなくなる

;; 以下の設定で dired mode や shell mode で日本語が化けず、かつなるべく UTF-8 な環境で作業できる。
;; M-x grep-find で文字コード混在文書を検索でき、結果は UTF-8 で表示される。 

;; (describe-variable 'default-buffer-file-coding-system) では
;; 
;; This variable is obsolete since 23.2;
;; use `buffer-file-coding-system' instead.
;; 
;; と説明されているが、23.4においても、これを指定しないと
;; ibuffer menu や *TEMPORARY-BUFFER* 系など Emacs 作業用バッファは shift-jis になる
;; (set-language-environment "Japanese") で関連付けされているのが shift-jis だから？
;; (setq default-buffer-file-coding-system 'utf-8)
;; (setq-default buffer-file-coding-system 'utf-8)

;; BOM付きにするのはUNIX系では好ましくなさそう
;; シェルファイルなどの#! で問題が出そう
;;(set-buffer-file-coding-system 'utf-8-with-signature-unix)
;; (set-buffer-file-coding-system 'utf-8)
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; (set-selection-coding-system 'utf-16le-dos)
;; (setq default-terminal-coding-system 'utf-8)
;; (setq default-keyboard-coding-system 'utf-8)
;; ↓にしないとgrepが正しく動作しない(win32/coding-system.config.el の方だけかも？)
(setq default-process-coding-system '(japanese-shift-jis-dos . japanese-shift-jis-unix))
;; (setq default-file-name-coding-system 'utf-8)

;; GNU Emacs Manual によると
;; *-coding-system が nilならば、
;; Emacsは選択されている言語環境(set-language-environment)で決まるデフォルトのコーディングシステムを使います。
;; ということなので上記で設定しなかった変数には、各変数の default-*-coding-system の値が採用される。





;; grep
(defadvice grep (around grep-coding-setup activate)
  (let ((coding-system-for-read 'utf-8))
    ad-do-it))



;; shell
(setq shell-mode-hook
      (function (lambda ()
                  (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))))





;;------------------------------------------------------------------------------
;; Mode-Line Display                                                            
;;------------------------------------------------------------------------------


;; 文字コードと改行コードを確認しやすくする
;; BOMなしを 大文字の U に
(coding-system-put 'utf-8 :mnemonic ?U)
;; BOMありを 小文字の u に
(coding-system-put 'utf-8-with-signature :mnemonic ?u)
 

;; 改行コード表示

;; original value
(setq eol-mnemonic-dos "[Dos]")
(setq eol-mnemonic-mac "[Mac]")
(setq eol-mnemonic-unix "[Unix]")
;; CR,LF
;; (setq eol-mnemonic-dos "[CR+LF]")
;; (setq eol-mnemonic-mac "[CR]")
;; (setq eol-mnemonic-unix "[LF]")

(setq eol-mnemonic-undecided "[?]") 






(cond
 ;; Emacs
 ((eq de:emacs-type 'emacs)
  ())
 ;; Meadow
 ((eq de:emacs-type 'meadow)
  ;;(set-w32-system-coding-system 'sjis-unix)
  (set-w32-system-coding-system 'sjis-dos)
  ))



(setq network-coding-system-alist '(
                                    ("nntp" . (junet-unix . junet-unix))
                                    (110    . (no-conversion . no-conversion))
                                    (25     . (no-conversion . no-conversion))
                                    ))


(let ((self-file-name "coding-system.config"))
  (deu:load-library-auto-select-platform-path self-file-name de:path-basic-configuration)
  )




(provide 'coding-system.config)
;;------------------------------------------------------------------------------
;; EOF
