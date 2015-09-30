;;;;; -*- Mode: Emacs-Lisp ; Coding: iso-2022-jp-dos -*-
;;
;; uenox-ps-print.el : Windows NT 標準の LPR を使って ps-print する
;; Copyright (C) 2000 UENO Tetsuyuki
;;
;; 本プログラムはフリー・ソフトウェアです。
;; 　あなたは、Free Software Foundationが公表したGNU 一般公有使用許諾の
;;「バージョン２」或いはそれ以降の各バージョンの中からいずれかを選択し、
;; そのバージョンが定める条項に従って本プログラムを再頒布または変更する
;; ことができます。
;; 　本プログラムは有用とは思いますが、頒布にあたっては、市場性及び特定
;; 目的適合性についての暗黙の保証を含めて、いかなる保証も行ないません。
;; 詳細についてはGNU 一般公有使用許諾書をお読みください。
;; 　GNU一般公有使用許諾の写しは http://www.gnu.org/copyleft/gpl.txt か
;; ら入手することができます。
;; 　日本語版については http://www.gnu.org/copyleft/ を参照願います。
;;
;; 著作者: 上野 哲幸 "UENO Tetsuyuki" <uenox@livedoor.com>
;; 版情報: 0.02
;; 作成日時：2000/10/24
;; 配布場所: http://uenox.hoops.livedoor.com/elisp/uenox-ps-print.el
;;
;;【導入】
;;  　上記の配布場所からファイルをダウンロードして、ホームディレクトリ
;;  ("~")に格納してください。
;;
;;【設定】
;;  初期化ファイル .emacs に以下の行を書き加えてください。
;;    (setq load-path (cons "~" load-path))
;;    (load "uenox-ps-print")
;;
;;　デフォルトのプリンタ名とプリンタ名の一覧を登録をする為、以下の行を
;;　参考に初期化ファイル .emacs に書き加えてください。
;;    (setq uenox-ps-printer-name "pspr01")
;;    (setq uenox-ps-printer-name-list '("pspr01" 
;;                                       "pspr02"
;;                                       "pspr03"))
;;
;;　M-x uenox-select-ps-printer とすることにより、登録したプリンタを選
;;　択することができるようになります。
;;
;;【説明】
;;  Windows NT 標準の lpr を使って印刷することができるようになります。
;;
;;【Tips】
;;  ※用紙サイズと用紙方向を設定するには、以下のように設定します。
;;    (setq ps-paper-type 'a4) ; サイズは必ず設定しましょう。
;;    (setq ps-landscape-mode t)
;;
;;  ※ページに複数列の印刷をする場合、以下の数値を設定してください。
;;    (setq ps-number-of-columns 1)
;;
;;  ※カラー印刷対応PSプリンターに印刷するには以下のようにします。
;;    (setq ps-print-color-p t)
;;
;;【注意】
;;  (1) このスクリプトでは uenox- という文字列から始まるシンボルを使い
;;     ます。
;;  (2) このスクリプトでは ps-print.el の ps-print-region-function,  
;;     ps-printer-name, ps-multibyte-buffer の内容を書き換えます。
;;

;;; ps-printer の名称
(defvar uenox-ps-printer-name nil
  "The name of a network PostScript Printer.")

;;; ps-printer のリスト
(defvar uenox-ps-printer-name-list nil
  "The list of network PostScript Printers.")

;;; ps-printer を選択する関数
(defun uenox-select-ps-printer()
  "Select PostScript Printer for output."
  (interactive)
  (setq uenox-ps-printer-name 
	(read-string "Select Printer : " 
		     uenox-ps-printer-name 
		     'uenox-ps-printer-name-list)))

;;; ps-print.el が提供する関数 ps-print-region-function の代替関数
(defun uenox-ps-print-region-function(from to &rest arg)
  "For Windows NT LPR which cannot use pipe!"
  (let ((tmpfile 
	 (make-temp-name 
	  (concat 
	   (file-name-as-directory temporary-file-directory) "ps"))))
	(write-region from to tmpfile)
	(cd "~") ; for files on ftp-server.
	(if uenox-ps-printer-name
	    (shell-command (format "lpr -S %s -P %s -o l %s" 
				   uenox-ps-printer-name 
				   uenox-ps-printer-name 
				   tmpfile)))
	(delete-file tmpfile)))

;;; ps-print.el が提供する関数を上記の関数で強制的に置き換える。
(setq ps-print-region-function 'uenox-ps-print-region-function)

;;; ps-printer.el のプリンタ名を(念の為)空にしておく。
(setq ps-printer-name nil)

;;; ps-printer.el の設定を変更し、マルチバイトの印刷を可能にする。
(setq ps-multibyte-buffer 'non-latin-printer)
