;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2013/01/24.20:23:55


;;==============================================================================
;; Basic Configuration Finalize Setting
;;==============================================================================



;;------------------------------------------------------------------------------
;; Common Environment                                                           
;;------------------------------------------------------------------------------


;; 起動時と起動後のフレーム設定を同一化
;; basic.config 内で全パラメーターが default-frame-alist にセットされてからでないとコピーできない
;; initial-frame-alist : 起動時のウィンドウサイズやフォント情報
;; default-frame-alist : 起動後に新しく作るウィンドウサイズやフォント情報
(setq initial-frame-alist default-frame-alist)



;; windows-XP-x64において発生する問題を回避するために入れた
;; flymake動作中にemacsをバックグラウンドにしていると、
;; "buffer has a running proccess kill it?" のダイアログが何度も表示されて鬱陶しいので
;; 警告表示をadd-hook削除。、暫定対処。 windows7-x64では発生していないはず
(setq kill-buffer-query-functions
      (remove 'process-kill-buffer-query-function kill-buffer-query-functions)
      )




;;------------------------------------------------------------------------------
;; Local Environment                                                            
;;------------------------------------------------------------------------------





(provide 'basic-config-finalize)
;;------------------------------------------------------------------------------
;; EOF
