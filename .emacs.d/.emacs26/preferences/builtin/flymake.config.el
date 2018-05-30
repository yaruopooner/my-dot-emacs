;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2017/12/12.17:27:28


;;==============================================================================
;; flymake setup
;;==============================================================================


(require 'flymake)





;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; flymake を許可するモードのフックを指定
(defconst flymake:hook-list '(c-mode-common-hook
                              lua-mode-hook))



;; GUIの警告は表示しない
(setq flymake-gui-warnings-enabled nil)

;; 文法チェックの頻度の設定
(setq flymake-no-changes-timeout 0.5)

;; 改行時に文法チェックを行うかどうかの設定
(setq flymake-start-syntax-check-on-newline nil)

;; ログの出力を制御
;; Logging level, only messages with level lower or equal will be logged.
;; -1 = NONE, 0 = ERROR, 1 = WARNING, 2 = INFO, 3 = DEBUG
(setq flymake-log-level 0)


;; 全てのファイルで flymakeを有効化
;; (add-hook 'find-file-hook 'flymake-find-file-hook)



;; defvaralias / make-variable-buffer-local / make-local-variable とか使ったほうがいいのかな？
;; ede-cpp-root-project の local-variables を使用すると make-local-variable になる

;; hook時にflymakeの有効化をコントロールさせる
(defvar flymake:enable nil)

;; makefile を使用するかどうか
(defvar flymake:use-makefile nil)

;; コンパイラ実行ファイル名を指定
(defvar flymake:compiler-command nil)

;; コンパイラに渡すオプションリスト
(defvar flymake:compile-options nil)





;; コンパイラ＋オプションを受け取り、コンパイラ＋オプション＋ターゲットファイルのリストを生成
(defun flymake:compile-command-generator (compiler options)
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))

    ;; (message "buffer-file-name > %s" (buffer-file-name))
    ;; (message "temp-file > %s" temp-file)
    ;; (message "local-file > %s" local-file)
    ;; (message "(file-name-directory buffer-file-name) > %s" (file-name-directory buffer-file-name))
    ;; (message "1:%s" (list compiler (append options (list local-file))))
    ;; (message "2:%s" (list compiler `(,@options ,local-file)))
    ;;    (list compiler (append options (list local-file)))
    ;;(list compiler `(,@(symbol-value options) ,local-file))
    (list compiler `(,@options ,local-file))
    ))




;; Makefileがない場合は直接コマンドラインを生成する
(defun flymake:generate-command-line (compiler options)
  ;; (message "flymake:command-generator >> cmd = %s : result-options %s" compiler result-options)

  ;;(message (format "on flymake:command-generator %s %s" compiler options))
  ;; Makefileを使用する場合は、ファイルの有無をチェック
  (let ((use-makefile flymake:use-makefile))
    (when use-makefile
      (setq use-makefile (file-exists-p "Makefile"))
      )

    (if (null use-makefile)
        (progn 
          ;;(message "not use Makefile!!")
          (flymake:compile-command-generator compiler options)
          )
      (progn
        ;;(message "find Makefile!!")
        (flymake-simple-make-init)
        ))))




(defun flymake:init-c-common ()
  (flymake:generate-command-line flymake:compiler-command flymake:compile-options))


(add-to-list 'flymake-allowed-file-name-masks '("\\.cpp\\'" flymake:init-c-common))




;; error : Minibuf に出力
(defun flymake:display-current-line-err-by-minibuf ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no (line-number-at-pos))
         (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count (length line-err-info-list)))
    (while (> count 0)
      (when line-err-info-list
        (let* ((text (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line (flymake-ler-line (nth (1- count) line-err-info-list))))
          (message "[%s] %s" line text)))
      (setq count (1- count)))))


;; error : popup.el(plugins/auto-complete に含まれている)のpopup-tipsで表示
(defun flymake:display-current-line-err-by-popup ()
  "Display a menu with errors/warnings for current line if it has errors and/or warnings."
  (interactive)
  (let* ((line-no (line-number-at-pos))
         (errors (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (texts (mapconcat (lambda (x) (flymake-ler-text x)) errors "\n")))
    (when texts
      (popup-tip texts))))


;; popup が存在する場合だけ使用
(defun flymake:display-current-line-err ()
  "Displays the error/warning for the current line"
  (interactive)

  (if (featurep 'popup)
      (flymake:display-current-line-err-by-popup)
    (flymake:display-current-line-err-by-minibuf)))


(defun flymake:display-prev-error ()
  (interactive)
  
  (flymake-goto-prev-error)
  (flymake:display-current-line-err))


(defun flymake:display-next-error ()
  (interactive)
  
  (flymake-goto-next-error)
  (flymake:display-current-line-err))



(defun flymake:hook-functions ()
  ;; 新規作成バッファでファイルとして一度も保存されていない場合はflymake回避(主にorg-modeのソースコードセクションに対する対策)
  (when buffer-file-name
    ;; (message "check flymake")
    (when flymake:enable
      ;; (message "flymake enable")
      (flymake-mode t))

    ;;(local-set-key (kbd "C-<") 'flymake-goto-prev-error)
    ;;(local-set-key (kbd "C->") 'flymake-goto-next-error)
    ;; (local-set-key (kbd "M-[") 'flymake-goto-prev-error)
    ;; (local-set-key (kbd "M-]") 'flymake-goto-next-error)
    ;; (local-set-key (kbd "C-c d") '(lambda ()
    ;;                     (interactive)
    ;;                     ;;(flymake:display-err-minibuf-for-current-line)
    ;;                     (flymake:display-err-popup-for-current-line)
    ;;                     ))

    ;; カーソル移動と同時に表示
    (local-set-key (kbd "M-[") #'flymake:display-prev-error)
    (local-set-key (kbd "M-]") #'flymake:display-next-error)))





;;------------------------------------------------------------------------------
;; add hook                                                                     
;;------------------------------------------------------------------------------


;; リストに記述されているモードにのみ適用
(cl-dolist (hook flymake:hook-list)
  (add-hook hook 'flymake:hook-functions))






(provide 'flymake.config)
;;------------------------------------------------------------------------------
;; EOF
