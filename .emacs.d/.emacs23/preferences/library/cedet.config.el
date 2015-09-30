;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/09/04.04:56:02


;;==================================================================================================
;; CEDET(Collection of Emacs Development Environment Tools) setup                                   
;;==================================================================================================

;; 昔は plugin だったが Emacs 23.2から統合された



;;------------------------------------------------------------------------------
;; prepare variable setting                                                           
;;------------------------------------------------------------------------------


;; Configuration variables here:
(setq semantic-load-turn-useful-things-on t)
(setq semantic-load-turn-everything-on t)

;; ロード前設定が必要な変数, defcustom系変数
(setq semantic-default-submodes
      '(
	;; Semanticデータベース
	global-semanticdb-minor-mode
	;; アイドルタイムにsemantic-add-system-includeで追加されたパスグループを再解析
	global-semantic-idle-scheduler-mode
	;; タグのサマリを表示
	global-semantic-idle-summary-mode
	;; タグの補完を表示(plugin auto-completeでac-source-semanticを使うのでdisable)
	;global-semantic-idle-completions-mode
	;; タグを装飾
	global-semantic-decoration-mode
	;; 現在カーソルでポイントされているfunctionの宣言をハイライト
	global-semantic-highlight-func-mode
	;; ?
	global-semantic-mru-bookmark-mode
	;; ?
	global-semantic-stickyfunc-mode
	)
)


;; アイドルタイムにsemantic-add-system-includeで追加されたパスグループをパースする
(setq semantic-idle-work-update-headers-flag t)



;;------------------------------------------------------------------------------
;; load & enable modules                                                        
;;------------------------------------------------------------------------------


;; Load CEDET
(require 'cedet)




;; プロジェクト管理：有効化
;; Enable the Project management system(Emacs Development Environment)
(global-ede-mode 1)


;; セマンティック：有効化
;; !!!!!!!重要!!!!!!!
;; これを実行する前に semantic 関連のパラメーターは必ずセットしておく事
;; Enable Semantic Mode
(semantic-mode 1)


;; !!!!!!!重要!!!!!!!
;; 必ず ede => semantic の順番で有効化する事
;; 逆になったりすると ede-cpp-root-projectなどがうまく動作しない
;; エラーなどが一切で出力されないので、わかりずらいが
;; :include-path や :system-include-path などが設定されているにもかかわらず
;; semantic.cache が生成されない


;;------------------------------------------------------------------------------
;; ede                                                           
;;------------------------------------------------------------------------------




;;------------------------------------------------------------------------------
;; semantic                                                           
;;------------------------------------------------------------------------------


(setq semanticdb-project-roots '("~/"))
;; semantic cache files location(指定パスに生成されたcacheファイルが置かれる, 指定がない場合は ~/.emacs.d/semanticdb)
;(setq semanticdb-default-save-directory "~/.semanticdb")

;; semantic database生成用にパースさせるプロジェクトルートディレクトリを設定
(semantic-add-system-include "/usr/include" 'c-mode)
(semantic-add-system-include "/usr/share/include" 'c-mode)
(semantic-add-system-include "/usr/local/include" 'c-mode)
(semantic-add-system-include "/usr/include" 'c++-mode)
(semantic-add-system-include "/usr/share/include" 'c++-mode)
(semantic-add-system-include "/usr/local/include" 'c++-mode)


;(setq ac-sources (append ac-sources '(ac-source-semantic)))
;(setq ac-sources '(ac-source-semantic))





;;------------------------------------------------------------------------------
;; speedbar                                                           
;;------------------------------------------------------------------------------


;; speedbar フレーム設定
(custom-set-variables
 '(speedbar-frame-parameters
    '(
      (minibuffer)
      (width . 50)
      (border-width . 0)
      (menu-bar-lines . 0)
      (tool-bar-lines . 0)
      (unsplittable . t)
      (left-fringe . 0)
      )
   )
 )


;; speedbar automatic update
;(speedbar-toggle-updates)


;(require 'semantic-imenu)

;(setq semantic-imenu-summary-function
;      (lambda (tag)
;        (semantic-format-tag-summarize tag nil t)))

;; セットアップファイルがおいてある場所（標準）
(defvar cedet:ede-project-setup-files-default-path (expand-file-name "ede-project-setup-files/" de:path-dot-emacs-root))

(defvar cedet:ede-project-name "new cpp project")
(defvar cedet:ede-project-file "/Project.ede")

;; プロジェクトでのflymake有効化
(defvar cedet:ede-project-flymake-enable nil)

;; Makefileの利用選択 t:する、nil:しない
(defvar cedet:ede-project-flymake-use-makefile nil)

;; 'gcc
;; 'g++
;; 'ppu-g++
;; 'spu-g++
;; 'vc
(defvar cedet:ede-project-compiler nil)
;; コンパイラに渡す直前の展開済みオプション文字列
(defvar cedet:ede-project-compile-options nil)
;; コンパイラに直接渡すオプション
(defvar cedet:ede-project-compile-immediate-option-list nil)


(defvar cedet:ede-project-root-path nil)

(defvar cedet:ede-project-system-include-path-list nil)
(defvar cedet:ede-project-include-path-list nil)

(defvar cedet:ede-project-define-list nil)

(defvar cedet:ede-project-header-match-regexp "\\.\\(h\\(h\\|xx\\|pp\\|\\+\\+\\)?\\|H\\)$\\|\\<\\w+$")

;; convert default-path + setup-file-name
(defun cedet:ede-project-setup-file-path-convert-to-absolute (relative-path)
  (expand-file-name relative-path cedet:ede-project-setup-files-default-path)
  )



;; project root path がアクセス可能なディレクトリのときだけプロジェクトをロードする

;;;###autoload
(defun cedet:ede-project-load (ede-project-setup-file-path)
  (interactive
   (list (read-file-name "EDE Project Setup File :" cedet:ede-project-setup-files-default-path nil t))
   )

  (message "[EDE Project Setup]")

  ;; variables initialize
  (setq cedet:ede-project-name "new project")
  (setq cedet:ede-project-file "/Project.ede")

  (setq cedet:ede-project-flymake-enable nil)
  (setq cedet:ede-project-flymake-use-makefile nil)

  (setq cedet:ede-project-compiler nil)
  (setq cedet:ede-project-compile-options nil)
  (setq cedet:ede-project-compile-immediate-option-list nil)


  (setq cedet:ede-project-root-path nil)

  (setq cedet:ede-project-system-include-path-list nil)
  (setq cedet:ede-project-include-path-list nil)

  (setq cedet:ede-project-define-list nil)

  ;(setq cedet:ede-project-header-match-regexp "\\.\\(h\\(h\\|xx\\|pp\\|\\+\\+\\)?\\|H\\)$\\|\\<\\w+$")
  (setq cedet:ede-project-header-match-regexp "\\.\\(h\\(h\\|xx\\|pp\\|\\+\\+\\)?\\|H\\|inl\\)$\\|\\<\\w+$")


  ;; load project setup file 

  ;; relative path check 
  (unless (file-name-absolute-p ede-project-setup-file-path)
    ;; convert to absolute path
    (setq ede-project-setup-file-path (cedet:ede-project-setup-file-path-convert-to-absolute ede-project-setup-file-path))
    )
  (message "  Setup File : %s" ede-project-setup-file-path)

  ;; ファイル存在チェック
  (if (file-readable-p ede-project-setup-file-path)
      (progn
	;; あればロード
	(load-library ede-project-setup-file-path)

	(message "  Load Status : Success")


	;; activate a project

	;; プロジェクトファイルが存在した場合は cedet:ede-project-root-path がセットされているハズ
	;; セットされたパスが正しいかをチェックして、正しければプロジェクトを生成

	;; ルートパスがnilでないか
	(if (stringp cedet:ede-project-root-path)
	    (progn
	      ;; パスがアクセス可能か（存在するか）
	      (if (file-accessible-directory-p cedet:ede-project-root-path)
		  (progn
		    ;; ここは改良の余地あり、現在c++のみしかできないので、セットアップファイル側に language-typeを指定して選ばせる？
		    (ede-cpp-root-project cedet:ede-project-name
					  :file (concat cedet:ede-project-root-path cedet:ede-project-file)
					  :directory cedet:ede-project-root-path
					  :include-path cedet:ede-project-include-path-list
					  :system-include-path cedet:ede-project-system-include-path-list
					  :header-match-regexp cedet:ede-project-header-match-regexp
					  )
		    (message "  Setup Status : Active")
		    )
		(progn
		  (message "  Setup Status : Invalid Project Root Path")
		  )
		)
	      )
	  (progn
	    (message "  Setup Status : Empty Root Path Strings")
	    )
	  )
	(message "  Project Name : %s" cedet:ede-project-name)
	(message "  Project Root Path : %s" cedet:ede-project-root-path)


	)
    (progn
      ;; なければエラー報告
      (message "  Load Status : Not Found")
      )
    )

)




;; 初期化後にユーザー定義のプロジェクトファイルがあれば読み込む
(add-hook 'after-init-hook  '(lambda ()
			       (let ((active-project-selector-file (cedet:ede-project-setup-file-path-convert-to-absolute "active-project-selector.el")))
				 (when (file-readable-p active-project-selector-file)
				   (load-library active-project-selector-file)
				   )
				 )
			       )
	  )





(provide 'cedet.config)
;;--------------------------------------------------------------------------------------------------
;; EOF
