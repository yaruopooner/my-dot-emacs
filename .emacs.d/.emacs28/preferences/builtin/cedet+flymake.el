;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2014/10/03.01:58:19


;;==================================================================================================
;; CEDET Extension
;;==================================================================================================

;; CEDET:EDE と flymake の連携サポート


(eval-when-compile (require' cl))





;;------------------------------------------------------------------------------
;; variables for EDE & flymake                                                  
;;------------------------------------------------------------------------------


;; セットアップファイルがおいてある場所（標準）
(defvar ede:path-project-setup-files-default (expand-file-name "ede-project-setup-files/" de:path-dot-emacs-root))

(defvar ede:project-name "New EDE Project")
(defvar ede:project-file "./Project.ede")

;; プロジェクトでのflymake有効化
(defvar ede:project-flymake-enable nil)
;; (defvaralias 'ede:project-flymake-enable 'flymake:enable)
;; (setq ede:project-flymake-enable nil)

;; Makefileの利用選択 t:する、nil:しない
(defvar ede:project-flymake-use-makefile nil)
;; (defvaralias 'ede:project-flymake-use-makefile 'flymake:use-makefile)
;; (setq ede:project-flymake-use-makefile nil)


(defvar ede:project-compiler nil
  "use compiler symbol
`gcc'                : GNU C Compiler
`g++'                : GNU C++ Compiler
`ppu-g++'            : PPU C++ Compiler
`spu-g++'            : SPU C++ Compiler
`vc++-2010'          : Microsoft Visual Studio 2010 C++ Compiler
`vc++-2010.dxsdk'    : Microsoft Visual Studio 2010 C++ Compiler & DirectX SDK
`hlsl'               : HLSL Compiler
")


;; コンパイラ実行ファイル名
(defvar ede:project-compiler-command nil)
;; (defvaralias 'ede:project-compiler-command 'flymake:compiler-command)
;; (setq ede:project-compiler-command nil)

;; コンパイラに渡す直前のオプション文字列リスト
(defvar ede:project-compile-options nil)
;; (defvaralias 'ede:project-compile-options 'flymake:compile-options)
;; (setq ede:project-compile-options nil)


;; 以下は EDE Project に渡すデータ
(defvar ede:path-project-root nil)

;; system include path(absolute path)
;; platform system include path + middleware include path(optional)
(defvar ede:project-system-include-path-list nil)

;; project include path(relative path)
;; project include path + middleware include path(optional)
(defvar ede:project-relative-include-path-list nil)

(defvar ede:project-define-list nil)

;; オプションフォーマット変換させずに渡すオプション群
(defvar ede:project-compile-immediate-option-list nil)

(defvar ede:project-header-match-regexp "\\.\\(h\\(h\\|xx\\|pp\\|\\+\\+\\)?\\|H\\)$\\|\\<\\w+$")

(defvar ede:project-spp-table nil)
(defvar ede:project-spp-files nil)

(defvar ede:project-local-variables nil)




;; Visual Studio 2010
;; http://msdn.microsoft.com/ja-jp/library/19z1t1wy%28v=vs.100%29.aspx

;; コンパイラ情報
(defvar ede:compiler-info-alist '(
                  (gcc . (
                      (compiler-file   . "gcc-4")
                      (includes        . ("/usr/include/" "/usr/share/include/" "/usr/local/include/"))
                      (defines         . ())
                      (immediates      . ("-Wall" "-Wextra" "-pedantic" "-fsyntax-only"))
                      (fmt-include     . "-I%s")
                      (fmt-define      . "-D%s")
                      (fmt-undef       . "-U%s")
                      (fmt-immediate   . "%s")
                      ))
                  (g++ . (
                      (compiler-file   . "g++-4")
                      (includes        . ("/usr/include/" "/usr/share/include/" "/usr/local/include/"))
                      (defines         . ())
                      (immediates      . ("-Wall" "-Wextra" "-pedantic" "-fsyntax-only"))
                      (fmt-include     . "-I%s")
                      (fmt-define      . "-D%s")
                      (fmt-undef       . "-U%s")
                      (fmt-immediate   . "%s")
                      ))
                  (ppu-g++ . (
                          (compiler-file   . "${CELL_SDK}/host-win32/ppu/bin/ppu-lv2-g++")
                          (includes        . ("${CELL_SDK}/target/ppu/include/vectormath/cpp/"))
                          (defines         . ())
                          (immediates      . ("-Wall" "-fsyntax-only"))
                          (fmt-include     . "-I%s")
                          (fmt-define      . "-D%s")
                          (fmt-undef       . "-U%s")
                          (fmt-immediate   . "%s")
                          ))
                  (spu-g++ . (
                          (compiler-file   . "${CELL_SDK}/host-win32/spu/bin/spu-lv2-g++")
                          (includes        . ("${CELL_SDK}/target/spu/include/vectormath/cpp/"))
                          (defines         . ())
                          (immediates      . ("-Wall" "-fsyntax-only"))
                          (fmt-include     . "-I%s")
                          (fmt-define      . "-D%s")
                          (fmt-undef       . "-U%s")
                          (fmt-immediate   . "%s")
                          ))
                  (vc++-2010 . (
                        (compiler-file   . "cl")
                        (includes        . ("${VC_INCLUDE_PATH}/include/" "${WINDOWS_SDK_INCLUDE_PATH}/include/" "${FRAMEWORK_SDK_INCLUDE_PATH}/include/"))
                        (defines         . ())
                        (immediates      . ("/nologo" "/W4" "/Zs"))
                        (fmt-include     . "/I\"%s\"")
                        (fmt-define      . "/D\"%s\"")
                        (fmt-undef       . "/U\"%s\"")
                        (fmt-immediate   . "%s")
                        ))
                  (vc++-2010.dxsdk . (
                              (compiler-file   . "cl")
                              (includes        . ("${VC_INCLUDE_PATH}/include/" "${WINDOWS_SDK_INCLUDE_PATH}/include/" "${FRAMEWORK_SDK_INCLUDE_PATH}/include/" "${DXSDK_DIR}/include/"))
                              (defines         . ())
                              (immediates      . ("/nologo" "/W4" "/Zs"))
                              (fmt-include     . "/I\"%s\"")
                              (fmt-define      . "/D\"%s\"")
                              (fmt-undef       . "/U\"%s\"")
                              (fmt-immediate   . "%s")
                              ))
                  (hlsl . (
                       (compiler-file   . "${DXSDK_DIR}/Utilities/bin/x86/fxc.exe")
                       (includes        . ())
                       (defines         . ())
                       (immediates      . ("/nologo" "/Od"))
                       (fmt-include     . "/I\"%s\"")
                       (fmt-define      . "/D\"%s\"")
                       (fmt-undef       . "")
                       (fmt-immediate   . "%s")
                       ))
                  )
"compiler information association table
symbol list
`compiler-file'       : compiler executable file name
`includes'            : platform default include path list
`defines'             : platform default define list
`immediates'          : platform default immediate option list
`fmt-include'         : output include option format
`fmt-define'          : output define option format
`fmt-undef'           : output undef option format
`fmt-immediate'       : output include option format
")




;;------------------------------------------------------------------------------
;; common functions
;;------------------------------------------------------------------------------


(defun ede:clear-variables ()
  "Clear EDE Project Variables."

  (interactive)

  (setq ede:project-name "New EDE Project")
  (setq ede:project-file "./Project.ede")

  ;; for flymake
  (setq ede:project-flymake-enable nil)
  (setq ede:project-flymake-use-makefile nil)

  (setq ede:project-compiler nil)
  (setq ede:project-compiler-command nil)
  (setq ede:project-compile-options nil)

  ;; for EDE
  (setq ede:path-project-root nil)

  (setq ede:project-system-include-path-list nil)
  (setq ede:project-relative-include-path-list nil)

  (setq ede:project-define-list nil)

  (setq ede:project-compile-immediate-option-list nil)

  (setq ede:project-header-match-regexp "\\.\\(h\\(h\\|xx\\|pp\\|\\+\\+\\)?\\|H\\|inl\\)$\\|\\<\\w+$")

  (setq ede:project-spp-table nil)
  (setq ede:project-spp-files nil)

  (setq ede:project-local-variables nil)
  )


;; compiler info queries
(defun ede:get-compiler-info (compiler)
  (cdr (assq compiler ede:compiler-info-alist)))

(defun ede:get-compiler-detail (compiler-info detail-name)
  (cdr (assq detail-name compiler-info)))





;;------------------------------------------------------------------------------
;; compile command generate functions for flymake
;;------------------------------------------------------------------------------


;; relative path syntax check
(cl-defun ede:syntax-check-relative-path (rpath-list)
  (cl-dolist (rpath rpath-list)
    (unless (or (eq ?\/ (aref rpath 0)) (eq ?\. (aref rpath 0)))
      (cl-return-from ede:syntax-check-relative-path nil)))
  t)


;; ede:path-project-root がセットされていることが前提
(defun ede:generate-project-absolute-include-path-list (rpath-list)
  (let (result-list)
    (cl-dolist (rpath rpath-list)
      (when (eq ?\/ (aref rpath 0))
        (setq rpath (concat "." rpath)))
      (add-to-list 'result-list (expand-file-name rpath ede:path-project-root)))
    result-list))



;; 引数リストにオプション文字列を付加する
(defun ede:option-list-generator-raw (result-options fmt-option args)
  "The argument list simple convert to compiler option format."

  (cl-dolist (arg args)
    (add-to-list result-options (format fmt-option arg))))

;; 引数リストにオプション文字列を付加する(環境変数も置換する)
(defun ede:option-list-generator (result-options fmt-option args)
  "The argument list convert to compiler option format.
  The argument will replace if environment variable is included in the argument."

  (cl-dolist (arg args)
    (add-to-list result-options (format fmt-option (substitute-in-file-name arg)))))



;; EDE Project 用にセットされた変数からコンパイルコマンドを生成する
(defun ede:generate-compile-commands (result-compiler-command result-options info)
  "Generate compile command for flymake."

  ;; compile command
  (set result-compiler-command (substitute-in-file-name (ede:get-compiler-detail info 'compiler-file)))

  ;; system path
  (ede:option-list-generator result-options (ede:get-compiler-detail info 'fmt-include) ede:project-system-include-path-list)
  ;; project path
  (ede:option-list-generator result-options (ede:get-compiler-detail info 'fmt-include) (ede:generate-project-absolute-include-path-list ede:project-relative-include-path-list))

  ;; default define
  (ede:option-list-generator result-options (ede:get-compiler-detail info 'fmt-define) (ede:get-compiler-detail info 'defines))
  ;; define
  (ede:option-list-generator result-options (ede:get-compiler-detail info 'fmt-define) ede:project-define-list)

  ;; default option
  (ede:option-list-generator-raw result-options (ede:get-compiler-detail info 'fmt-immediate) (ede:get-compiler-detail info 'immediates))
  ;; immediate option
  (ede:option-list-generator-raw result-options (ede:get-compiler-detail info 'fmt-immediate) ede:project-compile-immediate-option-list)
  )




;;------------------------------------------------------------------------------
;; EDE functions
;;------------------------------------------------------------------------------


;; convert default-path + setup-file-name
(defun ede:convert-project-setup-file-rpath-to-path (relative-path)
  (expand-file-name relative-path ede:path-project-setup-files-default))



;; project root path がアクセス可能なディレクトリのときだけプロジェクトをロードする
;;;###autoload
(cl-defun ede:load-project (project-setup-file-path)
  "Setup CEDET:EDE Project & flymake."

  (interactive
   (list (read-file-name "CEDET:EDE Project Setup File :" ede:path-project-setup-files-default nil t)))

  (labels (
           (log (label)
                (message label))
           (log-status (label value)
                       (message "  %-20s : %s" label value))
           )

    (log "[CEDET:EDE Project Setup]")

    ;; initialize variables
    (ede:clear-variables)


    ;; load project setup file 
    (let ((setup-file project-setup-file-path))
      ;; check relative path
      (unless (file-name-absolute-p setup-file)
        ;; convert to absolute path
        (setq setup-file (ede:convert-project-setup-file-rpath-to-path setup-file)))

      (log "---- Load Phase ----")
      (log-status "File" setup-file)


      ;; ファイル存在チェック
      (unless (file-readable-p setup-file)
        ;; なければエラー報告
        (log-status "Phase Status" "File Not Found")
        (cl-return-from ede:load-project nil))


      ;; あればロード
      (load-library setup-file)
      (log-status "Phase Status" "Success")
      )


    ;; activate a project

    ;; プロジェクトファイルが存在した場合は ede:path-project-root がセットされているハズ
    ;; セットされたパスが正しいかをチェックして、正しければプロジェクトを生成

    (log "---- Setup Phase ----")
    (log-status "Name" ede:project-name)
    (log-status "Root Path" ede:path-project-root)

    ;; ルートパスがnilでないか
    (unless (stringp ede:path-project-root)
      (log-status "Phase Status" "Value is not setup. ede:path-project-root is empty.")
      (cl-return-from ede:load-project nil))

    ;; パスがアクセス可能か（存在するか）
    (unless (file-accessible-directory-p ede:path-project-root)
      (log-status "Phase Status" "invalid project root path")
      (cl-return-from ede:load-project nil))

    ;; プロジェクト相対パス文法チェック
    (unless (ede:syntax-check-relative-path ede:project-relative-include-path-list)
      (log-status "Phase Status" "syntax error => project relative include path")
      (cl-return-from ede:load-project nil))


    ;; コンパイラ指定があればプラットフォーム個別の設定を行う
    (log-status "Compiler" (symbol-name ede:project-compiler))
    (let ((info (ede:get-compiler-info ede:project-compiler)))
      (if info
          (progn
            ;; ede project 用にプラットフォームシステムインクルードパスを追加
            (ede:option-list-generator 'ede:project-system-include-path-list "%s" (ede:get-compiler-detail info 'includes))

            ;; flymake 用コンパイルコマンドを事前生成
            (ede:generate-compile-commands 'ede:project-compiler-command 'ede:project-compile-options info)
            )
        (log-status "flymake Status" "Disable => unknown compiler type")
        ))


    ;; flymake 用変数 make-local-variable でセットされる
    (add-to-list 'ede:project-local-variables `(flymake:enable . ,ede:project-flymake-enable))
    (add-to-list 'ede:project-local-variables `(flymake:use-makefile . ,ede:project-flymake-use-makefile))
    (add-to-list 'ede:project-local-variables `(flymake:compiler-command . ,ede:project-compiler-command))
    (add-to-list 'ede:project-local-variables `(flymake:compile-options . ,ede:project-compile-options))

    ;; ここは改良の余地あり、現在C/C++のみしかできないので、セットアップファイル側に language-typeを指定して選ばせる？
    (ede-cpp-root-project ede:project-name
                          :file (expand-file-name ede:project-file ede:path-project-root)
                          :directory ede:path-project-root
                          :include-path ede:project-relative-include-path-list
                          :system-include-path ede:project-system-include-path-list
                          :header-match-regexp ede:project-header-match-regexp
                          :spp-table ede:project-spp-table
                          :spp-files ede:project-spp-files
                          :local-variables ede:project-local-variables
                          )

    (log-status "Phase Status" "Success")
    (cl-return-from ede:load-project t)))




;;------------------------------------------------------------------------------
;; add hook
;;------------------------------------------------------------------------------


;; 初期化後にユーザー定義のプロジェクトファイルがあれば読み込む
(add-hook 'after-init-hook
          '(lambda ()
             (let ((selector (ede:convert-project-setup-file-rpath-to-path "active-project-selector.el")))
               (when (file-readable-p selector)
                 (load-library selector)))))






(provide 'cedet+flymake)
;;--------------------------------------------------------------------------------------------------
;; EOF
