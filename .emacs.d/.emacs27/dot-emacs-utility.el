;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2014/10/03.01:38:27


;;==============================================================================
;; namespace is deu(dot emacs utility)                                          
;;==============================================================================


(require 'cl-lib)
(require 'package)



;;------------------------------------------------------------------------------
;; プラットフォームパスを生成
(defconst deu:rpath-platform 
  (cond
   ((eq system-type 'windows-nt) "win32/")
   ((eq system-type 'gnu/linux) "linux/")
   (t "linux/")))


(defconst deu:load-path-exclude-names '("GIT" "git" "Svn" "svn" "CVS" "cvs" "RCS" "rcs" "snippets"))



;;------------------------------------------------------------------------------
;; ファイルリストをまとめてロードする関数
(defun deu:load-libraries (file-list &optional absolute-path)
  (if (null absolute-path)
      (progn
        (cl-dolist (target-file file-list)
          (load-library target-file)))
    (progn
      (cl-dolist (target-file file-list)
        (load-library (expand-file-name target-file absolute-path))))))



;;------------------------------------------------------------------------------
;; Platformを識別しPlatform directoryから、target-file をロードする
;; Platform 個別設定ファイルが見つからない場合は無視する
(defun deu:load-library-auto-select-platform-path (target-file &optional absolute-path)
  ;; absolute-path + platform-directory + target-file
  (let ((target-path (expand-file-name target-file (expand-file-name deu:rpath-platform absolute-path))))
    (when (stringp (locate-library target-path))
      (load-library target-path))))



;;------------------------------------------------------------------------------
;; Platformを識別し、Platform用ロードリストのファイルだけをロードする
(defun deu:load-libraries-auto-select-platform-list (target-file-list &optional absolute-path)
  (deu:load-libraries (cadr (assq system-type target-file-list)) absolute-path))



;;------------------------------------------------------------------------------
;; systemを識別し、system用ファイルパスに変換する(絶対パスでない場合はなにもしない)
(defun deu:normalize-path (path)
  (cond
   ((eq system-type 'windows-nt)
    (let ( (regexp-pattern "^/cygdrive/\\([A-Za-z]\\)") )
      (cond
       ((string-match regexp-pattern path)
        (replace-regexp-in-string regexp-pattern "\\1:" path))
       (t
        path))))
   ((eq system-type 'cygwin)
    (let ( (regexp-pattern "^\\([A-Za-z]\\):") )
      (cond
       ((string-match regexp-pattern path)
        (replace-regexp-in-string regexp-pattern "/cygdrive/\\1" path))
       (t
        path))))
   (t
    path)))



;;------------------------------------------------------------------------------
;; load-path & bytecompile 対象として適切かをチェックする
(defsubst deu:valid-load-path-a-p (apath)
  (and (file-directory-p apath) 
       (not (or (file-exists-p (expand-file-name ".nosearch" apath)) (eq ?\. (aref (file-name-nondirectory apath) 0)) (member (file-name-nondirectory apath) deu:load-path-exclude-names) (file-symlink-p apath)))))

(defsubst deu:valid-load-path-r-p (directory file)
  (let ((apath (expand-file-name file directory)))
    (and (file-directory-p apath) 
         (not (or (file-exists-p (expand-file-name ".nosearch" apath)) (eq ?\. (aref file 0)) (member file deu:load-path-exclude-names) (file-symlink-p apath))))))

(defsubst deu:valid-byte-compile-file-p (apath)
  (let ((file (file-name-nondirectory apath)))
    (and (string-match "\.el$" file) (not (or (file-directory-p apath) (eq ?\. (aref file 0)))))))



;;------------------------------------------------------------------------------
;; 指定ディレクトリ以下を再帰的に探索、ディレクトリの絶対パスリストを生成する
;; ※ '.'で始まるディレクトリは除外される
(defun deu:add-to-path-list-directory-recursive (result-list top-directory)
  (add-to-list result-list top-directory)
  (let ((target-directories (list top-directory)))
    (cl-dolist (directory target-directories)
      (let ((child-files (directory-files directory t)))
        (cl-dolist (apath child-files)
          (when (deu:valid-load-path-a-p apath)
            ;;(message "absolute path = %s" apath)
            (nconc target-directories (list apath))
            (add-to-list result-list apath))))))
  ;;(message "result-list = %s" result-list)
  result-list)



;; 指定ディレクトリ以下に対して、regexpにマッチするパスを再帰的にサーチし、マッチしたパスリストを返す
(defun deu:search-apath-recursive (top-directory regexp)
  (let ((target-directories (list top-directory))
        match-paths)
    (cl-dolist (directory target-directories)
      (let ((child-files (directory-files directory t)))
        (cl-dolist (apath child-files)
          (when (deu:valid-load-path-a-p apath)
            (nconc target-directories (list apath)))
          (when (string-match regexp apath)
            (add-to-list 'match-paths apath)))))
    match-paths))




;; リストにある全ファイルを削除する
(defun deu:remove-files (files)
  (cl-dolist (file files)
    (when (file-exists-p file)
      (delete-file file))))


(defun deu:all-remove-elc-file (directory)
  (deu:remove-files (deu:search-apath-recursive directory "\.*elc$")))




;; 指定ディレクトリ直下のバイトコンパイル対象リストを返す
;; 直下ディレクトリもコンパイル対象とみなす
(defun deu:search-byte-compile-target (directory result-type)
  (let ((child-files (directory-files directory t))
        target-list)
    (cl-dolist (apath child-files)
      (when (or 
             (deu:valid-load-path-a-p apath)
             (deu:valid-byte-compile-file-p apath))
        (when (eq result-type 'relative)
          (setq apath (file-relative-name apath directory)))
        ;;(print apath)
        (add-to-list 'target-list apath)))
    (reverse target-list)))




;;------------------------------------------------------------------------------
;; 指定ファイルを自動バイトコンパイルする
;; elcファイル未生成もしくは、elよりelcが古いファイルをバイトコンパイルする
;; (defun deu:auto-byte-compile (byte-compile-src)
;;   (when (file-readable-p byte-compile-src)
;;     (let ((byte-compile-dest (byte-compile-dest-file byte-compile-src)))
;;       (when (or (file-newer-than-file-p byte-compile-src byte-compile-dest) (not (file-exists-p byte-compile-dest)))
;;  (byte-compile-file byte-compile-src)
;;  )
;;       )
;;     )
;; )



(defun deu:byte-recompile-directory (directory &optional arg force)
  "Recompile every `.el' file in DIRECTORY that needs recompilation.
This happens when a `.elc' file exists but is older than the `.el' file.
Files in subdirectories of DIRECTORY are processed also.

If the `.elc' file does not exist, normally this function *does not*
compile the corresponding `.el' file.  However, if the prefix argument
ARG is 0, that means do compile all those files.  A nonzero
ARG means ask the user, for each such `.el' file, whether to
compile it.  A nonzero ARG also means ask about each subdirectory
before scanning it.

If the third argument FORCE is non-nil, recompile every `.el' file
that already has a `.elc' file."
  (interactive "DByte recompile directory: \nP")
  (if arg (setq arg (prefix-numeric-value arg)))
  (if noninteractive
      nil
    (save-some-buffers)
    (force-mode-line-update))
  (with-current-buffer (get-buffer-create byte-compile-log-buffer)
    (setq default-directory (expand-file-name directory))
    ;; compilation-mode copies value of default-directory.
    (unless (eq major-mode 'compilation-mode)
      (compilation-mode))
    (let ((directories (list default-directory))
      (default-directory default-directory)
      (skip-count 0)
      (fail-count 0)
      (file-count 0)
      (dir-count 0)
      last-dir)
      (displaying-byte-compile-warnings
       (while directories
     (setq directory (car directories))
     (message "Checking %s...." directory)
         (cl-dolist (source (directory-files directory t))
           (if (deu:valid-load-path-a-p source)
               ;; This file is a subdirectory.  Handle them differently.
               (when (or (null arg) (eq 0 arg)
                         (y-or-n-p (concat "Check " source "? ")))
                 (setq directories (nconc directories (list source))))
             ;; It is an ordinary file.  Decide whether to compile it.
             (if (and ;; (string-match emacs-lisp-file-regexp source)
                      (deu:valid-byte-compile-file-p source)
                      (file-readable-p source)
                      (not (auto-save-file-name-p source))
                      (not (string-equal dir-locals-file
                                         (file-name-nondirectory source))))
                 (progn (cl-incf
                         (pcase (byte-recompile-file source force arg)
                           (`no-byte-compile skip-count)
                           (`t file-count)
                           (_ fail-count)))
                        (or noninteractive
                            (message "Checking %s..." directory))
                        (if (not (eq last-dir directory))
                            (setq last-dir directory
                                  dir-count (1+ dir-count)))
                        ))))
     (setq directories (cdr directories))))
      (message "Done (Total of %d file%s compiled%s%s%s)"
           file-count (if (= file-count 1) "" "s")
           (if (> fail-count 0) (format ", %d failed" fail-count) "")
           (if (> skip-count 0) (format ", %d skipped" skip-count) "")
           (if (> dir-count 1)
                   (format " in %d directories" dir-count) "")))))




;;------------------------------------------------------------------------------
;; 指定ディレクトリ以下を再帰的に探索、elcファイル未生成もしくは、elよりelcが古いファイルをバイトコンパイルする
;; ※ '.' 'git' 'svn' 'cvs' 'rcs'で始まるディレクトリ、 .nosearch ファイルを持つディレクトリは除外される
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
      ;; (message "deu:auto-byte-compile-recursive %s" directory)
      (deu:byte-recompile-directory directory 0 nil)
      ;;(message "load-path working = %s" load-path)
      )))






;; 指定ディレクトリ以下をバイトコンパイルする
;; (defun deu:byte-compile-recursive (directory)
;;   (let ((byte-compile-target-list (deu:search-byte-compile-target directory 'absolute)))
;;     (cl-dolist (target byte-compile-target-list)
;;       (if (file-directory-p target)
;;    (deu:auto-byte-compile-recursive target)
;;  ;;(print (format "deu:auto-byte-compile-recursive %s" target))
;;  (de:auto-byte-compile target)
;;  ;;(print (format "deu:auto-byte-compile %s" target))
;;  )
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
(defun deu:auto-byte-compile-plugins (directories)
  (let ((load-path load-path))
    (cl-dolist (directory directories)
      (let ((byte-compile-target-list (deu:search-byte-compile-target directory 'absolute)))
        (add-to-list 'load-path directory)

        ;; コンパイル前にパッケージディレクトリを追加
        (cl-dolist (target byte-compile-target-list)
          (when (file-directory-p target)
            (add-to-list 'load-path target)))
        ;; ディレクトリ単位のpluginをコンパイル
        (cl-dolist (target byte-compile-target-list)
          (when (file-directory-p target)
            (deu:auto-byte-compile-recursive target)))
        ;; コンパイルが終わってからパッケージディレクトリを追加
        ;; (cl-dolist (target byte-compile-target-list)
        ;;   (when (file-directory-p target)
        ;;  (add-to-list 'load-path target)))
        ;; 単体ファイルのコンパイル
        (cl-dolist (target byte-compile-target-list)
          (unless (file-directory-p target)
            (de:auto-byte-compile target)))))))



;;------------------------------------------------------------------------------
;; パッケージリスト内にインストールされていないパッケージが合った場合インストールを行う
(defun deu:package-install (packages)
  (let (targets)
    (cl-dolist (name packages)
      (unless (package-installed-p name)
        (message "Package: %s : not installed. " name)
        (add-to-list 'targets name t)))

    (when targets
      (package-refresh-contents)

      (cl-dolist (name targets)
        (package-install name)))))




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
  (message "%s" (get-char-property (point) 'face)))



;;------------------------------------------------------------------------------
;; クランプ関数
(defun deu:clamp-min-max (value min max)
  (min (max value min) max))






(provide 'dot-emacs-utility)
;;==============================================================================
;; EOF
