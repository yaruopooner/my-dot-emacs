;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2011/08/09.16:03:42


;;==============================================================================
;; USER C/C++ library use keywords addition at c-mode                           
;;==============================================================================


(defun user-cpp-library-face-keyword-extension ()
    "USER C library keywords Extension Mode. face connection & keyword set."
    (interactive)

; keyword の設定
; 正規表現により設定します。
;    (setq sce-library-keyword_type "\\(sceVu0[IF]VECTOR\\|sceVu0FMATRIX\\|ktFMATRIX\\)")
    (let (
	  user-cpp-library-keyword_type
	  font-lock-extension_user-cpp-library_keyword-list
	  )
      
        (setq user-cpp-library-keyword_type "BOOL\\|u_char\\|u_int\\|u_long\\|char\\|int\\|long")


; keyword と face の関連付け
; face 実体指定の変数と keyword を設定した変数を関連付ける。
; list の第 2パラメータには正規表現の何番目の括弧 (\( と \) のペア) に囲まれた正規表現に
;  match したかを指定する。普通は1番目の括弧に対応すればよいので 1 を設定する。
	(setq font-lock-extension_user-cpp-library_keyword-list
	      (list
	       (list user-cpp-library-keyword_type 0 'user-face_cc-mode_variable 'keep)
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
	(font-lock-add-keywords 'c-mode font-lock-extension_user-cpp-library_keyword-list)
    )
)
   

;;------------------------------------------------------------------------------
;; EOF
