;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/09/04.04:48:53

;;==============================================================================
;; Font Environment                                                             
;; for Win32                                                                    
;;==============================================================================

;(deu:load-library-auto-select-platform-path "bdf-font.el" path-basic-configuration)


;; 現在適用されているフォントを調べるには下記のいずれか
;; M-x describe-variable fontset-alias-alist
;; (symbol-value 'fontset-alias-alist)
;; (identity fontset-alias-alist)
;;
;; 現在のシステムで利用可能なフォント一覧
;; (prin1-to-string (x-list-fonts "*"))
;; 
;; フォント設定は 'XLFD表現' で表される
;; http://ja.wikipedia.org/wiki/XLFD


;(cond
;  (window-system
;    (set-default-font "Courier New-10")
;    ;; Japanese(japanese-jisx0208)font
;    (set-fontset-font
;      (frame-parameter nil 'font)
;      'japanese-jisx0208
;      (font-spec :family "Meiryo" :size 12)
;      ;;'("Meiryo" . "unicode-bmp")
;    )
;  )
;)


;; 表示テスト確認用
;;                       set
;;0
;; 0
;;A
;; A
;;a
;; a
;;あ
;; あ
;; ああ
;;ア
;; ア
;;亜
;; 亜
;; 123456789012345678901234567890123456789012
;; 英文字フォント英文字フォント英文字フォント
   ;; 123456789012345678901234567890123456789012
   ;; 英文字フォント英文字フォント英文字フォント
;; 1234567890
;; 英英英英英
;; 文文文文文
;; 字字字字字
;; フフフフフ
;; ォォォォォ
;; ンンンンン
;; トトトトト


;; -Courier New/Consolas
;;  欧文フォント:等幅

;; -ＭＳ ゴシック/VL ゴシック:
;;  欧文フォント:等幅
;;  和文フォント:等幅

;; -メイリオ:
;;  欧文フォント:プロポーショナル
;;  和文フォント:等幅



;; XLFD表現
;; FontNameRegistry-Foundry-Family-WeightName-Slant-SetwidthName-AddStyleName-PixelSize-PointSize-ResolutionX-ResolutionY-Spacing-AverageWidth-CharSetRegistry-CharSetEncoding



;; fontset name generator
(defun generate-fontset-registry-name (family)
  (concat "myfont:" family)
)



(defun generate-fontset-name (family)
  (concat "fontset-" (generate-fontset-registry-name family))
)



(defun setup-my-fontset (xlfd-format single-byte-font-family multi-byte-font-family)
  (unless (null (x-list-fonts single-byte-font-family))
    ;; single byte charset
    (create-fontset-from-ascii-font (format xlfd-format single-byte-font-family) nil (generate-fontset-registry-name single-byte-font-family))

    (when multi-byte-font-family
      (unless (null (x-list-fonts multi-byte-font-family))
        ;; multi byte charset
        (set-fontset-font (generate-fontset-name single-byte-font-family) 'katakana-jisx0201        `(,multi-byte-font-family . "jisx0201-katakana"))
        (set-fontset-font (generate-fontset-name single-byte-font-family) 'japanese-jisx0208        `(,multi-byte-font-family . "jisx0208-sjis"))
        (set-fontset-font (generate-fontset-name single-byte-font-family) 'japanese-jisx0212        `(,multi-byte-font-family . "jisx0212-sjis"))
;        (set-fontset-font (generate-fontset-name single-byte-font-family) 'japanese-jisx0213.2004-1 `(,multi-byte-font-family . "jisx0213.2004-1-sjis"))
        )
      )
    )
  )




;; (setq-default line-spacing 2)
;; (setq scalable-fonts-allowed t)

;; イタリックやボールドフォントを標準フォントから作成する
(setq w32-enable-synthesized-fonts t)


;; iso8859-1 -> 等幅(width&height 1:1維持)
;; iso10646-1 -> emacs23.x では非推奨 frame-parameter height & width が上書きされる現象が発生, emacs24.x では直っている
;(defvar my-xlfd-format (format "-outline-%%s-normal-r-normal-normal-12-*-*-*-*-*-%s" "iso8859-1"))
(defvar my-xlfd-format "-outline-%s-normal-r-normal-normal-12-*-*-*-*-*-iso8859-1")
(setup-my-fontset my-xlfd-format "Courier New" "ＭＳ ゴシック")
(setup-my-fontset my-xlfd-format "Consolas" "ＭＳ ゴシック")
(setup-my-fontset my-xlfd-format "VL ゴシック" nil)
(setup-my-fontset my-xlfd-format "メイリオ" nil)




;; scaling
(setq face-font-rescale-alist '(
				(".*ＭＳ ゴシック.*"  . 1.1)
				(".*VL ゴシック.*"  . 1.1)
				(".*メイリオ.*"  . 1.2)
				)
      )


;(deu:set-default-frame-parameter 'font (generate-fontset-name "Courier New"))
(deu:set-default-frame-parameter 'font (generate-fontset-name "Consolas"))
;(deu:set-default-frame-parameter 'font (generate-fontset-name "VL ゴシック"))
;(deu:set-default-frame-parameter 'font (generate-fontset-name "メイリオ"))





;; 英文字フォント
;; (set-face-attribute 'default nil
;; 		    :foundry "outline"
;; 		    :family "メイリオ"
;; 		    :width 'normal
;; 		    :height 90
;; 		    :slant 'normal
;; 		    :weight 'normal
;; 		    :inherit nil
;; 		    :stipple nil
;; 		    ;;		      :background "#000060"
;; 		    ;;		      :foreground "#ffffff"
;; 		    :inverse-video nil
;; 		    :box nil
;; 		    :strike-through nil
;; 		    :overline nil
;; 		    :underline nil
;; 		    )








(provide 'win32/font.config)
;;------------------------------------------------------------------------------
;; EOF
