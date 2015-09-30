;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/09/04.04:45:11

;;==============================================================================
;; Key Binding                                                                  
;;==============================================================================


;;------------------------------------------------------------------------------
;; Common Environment                                                           
;;------------------------------------------------------------------------------


;;------------------------------------------------------------------------------
;; デフォルトでバインドされているがユーザ側で変更したキー                       
;;                                                                              
;; 'M-x describe-bindings'コマンドでバインド一覧を表示して                      
;; 重複しないようにすること                                                     
;;
;; [o] : over write bind
;; [f] : free space bind
;;                                                                              
;; [f] C-h          :backspace                                                  
;;                                                                              
;;------------------------------------------------------------------------------
;; デフォルトで空いているキー                                                   
;; Emacs のデフォルト設定では、以下のキーには 機能（関数）を割り当てていません  
;; [-] : ユーザ側ではまだ未割り当て                                             
;; [f] : ユーザ側ですでに割り当て済み                                           
;;                                                                              
;; [f] C-\          :undo                                                       
;; [-] C-x c        :                                                           
;; [-] C-x p        :                                                           
;; [f] C-x t        :現在時間インサート                                         
;; [-] C-x w        :                                                           
;; [-] C-x y        :                                                           
;; [-] C-x z        :                                                           
;; [-] C-x C-a      :                                                           
;; [o] C-x C-b      :ibuffer
;; [f] C-x C-g      :grep-find                                                  
;; [-] C-x C-h      :                                                           
;; [-] C-x C-j      :                                                           
;; [f] C-x C-l      :[Plugin] navi 関数プロトタイプナビゲーター
;; [-] C-x C-m      :                                                           
;; [f] C-x C-y      :[Plugin] browse-yank[yank機能拡張版] kill-ring バッファを参照できる
;;                                                                              
;; [f] M-g          :行ジャンプ                                                 
;; [f] M-n          :画面スクロール上                                           
;; [-] M-o          :                                                           
;; [f] M-p          :画面スクロール下                                           
;; [-] M-s          :                                                           
;; [-] M-C-m        :                                                           
;; [-] M-C-q        :                                                           
;; [-] M-C-x        :                                                           
;; [-] M-C-y        :                                                           
;; [-] M-C-z        :                                                           
;;                                                                              
;; また、記号でもかまわなければ、以下のキーも空いています                       
;;                                                                              
;; [-] C-x 7        :                                                           
;; [-] C-x 8        :                                                           
;; [-] C-x 9        :                                                           
;; [f] C-x ~        :uncomment-region                                           
;; [-] C-x |        :                                                           
;; [f] C-x !        :comment-region                                             
;; [-] C-x "        :                                                           
;; [-] C-x #        :                                                           
;; [f] C-x %        :正規表現による置換                                         
;; [-] C-x &        :                                                           
;; [-] C-x @        :                                                           
;; [-] C-x          :                                                           
;; [-] C-x *        :                                                           
;; [-] C-x {        :                                                           
;; [-] C-x }        :                                                           
;; [-] C-x ?        :                                                           
;; [-] C-x \        :                                                           
;; [-] C-x _        :                                                           
;;                                                                              
;; [-] M- "         :                                                           
;; [-] M- &         :                                                           
;; [-] M- `         :                                                           
;; [-] M- +         :                                                           
;; [-] M- *         :                                                           
;; [f] M- ]         :リージョンを右へインデント                                 
;; [f] M- [         :リージョンを左へインデント                                 
;; [-] M- ?         :                                                           
;; [-] M- _         :                                                           
;;                                                                              
;; [-] f3           :                                                           
;; [f] f4           :ECB active/deactive                                        
;; [f] f5           :emacs wiki?                                                
;; [-] f6           :                                                           
;; [-] f7           :                                                           
;; [-] f8           :                                                           
;; [-] f9           :                                                           
;; [-] f10          :                                                           
;; [-] f11          :                                                           
;; [-] f12          :                                                           
;;                                                                              
;;------------------------------------------------------------------------------



;;-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
;; Default Function Overwrite Binding   
;;-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+


;; ibuffer : original > list-buffer
(global-set-key (kbd "C-x C-b") 'ibuffer)



;;-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
;; Default Function Free Binding        
;;-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+


;; Back Space
;; global-set-key だと，他の elisp で delete-backward-char が乗っ取られた時に BS キーとの整合が取れなくなる場合がある
;; 乗っ取られた場合は、その map を探し出し、再度 define-key する必要がある
;; できれば keyboard-translate のほうがいい．

(global-set-key (kbd "C-h") 'delete-backward-char)
;;(keyboard-translate ?\C-h ?\C-?)
;;(keyboard-translate ?\C-h ?\177)


;; 元々 C-h に割り当ててあったヘルプを他に割り当て
(global-set-key (kbd "C-x h") 'help-command)


;; grep-find
(global-set-key (kbd "C-x C-g") 'grep-find)

;; C-h に割り当てられている関数 help-command を C-x C-h に割り当てる
(global-set-key (kbd "C-x C-h") 'help-command)

;; 選択範囲をコメントする/コメントを外す
;; C-x ; to comment-off region
;; C-x : to remove comment-off region
(global-set-key (kbd "C-x !") 'comment-region)
(fset 'uncomment-region "\C-u\C-[xcomment-region\C-m")
(global-set-key (kbd "C-x ~") 'uncomment-region)

;; 正規表現による置換
(global-set-key (kbd "C-x %") 'query-replace-regexp)

;; 行ジャンプ
(global-set-key (kbd "M-g") 'goto-line)

;; 画面スクロール上(Page Up)
(global-set-key (kbd "M-n") 'scroll-up)

;; 画面スクロール下(Page Down)
(global-set-key (kbd "M-p") 'scroll-down)

;; リージョンを右へインデント
(global-set-key (kbd "M-]") 'increase-left-margin)

;; リージョンを左へインデント
(global-set-key (kbd "M-[") 'decrease-left-margin)

;; 現在時刻をカーソル位置に挿入
(defun insert-date ()
    "現在時刻をカーソル位置に挿入"
    (interactive)
    ;; (insert (current-time-string))
    (insert (format-time-string "%Y-%m-%d"))
    ;; (insert (format-time-string "%Y-%m-%d (%a) %H:%M"))
)
(global-set-key (kbd "C-x t") 'insert-date)

;(global-set-key [f1] 'other-window)
;(global-set-key [f3] 'compile)


;; 別のフレームへ
;(global-set-key (kbd "C-c o") 'other-frame)

;; DEL をデリートにする
;(global-set-key (kbd "010") 'delete-char)




;;------------------------------------------------------------------------------
;; Local Environment                                                            
;;------------------------------------------------------------------------------

(let ((self-file-name "key-binding.config"))
    (deu:load-library-auto-select-platform-path self-file-name path-basic-configuration)
)





(provide 'key-binding.config)
;;------------------------------------------------------------------------------
;; EOF
