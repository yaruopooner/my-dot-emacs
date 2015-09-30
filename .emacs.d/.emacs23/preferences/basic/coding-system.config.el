;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/09/03.03:44:09

;;==============================================================================
;; Coding System Environment                                                   
;;==============================================================================



;; set-language-environment で言語を設定すると
;; 言語に関連付けられた各種環境設定値で設定を行う
;; そのうちの１つが coding-system で
;; coding-system に適切な値が環境設定から取得され
;; set-default-coding-systems で設定される
;; set-language-environment 後に優先させたいエンコーディングを prefer-coding-system で指定する。
;; 複数回指定可能で、登録順番でプライオリティが決定される。
;; ※最後に登録したものが highest priority になる
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
;;(prefer-coding-system 'utf-8)



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
(setq default-buffer-file-coding-system 'utf-8)

(set-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-16le-dos)


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





(cond
    ;; Emacs
    ((eq de:emacs-type 'emacs)
      ()
    )
    ;; Meadow
    ((eq de:emacs-type 'meadow)
      ;(set-w32-system-coding-system 'sjis-unix)
      (set-w32-system-coding-system 'sjis-dos)
    )
)



(setq network-coding-system-alist '(
				    ("nntp" . (junet-unix . junet-unix))
				    (110 . (no-conversion . no-conversion))
				    (25 . (no-conversion . no-conversion))
				    )
      )





(provide 'coding-system.config)
;;------------------------------------------------------------------------------
;; EOF
