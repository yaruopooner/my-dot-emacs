;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2020/09/09.02:17:20


;;==================================================================================================
;; cedet setup                                                                                      
;;==================================================================================================


;; 昔は plugin だったが Emacs に取り込まれた

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
        ))


;; アイドルタイムにsemantic-add-system-includeで追加されたパスグループをパースする
(setq semantic-idle-work-update-headers-flag t)



;; Load CEDET
;; add-to-list ではなくsetqでリスト先頭に追加して、こちらからのロードを優先させる


;; (load-library "cedet")
;; (require 'cedet)
;; (add-to-list 'load-path (expand-file-name "cedet-1.0/" de:path-plugins))
(load-library "common/cedet")


;; speedbar automatic update
;; (speedbar-toggle-updates)


;; (semantic-mode 1)
;; (setq ac-sources (append ac-sources '(ac-source-semantic)))
;; (setq ac-sources '(ac-source-semantic))


;; Smart Completion

;; Enable the Project management system
(global-ede-mode 1)
(semantic-load-enable-code-helpers)
(global-srecode-minor-mode 1)


;; speedbar フレーム設定
(setq speedbar-frame-parameters
      (append
       (list
        '(width . 50)
        )
       speedbar-frame-parameters))
      

;; (setq speedbar-frame-parameters '(((minibuffer) (width . 40) (border-width . 0) (menu-bar-lines . 0) (tool-bar-lines . 0) (unsplittable . t) (left-fringe . 0))))


;; (require 'semantic-imenu)

;; (setq semantic-imenu-summary-function
;;       (lambda (tag)
;;         (semantic-format-tag-summarize tag nil t)))



(setq semanticdb-project-roots '("~/"))

;; semantic database生成用にパースさせるプロジェクトルートディレクトリを設定
(semantic-add-system-include "/usr/include" 'c-mode)
(semantic-add-system-include "/usr/share/include" 'c-mode)
(semantic-add-system-include "/usr/local/include" 'c-mode)
(semantic-add-system-include "/usr/include" 'c++-mode)
(semantic-add-system-include "/usr/share/include" 'c++-mode)
(semantic-add-system-include "/usr/local/include" 'c++-mode)
(semantic-add-system-include "~/animation_state_transition20090712/animation_state_transition20090710" 'c++-mode)
(semantic-add-system-include "~/../tmp/xFramework20110715/xFramework" 'c++-mode)



;; cc-mode時に有効化
;; (add-hook 'c-mode-common-hook '(lambda ()
;;                                  (global-semantic-idle-summary-mode 1)
;;                                  (global-semantic-highlight-func-mode 1)
;;                                  (global-semantic-idle-completions-mode 1)
;;                                  )
;;           )

;; (load-library "c:/cygwin/tmp/xFramework20110715/xFramework/Project.ede")




(provide 'setup.cedet)
;;--------------------------------------------------------------------------------------------------
;; EOF
