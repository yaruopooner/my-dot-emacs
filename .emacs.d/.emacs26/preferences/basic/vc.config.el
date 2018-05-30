;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2013/04/20.19:39:00


;;==============================================================================
;; Version Controll                                                             
;;==============================================================================



;; バージョンナンバーとロック状態をモード行に表示
(setq vc-display-status t)

;; update 内容を commit 後にワークファイルを削除しない
(setq vc-keep-workfiles t)

;; バージョン管理作業を実行する前に確認を求めない
(setq vc-suppress-confirm nil)

;; バージョン管理されているファイルも Emacs 標準バックアップファイルを作成する
(setq vc-make-backup-files nil)





;;------------------------------------------------------------------------------
;; Local Environment                                                            
;;------------------------------------------------------------------------------

(if nil
    (let ((self-file-name "vc.config"))
      (deu:load-library-auto-select-platform-path self-file-name de:path-basic-configuration)
      ))





(provide 'vc.config)
;;------------------------------------------------------------------------------
;; EOF
