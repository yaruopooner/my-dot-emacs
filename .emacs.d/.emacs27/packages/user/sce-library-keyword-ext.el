;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2012/09/25.20:28:57


;;==============================================================================
;; SCE C library use keywords addition at c-mode                                
;;==============================================================================


(defun sce-library-face-keyword-extension ()
    "SCE library keywords Extension Mode. face connection & keyword set."
    (interactive)

; keyword の設定
; 正規表現により設定します。
;    (setq sce-library-keyword_type "\\(sceVu0[IF]VECTOR\\|sceVu0FMATRIX\\|ktFMATRIX\\)")
    (let (
	  sce-library-keyword_type
	  kt-library-keyword_type
	  font-lock-extension_sce-library_keyword-list
	  )
      
        (setq sce-library-keyword_type "sceVu0\\([FI]VECTOR\\|FMATRIX\\)")
	(setq kt-library-keyword_type "kt\\([FI]Vector\\|FMatrix\\)P?")


; keyword と face の関連付け
; face 実体指定の変数と keyword を設定した変数を関連付ける。
; list の第 2パラメータには正規表現の何番目の括弧 (\( と \) のペア) に囲まれた正規表現に
;  match したかを指定する。普通は1番目の括弧に対応すればよいので 1 を設定する。
	(setq font-lock-extension_sce-library_keyword-list
	      (list
	       (list sce-library-keyword_type 0 'user-face_cc-mode_variable 'keep)
	       (list kt-library-keyword_type 0 'user-face_cc-mode_variable 'keep)
	       )
	      )


; hook 関数を書く
; major mode に fontlock の設定を追加する関数を書く。
; この例では font-lock-defaults という変数を local-variable (この
;  major mode 内でのみ有効な変数) として設定し、この変数に fontlock の対象となる 
; keyword のリストを設定する。そして最後に fontlock を有効にする。
;    (make-local-variable 'font-lock-defaults)
;    (setq font-lock-defaults '(sce-font-lock-keywords))
;    (font-lock-mode t)


;; 作成した拡張キーワードリストを登録
	(font-lock-add-keywords 'c-mode font-lock-extension_sce-library_keyword-list)
    )
)
   

;;------------------------------------------------------------------------------
;; EOF
