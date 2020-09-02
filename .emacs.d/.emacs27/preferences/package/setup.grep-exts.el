;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2013/01/24.20:55:26


;;==================================================================================================
;; grep extensions Setup                                                                            
;;==================================================================================================




;;------------------------------------------------------------------------------
;; Load                                                                         
;;------------------------------------------------------------------------------


;; grep-a-lot
(require 'grep-a-lot)

;; wgrep
(require 'wgrep)




;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------




;;------------------------------------------------------------------------------
;; local keybind
;;------------------------------------------------------------------------------


;; 以下のように設定
;; grep-mode
;;  r        wgrep-mode へ移行
;;  C-x C-s  wgrep-mode で編集結果を適用(C-c C-c)しており、該当バッファが未保存であれば保存
;; wgrep-mode 時
;;  C-c C-c バッファへ編集結果を適用(デフォルト)
;;  C-x C-s バッファへ編集結果を適用後、該当バッファを保存


;; * To save buffer automatically when `wgrep-finish-edit'.
;; (setq wgrep-auto-save-buffer t)
;; 常時有効にせず、このキーバインド実行時だけ有効にする
(define-key wgrep-mode-map (kbd "C-x C-s") '(lambda () (interactive) (let ((wgrep-auto-save-buffer t)) (wgrep-finish-edit))))

;; * You can change the default key binding to switch to wgrep.
;; grep-mode > wgrep-mode への移行
(setq wgrep-enable-key "r")

;; * To apply all changes wheather or not buffer is read-only.
;; (setq wgrep-change-readonly-file t)

;; バッファ編集適用後の一括保存を grep-mode でバインド
(define-key grep-mode-map (kbd "C-x C-s") 'wgrep-save-all-buffers)





(provide 'setup.grep-exts)
;;--------------------------------------------------------------------------------------------------
;; EOF
