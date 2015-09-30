;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/09/04.04:54:21

;;==============================================================================
;; Version Controll                                                             
;;==============================================================================


;;------------------------------------------------------------------------------
;; Common Environment                                                           
;;------------------------------------------------------------------------------


;;------------------------------------------------------------------------------
;; Emacs 20.3 の VC-Dired モード                                                
;;------------------------------------------------------------------------------


;; vc package で使用されるシステム('RCS, 'CVS, 'SCCS)
(setq vc-default-back-end 'CVS)

;; バージョンナンバーとロック状態をモード行に表示
(setq vc-display-status t)

;; update 内容を commit 後にワークファイルを削除しない
(setq vc-keep-workfiles t)

;; バージョン管理作業を実行する前に確認を求めない
(setq vc-suppress-confirm nil)

;; バージョン管理されているファイルも Emacs 標準バックアップファイルを作成する
(setq vc-make-backup-files nil)

;; lock されてないファイルも表示する
(setq vc-dired-terse-display t)

;; ディレクトリを再帰的にたどらない
(setq vc-dired-recurse nil)



;; jserverの設定
;(setq jserver-list '("simba"))


;; info に新しいディレクトリーを加える方法
;; 変数 Info-directory-list を設定し
;; 
;; (setq Info-directory-list
;;       (list "c:/usr/local/info"
;;             "c:/Cygnus/B19/info"
;;             (expand-file-name (getenv "INFOPATH"))))

;; どのバージョンの Meadow であるかを調べる
;; (Meadow-version)
;; Meadow のバージョンを知る事ができ、
;; 変数 mule-version で MULE のバージョン
;; 変数 emacs-version で基となっている Emacs のバージョンを知る事ができる


;;------------------------------------------------------------------------------
;; Local Environment                                                            
;;------------------------------------------------------------------------------

(if nil
(let ((self-file-name "vc.config"))
    (deu:load-library-auto-select-platform-path self-file-name path-basic-configuration)
)
)





(provide 'vc.config)
;;------------------------------------------------------------------------------
;; EOF
