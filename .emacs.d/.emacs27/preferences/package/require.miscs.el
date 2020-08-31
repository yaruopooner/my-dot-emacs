;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2018/06/29.20:14:35


;;==================================================================================================
;; require only modules                                                                                    
;;==================================================================================================


;; 最近使ったファイル履歴
(require 'recentf-ext)


(require 'all-ext)


;; imenu extend
;; (require 'imenu+)


;; バッファサマリ表示
;(require 'summarye)
;(global-set-key (kbd "C-x C-l") 'se/make-summary-buffer)



;; CSV Mode
(require 'csv-mode)


;; emacs GUI Menu の日本語化
;(require 'menu-tree)


;; Yahoo! JAPANには校正支援サービス
(require 'yspel)


;; powershell 
;; (require 'powershell)

;; (dolist feature '(powershell cmake)
;;         (when (featurep feature)
;;           (add-hook 'powershell-mode-hook
;;                     '(lambda ()
;;                        (linum-mode)))))

(when (require 'powershell)
  (add-hook 'powershell-mode-hook
            '(lambda ()
               (linum-mode))))


;; cmake
(when (require 'cmake-mode)
  (add-hook 'cmake-mode-hook
            '(lambda ()
               (linum-mode))))



;; P4V
(when (require 'p4)
  (setq p4-global-key-prefix (kbd "C-c p"))
  ;; (setq p4-global-key-prefix (default:C-c p))
  (setenv "P4CHARSET" "utf8")
  ;; (setenv "P4DIFF" "/usr/local/bin/diff -dupU8")
  (setenv "P4DIFF" "/usr/bin/diff -dupU8")
  ;; (setenv "P4MERGE" "/usr/local/bin/emerge.bat")
  (setenv "P4EDITGOR" "emacs")
  )


;; visual-regexp
;; (global-set-key (kbd "M-%") 'vr/query-replace)

;; magit mode
;; (setq magit-last-seen-setup-instructions "1.4.0")
(setq magit-uniquify-buffer-names nil)
(add-to-list 'process-coding-system-alist '("git" utf-8 . utf-8))
(add-hook 'git-commit-mode-hook
          '(lambda ()
             (set-buffer-file-coding-system 'utf-8)))
;; 本来は coding-system.config.el にて↓を有効化すればよいのだが、win環境で問題が発生するために個別設定
;; (prefer-coding-system 'utf-8)
;; (setq default-process-coding-system 'utf-8)


;; domain Mode
(require 'domain-mode)



(provide 'require.miscs)
;;--------------------------------------------------------------------------------------------------
;; EOF
