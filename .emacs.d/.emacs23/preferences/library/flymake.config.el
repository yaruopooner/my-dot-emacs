;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/09/04.04:56:02


;;==============================================================================
;; flymake
;;==============================================================================


(require 'flymake)




;; GUIの警告は表示しない
(setq flymake-gui-warnings-enabled nil)

;; 文法チェックの頻度の設定
(setq flymake-no-changes-timeout 0.5)

;; 改行時に文法チェックを行うかどうかの設定
(setq flymake-start-syntax-check-on-newline nil)



;; 全てのファイルで flymakeを有効化
;(add-hook 'find-file-hook 'flymake-find-file-hook)


;; コマンド＋オプションを受け取り、コマンド＋オプション＋ターゲットファイルのリストを生成
(defun flymake-simple-generic-init (command &optional options)
  (let* (
	 (temp-file (flymake-init-create-temp-buffer-copy
		     'flymake-create-temp-inplace))
	 (local-file (file-relative-name
		      temp-file
		      (file-name-directory buffer-file-name)))
	 )

    ;; (message "buffer-file-name > %s" (buffer-file-name))
    ;; (message "temp-file > %s" temp-file)
    ;; (message "local-file > %s" local-file)
    ;; (message "(file-name-directory buffer-file-name) > %s" (file-name-directory buffer-file-name))
    ;; (message "1:%s" (list command (append options (list local-file))))
    ;; (message "2:%s" (list command `(,@options ,local-file)))
    ;;    (list command (append options (list local-file)))
    (list command `(,@options ,local-file))
    )
  )


;; Makefileがない場合は直接コマンドを実行
(defun flymake-simple-make-or-generic-init (command &optional options)
;  (message "flymake-simple-make-or-generic-init >> cmd = %s : options %s" command options)

  ;; Makefileを使用する場合は、ファイルの有無をチェック
  (let ((use-makefile cedet:ede-project-flymake-use-makefile))
    (unless (null use-makefile)
	(setq use-makefile (file-exists-p "Makefile"))
      )

    (if (null use-makefile)
	(progn 
;	  (message "not use Makefile!!")
	  (flymake-simple-generic-init command options)
	  )
      (progn
;	(message "find Makefile!!")
	(flymake-simple-make-init)
	)
      )

    )
  )




(defun flymake-gcc-init ()
  (flymake-simple-make-or-generic-init "gcc-4" '("-Wall" "-Wextra" "-pedantic" "-fsyntax-only"))
)


(defun flymake-g++-init ()
  (flymake-simple-make-or-generic-init "g++-4" '("-Wall" "-Wextra" "-pedantic" "-fsyntax-only"))
)


(defun flymake-ppu-g++-init ()
  (when (null cedet:ede-project-compile-options)
    ;; system path
    (dolist (arg cedet:ede-project-system-include-path-list)
      (add-to-list 'cedet:ede-project-compile-options (concat "-I" arg))
      )
    ;; project path
    (dolist (arg cedet:ede-project-include-path-list)
      (add-to-list 'cedet:ede-project-compile-options (concat "-I" arg))
      )
    ;; define
    (dolist (arg cedet:ede-project-define-list)
      (add-to-list 'cedet:ede-project-compile-options (concat "-D" arg))
      )
    ;; immediate options
    (dolist (arg cedet:ede-project-compile-immediate-option-list)
      (add-to-list 'cedet:ede-project-compile-options arg)
      )

;;    (message "inc list %s" cedet:ede-project-compile-options)

    )
;;  (flymake-simple-make-or-generic-init "ppu-lv2-g++" `("-Wall" "-Wextra" "-pedantic" "-fsyntax-only" ,@cedet:ede-project-compile-options))
  (flymake-simple-make-or-generic-init (substitute-in-file-name "${CELL_SDK}/host-win32/ppu/bin/ppu-lv2-g++") `("-Wall" "-fsyntax-only" ,@cedet:ede-project-compile-options))
)


(defun flymake-vc-init ()
  (when (null cedet:ede-project-compile-options)
;    (setq default-process-coding-system 'sjis-dos)
;    (set-process-coding-system '(sjis-dos . sjis-dos))
;    (set-process-coding-system 'sjis-dos)
    
    (add-to-list 'cedet:ede-project-compile-options (substitute-in-file-name "/I\"${VC_INCLUDE_PATH}/include\""))
    (add-to-list 'cedet:ede-project-compile-options (substitute-in-file-name "/I\"${WINDOWS_SDK_INCLUDE_PATH}/include\""))
    (add-to-list 'cedet:ede-project-compile-options (substitute-in-file-name "/I\"${FRAMEWORK_SDK_INCLUDE_PATH}/include\""))

    )
  
  (flymake-simple-make-or-generic-init "cl" `("/nologo" "/W4" "/Zs" ,@cedet:ede-project-compile-options))
)



(defun flymake-c-common-init ()
  (cond
   ((eq cedet:ede-project-compiler 'gcc)
    (flymake-gcc-init)
    )
   ((eq cedet:ede-project-compiler 'g++)
    (flymake-g++-init)
    )
   ((eq cedet:ede-project-compiler 'ppu-g++)
    (flymake-ppu-g++-init)
    )
   ((eq cedet:ede-project-compiler 'vc)
    (flymake-vc-init)
    )
   (t
    (ignore)
    )
    )
)



(add-to-list 'flymake-allowed-file-name-masks '("\\.cpp\\'" flymake-c-common-init))




;; error : Minibuf に出力
(defun my-flymake-display-err-minibuf-for-current-line ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no            (flymake-current-line-no))
         (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count              (length line-err-info-list)))
    (while (> count 0)
      (when line-err-info-list
        (let* ((text       (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
          (message "[%s] %s" line text)))
      (setq count (1- count))))
  )


;; error : popup.el(plugins/auto-complete に含まれている)のpopup-tipsで表示する。
(defun my-flymake-display-err-popup.el-for-current-line ()
  "Display a menu with errors/warnings for current line if it has errors and/or warnings."
  (interactive)
  (let* ((line-no            (flymake-current-line-no))
         (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (menu-data          (flymake-make-err-menu-data line-no line-err-info-list)))
    (if menu-data
	(popup-tip (mapconcat '(lambda (e) (nth 0 e))
			      (nth 1 menu-data)
			      "\n")))
    )
  )




(defun flymake-mode-hook-functions ()
  ;; 新規作成バッファでファイルとして一度も保存されていない場合はflymake回避(主にorg-modeのソースコードセクションに対する対策)
  (when buffer-file-name
    (when cedet:ede-project-flymake-enable
      (flymake-mode t)
      )
    ;;(local-set-key (kbd "C-<") 'flymake-goto-prev-error)
    ;;(local-set-key (kbd "C->") 'flymake-goto-next-error)
    (local-set-key (kbd "M-[") 'flymake-goto-prev-error)
    (local-set-key (kbd "M-]") 'flymake-goto-next-error)
    (local-set-key (kbd "C-c d") '(lambda ()
				    (interactive)
				    ;;(my-flymake-display-err-minibuf-for-current-line)
				    (my-flymake-display-err-popup.el-for-current-line)
				    ))
    )

)





;;------------------------------------------------------------------------------
;; add hook                                                                     
;;------------------------------------------------------------------------------


(add-hook 'c-mode-common-hook 'flymake-mode-hook-functions)






(provide 'flymake.config)
;;------------------------------------------------------------------------------
;; EOF
