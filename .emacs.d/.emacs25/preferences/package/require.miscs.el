;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2017/12/05.19:06:10


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



(when (require 'p4)
  )

;; visual-regexp
;; (global-set-key (kbd "M-%") 'vr/query-replace)

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
