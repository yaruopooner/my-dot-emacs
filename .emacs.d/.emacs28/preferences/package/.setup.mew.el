;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2013/01/24.20:56:32


;;==================================================================================================
;; mew setup                                                                                    
;;==================================================================================================


;; load path addition
(add-to-list 'load-path (expand-file-name "mew/" de:path-plugins))



;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


(eval-when-compile (require 'mew))


(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)





;;------------------------------------------------------------------------------
;; basic setting                                                                         
;;------------------------------------------------------------------------------


;; Optional setup (Read Mail menu):
(setq read-mail-command 'mew)

;; Optional setup (e.g. C-xm for sending a message):
(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'mew-user-agent
      'mew-user-agent-compose
      'mew-draft-send-message
      'mew-draft-kill
      'mew-send-hook))



;; 起動画面表示なし
(setq mew-demo nil)


;; Mew の起動時にはメールを取得しないようにする設定
;; (setq mew-auto-get nil)

;; メールの取得後、POPサーバにあるメールを残す設定
(setq mew-pop-delete nil)


;; 1.パスワードをメモリに一時的に蓄える。ファイルには書き出さない。
;; 2.パスワードをメモリに Mew が起動している間中蓄える。Mew/Emacs の終了時に、パスワードを暗号化しファイルに書き出す。 

;; 1. の機能を利用するには、以下のように設定します。
(setq mew-use-cached-passwd t)

;; 2. の機能を利用するには、GnuPG をインストールした後、以下のように設定し ます。
(setq mew-use-master-passwd nil)







(provide 'setup.mew)
;;--------------------------------------------------------------------------------------------------
;; EOF
