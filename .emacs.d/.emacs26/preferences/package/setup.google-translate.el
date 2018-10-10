;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2018/10/10.17:35:27


;;==================================================================================================
;; google-translate setup                                                                                    
;;==================================================================================================


;; load path addition
;; (add-to-list 'load-path (expand-file-name "text-translator/" de:path-plugins))



;;------------------------------------------------------------------------------
;; load                                                                         
;;------------------------------------------------------------------------------


(require 'google-translate)
(require 'google-translate-smooth-ui)



;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; use proxy
;; プロキシに対応しており, デフォルトで環境変数 HTTP_PROXY を参照する


(defvar google-translate-english-chars "[:ascii:][:punct:]"
  "これらの文字が含まれているときは英語とみなす")

(defun google-translate-enja-or-jaen (&optional string)
  "regionか、現在のセンテンスを言語自動判別でGoogle翻訳する。"
  (interactive)

  (setq string
        (cond ((stringp string) string)
              (current-prefix-arg
               (read-string "Google Translate: "))
              ((use-region-p)
               (buffer-substring-no-properties (region-beginning) (region-end)))
              (t
               (save-excursion
                 (let (s)
                   (forward-char 1)
                   (backward-sentence)
                   (setq s (point))
                   (forward-sentence)
                   (buffer-substring-no-properties s (point)))))))
  (let* ((asciip (string-match
                  (format "\\`[%s]+\\'" google-translate-english-chars)
                  string)))
    (run-at-time 0.1 nil 'deactivate-mark)
    (google-translate-translate (if asciip "en" "ja") (if asciip "ja" "en") string)))


(global-set-key (kbd "C-c t") 'google-translate-enja-or-jaen)





(provide 'setup.google-translate)
;;--------------------------------------------------------------------------------------------------
;; EOF
