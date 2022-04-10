;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2014/09/25.03:09:48


;;==============================================================================
;; font-lock setup                                                              
;;==============================================================================


(require 'font-lock)





;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; fast-lock は emacs23では使われなくなっている

;; フォントロックモード
(setq font-lock-support-mode 'jit-lock-mode)


;; フォントバッファ最大サイズを指定
;; (setq font-lock-maximum-size (* 16 1024 1024))


;; 遅延ロックモード
;; (setq font-lock-support-mode 'lazy-lock-mode)

;; フォント表示化遅延時間
;; (setq lazy-lock-defer-time 0)



;; 各モード毎にmin/maxを再設定
;; decoration-lv increase/decrease関数の結果をclampするのに使う
(defvar font-lock:decoration-lv-min 1)
(defvar font-lock:decoration-lv-max 3)

;; デフォルト装飾レベルは最大
(setq font-lock-maximum-decoration `(
                                     (t        . ,font-lock:decoration-lv-max)
                                     ;; (c++-mode . ,font-lock:decoration-lv-max)
                                     ;; (c-mode   . ,font-lock:decoration-lv-max)
                                     ))




;; レベルのクランプ
(defun font-lock:clamp-decoration-lv (lv)
  (deu:clamp-min-max lv font-lock:decoration-lv-min font-lock:decoration-lv-max))



;; 現在の装飾レベルを取得
(defun font-lock:get-decoration-lv ()
  "Font-Lock : get decoration level."

  (interactive)
  (let ((lv (font-lock-value-in-major-mode font-lock-maximum-decoration)))
    (when (eq lv t)
      (setq lv font-lock:decoration-lv-max))
    (message "font-lock:decoration-lv => %d" lv)
    lv))


;; 現在の装飾レベルを変更
(defun font-lock:set-decoration-lv (lv)
  "Font-Lock : set decoration level."

  (interactive "nDecoration-LV: ")
  (let ((mode (assq major-mode font-lock-maximum-decoration)) (lv (font-lock:clamp-decoration-lv lv)))
    (if mode
        (setcdr mode lv)
      (add-to-list 'font-lock-maximum-decoration `(,major-mode . ,lv)))
    (message "font-lock:decoration-lv <= %d" lv)
    lv))



(defun font-lock:increase-decoration-lv ()
  (interactive)
  (font-lock:set-decoration-lv (1+ (font-lock:get-decoration-lv))))

(defun font-lock:decrease-decoration-lv ()
  (interactive)
  (font-lock:set-decoration-lv (1- (font-lock:get-decoration-lv))))



;; バッファを再更新
(defun font-lock:reflesh-buffer ()
  "Font-Lock : reflesh buffer."
  (interactive)
  (funcall major-mode))


;; バッファ装飾レベルを変更＆反映
(defun font-lock:reflesh-buffer-by-decoration-lv (lv)
  "Font-Lock : change all buffer decoration level."
  (interactive "nDecoration-LV: ")
  (font-lock:set-decoration-lv lv)
  (font-lock:reflesh-buffer))

;; (defun font-lock:reflesh-buffer-by-decoration-lv (&optional lv)
;;   "Font-Lock : change all buffer decoration level."
;;   (interactive "sDecoration-LV: ")
;;   ;; 入力がない場合はリフレッシュだけをさせたい
;;   (let ((lv lv))
;;     (when (stringp lv)
;;       (if (integerp (string-match "^[0-9]$" lv))
;;       (setq lv (string-to-number lv))
;;     (message "illegal input value!")
;;     )
;;       )
;;     (when (integerp lv)
;;       (font-lock:set-decoration-lv lv)
;;       )
;;     )
;;   (funcall major-mode)
;;   )



;; カレントバッファの装飾レベルを変更＆反映
(defun font-lock:reflesh-current-buffer-by-decoration-lv (lv)
  "Font-Lock : change current buffer decoration level."

  (interactive "nDecoration-LV: ")
  (let ((font-lock-maximum-decoration (copy-tree font-lock-maximum-decoration)))
    (font-lock:reflesh-buffer-by-decoration-lv lv)
    ))






;;------------------------------------------------------------------------------
;; add hook                                                                     
;;------------------------------------------------------------------------------


;; 関連づけるものはここに記述する
(add-hook 'font-lock-mode-hook
          '(lambda ()
             ))







(provide 'font-lock.config)
;;------------------------------------------------------------------------------
;; EOF
