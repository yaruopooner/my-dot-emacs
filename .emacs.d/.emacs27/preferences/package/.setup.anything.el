;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2014/10/03.02:08:01


;;==================================================================================================
;; anything setup                                                                                    
;;==================================================================================================


;; load path addition
;; (add-to-list 'load-path (expand-file-name "anything/" de:path-plugins))




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


;; for compile warning
(eval-when-compile (require 'ibuffer))


(require 'anything-startup)


(require 'anything-c-moccur)
(require 'anything-gtags)

;;; anything-show-completion.el shows current selection prettily.
(require 'anything-show-completion)

;;; descbinds-anything.el replaces describe-bindings with anything interface.
(when (require 'descbinds-anything nil t)
  ;; Comment if you do not want to replace `describe-bindings' with `anything'.
  (descbinds-anything-install))

;;; `anything-grep' replaces standard `grep' command.
(require 'anything-grep nil t)





;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


(define-key emacs-lisp-mode-map "\C-\M-i" 'anything-lisp-complete-symbol-partial-match)
(define-key lisp-interaction-mode-map "\C-\M-i" 'anything-lisp-complete-symbol-partial-match)
;; Comment if you do not want to replace completion commands with `anything'.
;; M-x bind
(anything-read-string-mode 1)


;; １情報源に表示される最大候補数
(setq anything-candidate-number-limit 300)

;; 打鍵から更新されるまでの遅延時間
(setq anything-input-idle-delay 0.1)

;; 同上( delayed )を指定した情報源に適用
(setq anything-idle-delay 0.3)

;; 表示されている情報源以外を delayed 扱いにする
(setq anything-quick-update nil)

;; 全ての kill-ring を表示
(setq anything-kill-ring-threshold 0)

;; gtags 実行時にジャンプ候補をファイル別表示
(setq anything-gtags-classify t)


;; ミニバッファ入力時に、Emacs標準 C-k を有効化
;; (define-key anything-map (kbd "C-k") nil)

;; C-h を delete-backward-char にバインドしているので、 anything のヘルプを無効化
;; (define-key anything-find-files-map (kbd "C-h") nil)


;;  とりあえずどのマップにあるかわからない場合は以下で無効化
(let (valid-maps)
  (cl-dolist (symbol '(
                    anything-c-bookmark-map
                    anything-read-file-name-map
                    anything-eshell-history-map
                    anything-c-buffer-map
                    anything-generic-files-map
                    anything-esh-on-file-map
                    anything-command-map
                    anything-c-read-file-map
                    anything-c-pdfgrep-map
                    anything-map
                    anything-eval-expression-map
                    anything-kill-ring-map
                    anything-local-map-override-anything-map
                    anything-occur-map
                    anything-find-files-map
                    anything-c-grep-map
                    anything-c-ucs-map
                    anything-c-moccur-anything-map
                    anything-c-etags-map
                    anything-ff-lynx-style-map
                    ))
    (when (keymapp (symbol-value symbol))
      (add-to-list 'valid-maps (symbol-value symbol))))

  (cl-dolist (map valid-maps)
    ;; ミニバッファ入力時に、Emacs標準 C-k を有効化
    (define-key map (kbd "C-k") 'nil)
    ;; C-h を delete-backward-char にバインドしているので、 anything のヘルプを無効化
    (define-key map (kbd "C-h") 'nil)
    ))
    


;; C-z を他のキーに割り当て
;; (define-key anything-map (kbd "C-;") 'anything-execute-persistent-action)
;; (define-key anything-map (kbd "M-;") 'anything-execute-persistent-action)




;; 絞り込みに対応した anything-occur
(defun anything-occur-x (&optional initial-pattern preselect-pattern)
  (interactive)
  (anything :sources 'anything-c-source-occur
            :input initial-pattern
            :buffer "*anything occur*"
            :preselect preselect-pattern
            :candidate-number-limit nil))


;; isearch 乗っ取り用 anything-occur
(defun anything-occur-x-from-isearch ()
  "Run `anything-c-source-occur-by-occur-x' with isearch string."
  (interactive)
  (isearch-exit)
  (anything-occur-x (anything-c-moccur-isearch-get-regexp) (format "^ *%d\:" (line-number-at-pos))))



;;------------------------------------------------------------------------------
;; global keybind
;;------------------------------------------------------------------------------


;; anything のバインド
(global-set-key (kbd "C-x C-a") 'anything)


;; yank 機能拡張： kill-ring バッファを参照できる
(global-set-key (kbd "C-x C-y") 'anything-show-kill-ring)


;; suspend-frame を無効化
;; anythingではpreview操作で C-zを多用するが、マップされてないモードで C-zを押した場合、最小化されてウザイので無効化
(global-unset-key (kbd "C-z"))


;; isearch-forward-regexp 乗っ取り
(global-set-key (kbd "C-M-s") 'anything-occur-x)
;; 標準インクリメンタルサーチのキーバインドに追加
(define-key isearch-mode-map (kbd "C-o") 'anything-occur-x-from-isearch)
(define-key isearch-mode-map (kbd "C-M-o") 'isearch-occur)



;;------------------------------------------------------------------------------
;; local keybind
;;------------------------------------------------------------------------------


;; binding : anything-imenu
(cl-dolist (target-mode '(
                          (c-mode-common-hook    . c-mode-map)
                          (c-mode-common-hook    . c++-mode-map)
                          ;; (c-mode-common-hook    . csharp-mode-map)
                          (java-mode-hook        . java-mode-map)
                          (emacs-lisp-mode-hook  . emacs-lisp-mode-map)
                          (lisp-mode-hook        . lisp-mode-map)
                          (lua-mode-hook         . lua-mode-map)
                          ))
  (add-hook (car target-mode) `(lambda () 
                                 (define-key ,(cdr target-mode) (kbd "C-x C-l") 'anything-imenu))))






(provide 'setup.anything)
;;--------------------------------------------------------------------------------------------------
;; EOF
