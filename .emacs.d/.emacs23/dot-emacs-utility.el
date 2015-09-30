;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/09/04.04:51:24


;;==============================================================================
;; namespace is deu(dot emacs utility)                                          
;;==============================================================================


;;------------------------------------------------------------------------------
;; プラットフォームパスを生成
(defconst deu:rpath-platform 
  (cond
   ((eq system-type 'windows-nt) "win32/")
   ((eq system-type 'gnu/linux) "linux/")
   (t "linux/")
   )
  )



;;------------------------------------------------------------------------------
;; ファイルリストをまとめてロードする関数
(defun deu:load-libraries (file-list &optional absolute-path)
  (if (null absolute-path)
      (progn
	(dolist (target-file file-list)
	  (load-library target-file)
	  )
	)
    (progn
      (dolist (target-file file-list)
	(load-library (expand-file-name target-file absolute-path))
	)
      )
    )
  )



;;------------------------------------------------------------------------------
;; Platformを識別しPlatform directoryから、target-file をロードする
;; Platform 個別設定ファイルが見つからない場合は無視する
(defun deu:load-library-auto-select-platform-path (target-file &optional absolute-path)
  ;; absolute-path + platform-directory + target-file
  (let ((target-path (expand-file-name target-file (expand-file-name deu:rpath-platform absolute-path))))
    (when (stringp (locate-library target-path))
	(load-library target-path)
      )
    )
  )



;;------------------------------------------------------------------------------
;; Platformを識別し、Platform用ロードリストのファイルだけをロードする
(defun deu:load-libraries-auto-select-platform-list (target-file-list &optional absolute-path)
  (deu:load-libraries (cdr (assq system-type target-file-list)) absolute-path)
  )



;;------------------------------------------------------------------------------
;; systemを識別し、system用ファイルパスに変換する(絶対パスでない場合はなにもしない)
(defun deu:normalize-path (path)
  (cond
   ( (eq system-type 'windows-nt)
     (let ( (regexp-pattern "^/cygdrive/\\([A-Za-z]\\)") )
       (cond
	((string-match regexp-pattern path)
	 (replace-regexp-in-string regexp-pattern "\\1:" path)
	 )
	(t
	 path)
	)
       )
     )
   ( (eq system-type 'cygwin)
     (let ( (regexp-pattern "^\\([A-Za-z]\\):") )
       (cond
	((string-match regexp-pattern path)
	 (replace-regexp-in-string regexp-pattern "/cygdrive/\\1" path)
	 )
	(t
	 path)
	)
       )
    )
   (t
    path
    )
   )
  )




;;------------------------------------------------------------------------------
;; 指定ディレクトリ以下を再帰的に探索、ディレクトリの絶対パスリストを生成する
;; ※ '.'で始まるディレクトリは除外される
(defun deu:add-to-path-list-directory-recursive (result-list top-directory)
  (add-to-list result-list top-directory)
  (let ((target-directorys (list top-directory)))
    (dolist (directory target-directorys)
      (let ((child-files (directory-files directory)) apath)
	(dolist (file child-files)
	  (setq apath (expand-file-name file directory))

	  (when (and (file-directory-p apath) (not (eq ?\. (aref file 0))))
	    ;;(message "absolute path = %s" apath)
	    (nconc target-directorys (list apath))
	    (add-to-list result-list apath)
	    )
	  )
	)
      )
    )
  ;;(message "result-list = %s" result-list)
  result-list
  )




;; 指定ディレクトリ以下に対して、regexpにマッチするパスを再帰的にサーチし、マッチしたパスリストを返す
(defun deu:search-apath-recursive (top-directory regexp)
  (let ((target-directorys (list top-directory)) match-paths)
    (dolist (directory target-directorys)
      (let ((child-files (directory-files directory)))
	(dolist (file child-files)
	  (let ((apath (expand-file-name file directory)))
	    (when (and (file-directory-p apath) (not (eq ?\. (aref file 0))))
	      (nconc target-directorys (list apath))
	      )
	    (when (string-match regexp apath)
	      (add-to-list 'match-paths apath)
	      )
	    )
	  )
	)
      )
    match-paths
    )
  )



;; リストにある全ファイルを削除する
(defun deu:remove-files (files)
  (dolist (file files)
    (when (file-exists-p file)
      (delete-file file)
      )
    )
  )





;; 指定ディレクトリ直下のバイトコンパイル対象リストを返す
;; 直下ディレクトリもコンパイル対象とみなす
(defun deu:search-byte-compile-target (directory result-type)
  (let ((child-files (directory-files directory)) target-list)
    (dolist (file child-files)
      (let ((apath (expand-file-name file directory)))
	(when (or (and (file-directory-p apath) (not (eq ?\. (aref file 0)))) (and (not (file-directory-p apath)) (string-match "\.el$" apath)) )
	  (when (eq result-type 'relative)
	    (setq apath (file-relative-name apath directory))
	    )
	  ;;(print apath)
	  (add-to-list 'target-list apath)
	  )
	)
      )
    (reverse target-list)
    )
  )




;;------------------------------------------------------------------------------
;; 指定ファイルを自動バイトコンパイルする
;; elcファイル未生成もしくは、elよりelcが古いファイルをバイトコンパイルする
;; (defun deu:auto-byte-compile (byte-compile-src)
;;   (when (file-readable-p byte-compile-src)
;;     (let ((byte-compile-dest (byte-compile-dest-file byte-compile-src)))
;;       (when (or (file-newer-than-file-p byte-compile-src byte-compile-dest) (not (file-exists-p byte-compile-dest)))
;; 	(byte-compile-file byte-compile-src)
;; 	)
;;       )
;;     )
;; )




;;------------------------------------------------------------------------------
;; 指定ディレクトリ以下を再帰的に探索、elcファイル未生成もしくは、elよりelcが古いファイルをバイトコンパイルする
;; ※ '.'で始まるディレクトリは除外される
(defun deu:auto-byte-compile-recursive (directory)
  (when (file-directory-p directory)
    ;; 任意パスにおいてバイトコンパイルを行うには、任意パスが load-path に含まれている必要がある
    ;; このため一時的に指定ディレクトリ以下すべてを load-path に追加する

    ;; byte-compile の警告を抑制する
    (let ((load-path load-path) (byte-compile-warnings nil))
      ;; directory recursive list add to load-list
      (deu:add-to-path-list-directory-recursive 'load-path directory)

      ;;(setq byte-compile-warnings '(free-vars unresolved callargs redefine obsolete noruntime cl-functions interactive-only make-local mapcar constants suspicious))

      ;; compile
      (byte-recompile-directory directory 0 nil)
      ;;(message "load-path working = %s" load-path)
      )
    )
  )






;; 指定ディレクトリ以下をバイトコンパイルする
;; (defun deu:byte-compile-recursive (directory)
;;   (let ((byte-compile-target-list (deu:search-byte-compile-target directory 'absolute)))
;;     (dolist (target byte-compile-target-list)
;;       (if (file-directory-p target)
;; 	  (deu:auto-byte-compile-recursive target)
;; 	;;(print (format "deu:auto-byte-compile-recursive %s" target))
;; 	(de:auto-byte-compile target)
;; 	;;(print (format "deu:auto-byte-compile %s" target))
;; 	)
;;       )
;;     )
;;   )


;; バイトコンパイルをpluginsフォルダに適用する
;; コンパイルルールは、直下のelファイルのみが対象
;; 直下にディレクトリがあった場合はディレクトリ以下をコンパイル時のみload-pathに追加して再帰コンパイル
;; 
;; コンパイル順序
;; 1.directory直下のディレクトリ以下全elファイル
;;   ディレクトリ以下が再帰探索され全elファイルをコンパイルする
;;   elファイルコンパイル時のみload-pathにディレクトリ以下の全パスが追加される
;; 2.directory直下の全elファイル
;;   elファイルコンパイル時のみload-pathにdirectory直下の全ディレクトリが追加される
;;   これは直下elファイルからrequireされるシンボルが直下ディレクトリのelに存在するので
;;   これらのパスがload-pathにない場合コンパイルエラーになる
;;   これを回避するために直下ディレクトリのみをload-pathに追加している
;; ※.plugins以下の全ディレクトリをload-pathに追加してしまうと意図しないコンパイルエラーになる
;;   これらは、各pluginが汎用的なファイル名で機能を定義していた場合、他のpluginのファイル名と重複する場合があり
;;   load-pathに追加されるパス順番しだいで、他のpluginのファイルをロードしてしまうために発生する。
;;   よって、バイトコンパイル時に有効なload-pathはコンパイル対象のplugin以下の全ディレクトリに限定すべきある。
(defun deu:auto-byte-compile-plugins (directory)
  (let ((load-path load-path) (byte-compile-target-list (deu:search-byte-compile-target directory 'absolute)))
    (add-to-list 'load-path directory)

    ;; ディレクトリ単位のpluginをコンパイル
    (dolist (target byte-compile-target-list)
      (when (file-directory-p target)
	(deu:auto-byte-compile-recursive target)
	)
      )
    ;; コンパイルが終わってからディレクトリを追加
    (dolist (target byte-compile-target-list)
      (when (file-directory-p target)
	(add-to-list 'load-path target)
	)
      )
    ;; 単体ファイルのコンパイル
    (dolist (target byte-compile-target-list)
      (unless (file-directory-p target)
	(de:auto-byte-compile target)
	)
      )
    )
  )





;;------------------------------------------------------------------------------
;; set-frame-parameter と remove & add-to-list > default-frame-alist を実行する
(defun deu:set-default-frame-parameter (key new-value)
  ;; 現在のフレームに反映
  (set-frame-parameter nil key new-value)

  ;; default-frame-alist に指定 key を持つ値があるならセットで削除
  (setq default-frame-alist (remove (assq key default-frame-alist) default-frame-alist))
  ;; 削除後に '(key . new-value) をセット
  (add-to-list 'default-frame-alist `(,key . ,new-value))

  ;;  (message "deu:set-default-frame-parameter:key = %s, new-value = %s" (symbol-name key) new-value)
  ;;  (message "deu:set-default-frame-parameter:result = %s" (identity default-frame-alist))
  )




;;------------------------------------------------------------------------------
;; パラメーターセット監視用
;; (defadvice set-frame-parameter (before deu:set-frame-parameter-snooper (frame parameter value) activate)
;;   (message "set-frame-parameter:frame = %s, parameter = %s, value = %s" (symbol-name frame) (symbol-name parameter) value)
;; )



;;------------------------------------------------------------------------------
;; カーソルがポイントしている部分のface名を知ることができる
(defun deu:describe-face-at-point ()
  (interactive)
  (message "%s" (get-char-property (point) 'face))
  )





(provide 'dot-emacs-utility)
;;==============================================================================
;; EOF
