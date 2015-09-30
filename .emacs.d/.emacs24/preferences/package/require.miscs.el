;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2015/04/15.12:28:48


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

(setq magit-last-seen-setup-instructions "1.4.0")




(provide 'require.miscs)
;;--------------------------------------------------------------------------------------------------
;; EOF
