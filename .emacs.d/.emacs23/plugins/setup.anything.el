;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/04/18.17:32:04


;;==================================================================================================
;; anything setup                                                                                    
;;==================================================================================================


;; load path addition
(add-to-list 'load-path (expand-file-name "anything/" path-plugins))




;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


;(require 'anything-config)
(require 'anything-startup)


(require 'anything-c-moccur)

(require 'anything-grep)

(require 'anything-gtags)





;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; １情報源に表示される最大候補数
(setq anything-candidate-number-limit 300)

;; 打鍵から更新されるまでの遅延時間
(setq anything-input-idle-delay 0.1)

;; 同上( delayed )を指定した情報源に適用
(setq anything-idle-delay 0.3)

;; 表示されている情報源以外を delayed 扱いにする
(setq anything-quick-update nil)

;; 全ての kill-ring を表示
(setq anything-kill-ring-threshold 0)



;;------------------------------------------------------------------------------
;; add anyting functions
;;------------------------------------------------------------------------------


;; describe-function/describe-variable の anything 版
(defmacro make-anything-c-source (valname pred action)
  `(setq ,valname
         (quote (
		 (name . "candidate")
                 (candidates .  (lambda () 
                                  (let ((re '()))
                                    (mapatoms 
                                     (lambda (ele)
                                       (when (funcall ,pred ele)
					 (push (symbol-name ele) re))))
                                    (sort re 'string-lessp))))
                 (delayed)
                 (action . (("describe" . (lambda (c)
                                            (,action (intern c))))))
		 )
		)
	 )
  )

(defmacro make-anything-caller (name source)
  `(defun ,name () (interactive)
     (let ((anything-sources (list ,source)))
       (anything)
       )
     )
  )


(make-anything-c-source anything-c-source-describe-functions (lambda (e) (fboundp e)) describe-function)
(make-anything-c-source anything-c-source-describe-variables (lambda (e) (boundp e)) describe-variable)
(make-anything-c-source anything-c-source-describe-face      (lambda (e) (facep e)) describe-face)

(make-anything-caller anything-describe-function anything-c-source-describe-functions)
(make-anything-caller anything-describe-variable anything-c-source-describe-variables)
(make-anything-caller anything-describe-face     anything-c-source-describe-face)



;;------------------------------------------------------------------------------
;; global key bind
;;------------------------------------------------------------------------------


;; anything のバインド
(global-set-key (kbd "C-x C-a") 'anything)


;; [yank の機能拡張] kill-ring バッファを参照できる
(global-set-key (kbd "C-x C-y") 'anything-show-kill-ring)


;; suspend-frame を無効化
;; anythingではpreview操作で C-zを多用するが、マップされてないモードで C-zを押した場合、最小化されてウザイので無効化
(global-unset-key (kbd "C-z"))


;; occur 乗っ取り
(global-set-key (kbd "M-s") 'anything-c-moccur-occur-by-moccur)
;; 標準インクリメンタルサーチのキーバインドに追加
(define-key isearch-mode-map (kbd "C-o") 'anything-c-moccur-from-isearch)
(define-key isearch-mode-map (kbd "C-M-o") 'isearch-occur)


;; C-z を他のキーに割り当て
;;(define-key anything-map (kbd "C-;") 'anything-execute-persistent-action)
;;(define-key anything-map (kbd "M-;") 'anything-execute-persistent-action)


;; ミニバッファだと 'C-h' で文字を消せない問題
;; anything-map だけ設定すると、'C-h' > delete-backward-char は思い通りの動作にならない事がある
;; 発生原因は不明だが、 何らかのanything系コマンドに絡んでいる
;; define-key による 'C-h' > delete-backward-char を実現するには
;; anything で使用される全ての map に再割り当ての必要がある
;; ※ anything-.*map$ は全て anything-map からのコピーなので、
;;    anything-map だけ解決されていれば問題ないはず？
;;    anything-map は minibuffer-local-map からのコピーを使用している。
;; 
;; keyboard-translate によって delete-backward-char を実現している場合、下記の再割り当ては必要ない
;; C-w で単語削除も追加
(dolist (map (list
              anything-map
              anything-c-moccur-anything-map
              anything-c-buffer-map
              anything-find-files-map
              anything-c-read-file-map
              anything-generic-files-map
              anything-c-grep-map
              anything-c-pdfgrep-map
              anything-c-etags-map
              anything-eval-expression-map
              anything-c-ucs-map
              anything-c-bookmark-map
              anything-esh-on-file-map
              )
	     )
  (define-key map (kbd "C-h") 'delete-backward-char)
  (define-key map (kbd "C-w") 'backward-kill-word)
  )





(provide 'setup.anything)
;;--------------------------------------------------------------------------------------------------
;; EOF
