;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2014/10/30.14:41:23


;;==============================================================================
;; package setup
;;==============================================================================


(require 'package)





;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; パッケージ参照URL追加
;; (add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa"     . "http://melpa.milkbox.net/packages/"))

;; To fix MELPA problem.
(setq url-http-attempt-keepalives nil)

;; signature test pass(for gnu)
(setq package-check-signature nil)

;; パッケージインストールディレクトリ
;; (setq package-user-dir (expand-file-name ".packages" de:path-plugins))
(setq package-user-dir (expand-file-name "download/" de:path-packages))

;; インストールされたパッケージを有効化する(各パッケージパスなどもload-pathに追加される)
(package-initialize)




(provide 'package.config)
;;------------------------------------------------------------------------------
;; EOF
