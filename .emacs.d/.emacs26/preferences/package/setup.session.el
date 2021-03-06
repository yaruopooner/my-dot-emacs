;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2014/10/13.19:34:32


;;==================================================================================================
;; session setup                                                                                    
;;==================================================================================================




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


(require 'session nil t)





;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------



;; emacs.el実行中にシンボル評価を行うと、未登録のシンボルが存在してしまうため
;; このセットアップは全pluginsなどがシンボルテーブルに登録された後で実行しければならない
(add-hook 'after-init-hook
          '(lambda ()
             ;; session restore target
             (setq session-initialize '(de-saveplace session keys menus))

             ;; record max
             (setq session-globals-include '(
                                             (kill-ring 50)
                                             (session-file-alist 100 t)
                                             (file-name-history 100)
                                             ))

             ;; exclude target
             ;; anything系は除外しておかないとおかしなことになる
             ;; session-globals-regexpに設定されているマッチング設定だと
             ;; anything-source は anything-c-source-mark-ring, anything-c-source-kill-ring などが対象になってしまうので除外する
             ;; この評価を行う時点で anything シンボルが登録されていないとダメ
             (setq session-globals-exclude `(
                                             ,@(apropos-internal (concat "^anything.*" session-globals-regexp) 'boundp)
                                             ,@(apropos-internal (concat "^helm.*" session-globals-regexp) 'boundp)
                                             ))

             ;; for helm-show-kill-ring
             (setq session-save-print-spec '(t nil 40000))

             ;; initialize
             (session-initialize)))






(provide 'setup.session)
;;--------------------------------------------------------------------------------------------------
;; EOF
