;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2021/03/23.12:43:54


;;==================================================================================================
;; anything setup                                                                                    
;;==================================================================================================


;; load path addition
;; (add-to-list 'load-path (expand-file-name "anything/" de:path-plugins))


(setq helm-source-occur nil)


;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


;; for compile warning
(eval-when-compile (require 'ibuffer))
;; (eval-when-compile (require 'all-ext))


(require 'helm)
(require 'helm-config)
;; (require 'helm-grep)

(require 'helm-descbinds)
(require 'helm-swoop)
(require 'helm-ls-git)
(require 'helm-c-yasnippet)



;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; (define-key emacs-lisp-mode-map "\C-\M-i" 'helm-lisp-complete-symbol-partial-match)
;; (define-key lisp-interaction-mode-map "\C-\M-i" 'helm-lisp-complete-symbol-partial-match)
;; Comment if you do not want to replace completion commands with `helm'.
;; M-x bind
(helm-mode 1)


;; １情報源に表示される最大候補数
(setq helm-candidate-number-limit 300)

;; canditate表示を改行せず切り詰める
(setq helm-truncate-lines t)

;; 打鍵から更新されるまでの遅延時間
(setq helm-input-idle-delay 0.1)

;; 同上( delayed )を指定した情報源に適用
(setq helm-idle-delay 0.3)

;; 表示されている情報源以外を delayed 扱いにする
(setq helm-quick-update nil)

;; 全ての kill-ring を表示
(setq helm-kill-ring-threshold 0)

;; helm-source-buffers-listにおけるバッファ名表示幅
(setq helm-buffer-max-length 100)

;; fuzzy match enable
(setq helm-M-x-fuzzy-match t)
(setq helm-buffers-fuzzy-matching t)
(setq helm-recentf-fuzzy-match t)
(setq helm-gtags-fuzzy-matching t)

;; disable helm command
(cl-dolist (exclude-func '(write-file
                           find-file
                           find-file-at-point
                           dired-do-copy
                           ediff
                           ediff-files
                           ediff-merge-files))
  (add-to-list 'helm-completing-read-handlers-alist `(,exclude-func . nil)))


;; helm-mini sources
(setq helm-mini-default-sources '(helm-source-buffers-list
                                  helm-source-ls-git
                                  helm-source-recentf
                                  helm-source-files-in-current-dir
                                  ;; helm-source-buffer-not-found
                                  ))

;; find-file自動補完を無効
(setq helm-ff-auto-update-initial-value nil)



;; helm-descbinds
(helm-descbinds-mode)



;; helm-swoop

;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)

;; 値がtの場合はウィンドウ内に分割、nilなら別のウィンドウを使用
(setq helm-swoop-split-with-multiple-windows nil)

;; ウィンドウ分割方向 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)

;; nilなら一覧のテキストカラーを失う代わりに、起動スピードをほんの少し上げる
(setq helm-swoop-speed-or-color t)



;; helm-ls-git

;; helm-source-ls-gitにおけるパス表示タイプ
(setq helm-ls-git-show-abs-or-relative 'relative)



;; helm-c-yasnippet

;; スペース区切りで絞り込めるようにする
(setq helm-yas-space-match-any-greedy t)




;;------------------------------------------------------------------------------
;; keybind
;;------------------------------------------------------------------------------


;; helm bind
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-a") 'helm-mini)
;; (require 'edebug)されると emacs-lisp-mode のC-x C-aが乗っ取られるのでそれを抑制する
(setq edebug-inhibit-emacs-lisp-mode-bindings t)

;; kill-ring extension
(global-set-key (kbd "C-x C-y") 'helm-show-kill-ring)

;; imenu extension
(global-set-key (kbd "C-x C-l") 'helm-imenu)



;; ミニバッファ入力時にEmacs標準 C-h, C-k を有効化
(define-key helm-map (kbd "C-h") nil)
(define-key helm-map (kbd "C-k") nil)

;; C-h, C-k を delete-backward-char にバインドしているのでhelm のヘルプを無効化
(define-key helm-find-files-map (kbd "C-h") nil)
(define-key helm-find-files-map (kbd "C-k") nil)


;; suspend-frame を無効化
;; helmではpreview操作で C-zを多用するが、マップされてないモードで C-zを押した場合、最小化されてウザイので無効化
(global-unset-key (kbd "C-z"))


;;  とりあえずどのマップにあるかわからない場合は以下で無効化

;; persistent-action を C-j ではなく C-z に割り当て
(define-key helm-map (kbd "C-j") nil)
(define-key helm-map (kbd "C-z") 'helm-execute-persistent-action)


;; isearch expand
;; (global-set-key (kbd "C-M-s") 'helm-c-moccur-isearch-forward)
;; (global-set-key (kbd "C-M-r") 'helm-c-moccur-isearch-backward)

;; 標準インクリメンタルサーチのキーバインドに追加
;; (define-key isearch-mode-map (kbd "C-o") 'helm-occur-from-isearch)
;; (define-key isearch-mode-map (kbd "C-M-o") 'isearch-occur)
;; (define-key helm-map (kbd "C-c C-a") 'all-from-helm-occur) 


;; helm-swoop
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

;; isearch実行中にhelm-swoopに移行
;; (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
(define-key isearch-mode-map (kbd "C-o") 'helm-swoop-from-isearch)

;; helm-swoop実行中にhelm-multi-swoop-allに移行
;; (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
(define-key helm-swoop-map (kbd "C-o") 'helm-multi-swoop-all-from-helm-swoop)


;; helm-c-yasnippet
(global-set-key (kbd "M-:") 'helm-yas-complete)





(provide 'setup.helm)
;;--------------------------------------------------------------------------------------------------
;; EOF
