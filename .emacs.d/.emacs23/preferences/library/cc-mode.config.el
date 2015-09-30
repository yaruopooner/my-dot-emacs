;;; -*- Mode: Emacs-Lisp ; Coding: utf-8-unix -*-
;;; last updated : 2012/05/06.12:08:09


;;==============================================================================
;; C/C++/Java Misc Mode  Extension & Connection                                 
;;==============================================================================



;;------------------------------------------------------------------------------
;; C/C++ Keyword Extensions                                                     
;;------------------------------------------------------------------------------



;;------------------------------------------------------------------------------
;; Function <---> File  autoload & connection                                   
;;------------------------------------------------------------------------------


;; c-mode
(autoload 'c-mode "cc-mode" "C Edit Mode" t)
;; c++-mode
(autoload 'c++-mode "cc-mode" "C++ Edit Mode" t)
;; java-mode
(autoload 'java-mode "cc-mode" "Java Edit Mode" t)

;; user-cpp-mode
;;(autoload 'user-cpp-library-face-keyword-extension "user-cpp-library-keyword-ext" "USER C library keywords Extension Mode" t)



;;------------------------------------------------------------------------------
;; cc-mode Extension                                                             
;;------------------------------------------------------------------------------


;; http://www.geocities.co.jp/SiliconValley-Bay/9285/EMACS-JA/emacs_257.html#SEC258
;; or
;; describe-variable c-offsets-alist


(defun cc-mode-setup ()
  (interactive)

  ;;キーバインド
  ;; (define-key c-mode-map "\177" 'backward-delete-char) 
  ;; (define-key c++-mode-map "\177" 'backward-delete-char)

  ;; 動的略語展開では大文字小文字を区別(t:しない,nil:する)
  (make-variable-buffer-local 'dabbrev-case-fold-search)
  (setq dabbrev-case-fold-search nil)
  ;; 略語の大文字小文字のパターンを保存(t:する,nil:しない)
  (make-variable-buffer-local 'dabbrev-case-replace)
  (setq dabbrev-case-replace nil)


  ;; mode behavior setting
  (setq tab-width 4)
  (setq c-basic-offset 4)             ;字下げ

  ;; インデントは3つのモードがあります
  ;; 1. 自動インデントなし
  ;;    インデント量はすべてユーザが明示的に空白やTABコードを入れて行います。
  ;; 2. 半自動インデント
  ;;    [TAB]キーを押した場合にはその行が、[C-j]による改行を実施した場合には次の行がインデントされます。
  ;; 3. 全自動インデント     
  ;;    中括弧、セミコロン、コロン、改行などを入力した時点でその行がインデントされ、さらに自動的に改行が挿入され、次の行のインデント位置にキャレットが移動します。
  (setq c-auto-newline t)             ;全自動インデント設定(t:enable, nil:disable)
  (setq c-tab-always-indent nil)      ;半自動インデント設定 [TAB]or[C-i] キーで(t:インデント実施, nil:TABコードを入力)
  ;; (setq indent-tabs-mode t)           ;インデントは空白文字で行う（TABコードを空白に変換）

  ;; 字下げスタイルの変更 
  (setq c-offsets-alist
	'(
	  (string . -1000)                ;複数行におよぶ文字列の内側
	  (c . c-lineup-C-comments)       ;複数行におよぶCスタイルのブロックコメントの内側
	  (defun-open . 0)                ;関数定義を開始する中括弧
	  (defun-close . 0)               ;関数定義を終了する中括弧
	  (defun-block-intro . +)         ;トップレベルの関数定義の最初の行
	  (class-open . 0)                ;クラス定義を開始する中括弧
	  (class-close . 0)               ;クラス定義を終了する中括弧
	  (inline-open . 0)               ;クラス内のインラインメソッドを開始する中括弧
	  (inline-close . 0)              ;クラス内のインラインメソッドを終了する中括弧
	  (extern-lang-open . 0)          ;外部言語ブロックを開始する中括弧
	  (extern-lang-close . 0)         ;外部言語ブロックを終了する中括弧
	  (func-decl-cont . +)            ;関数定義の引数リストと関数定義の本体を開始する中括弧のあいだの領域。
					  ;ただし、K&R版の関数定義を除く。
					  ;Cでは、この部分に空文字やコメント以外は置けない。
					  ;C++やJavaでは、throws宣言などを置ける。 
	  (knr-argdecl-intro . 5)         ;K&R版Cの引数宣言の最初の行
	  (knr-argdecl . 0)               ;K&R版Cの引数宣言の2行目以降
	  (topmost-intro . 0)             ;最上位の言語構成要素の最初の行
	  (topmost-intro-cont . 0)        ;最上位の言語構成要素の2行目以降
	  (member-init-intro . +)         ;（構造体の）メンバ初期化リストの最初の行
	  (member-init-cont . 0)          ;（構造体の）メンバ初期化リストの2行目以降
	  (inher-intro . +)               ;多重継承リストの最初
	  (inher-cont . c-lineup-multi-inher)      ;多重継承リストの2行目以降
	  ;; (inher-cont . +)                ;多重継承リストの2行目以降
	  (block-open . 0)                ;文ブロックを開始する中括弧
	  (block-close . 0)               ;文ブロックを終了する中括弧
	  (brace-list-open . 0)           ;enumのリストや静的配列の初期化リストを開始する中括弧
	  (brace-list-close . 0)          ;enumのリストや静的配列の初期化リストを終了する中括弧
	  (brace-list-intro . +)          ;enumのリストや静的配列の初期化リストの最初の行
	  (brace-list-entry . 0)          ;enumのリストや静的配列の初期化リストの2行目以降
	  (brace-entry-open . nil)        ;行が開き中括弧で始まるときの、 enumのリストや静的配列の初期化リストの2行目以降
	  (statement . 0)                 ;通常の文
	  (statement-cont . +)            ;文の継続行
	  (statement-block-intro . +)     ;新規文ブロックの最初の行
	  (statement-case-intro . +)      ;caseブロックの最初の行
	  (statement-case-open . +)       ;中括弧で始まるcaseブロックの最初の行
	  (substatement . +)              ;if、while、for、 do、elseの直後の最初の行
	  (substatement-open . 0)         ;substatementのブロックを開始する中括弧
	  (case-label . 4)                ;caseまたはdefaultラベルを表す
	  (access-label . -)              ;C++のアクセス指定子private、protected、publicを表す
	  (label . 0)                     ;通常のラベル
	  (do-while-closure . 0)          ;do-while文のwhile
	  (else-clause . 0)               ;if-else文のelse
	  (catch-clause . nil)            ;C++やJavaのtry...catch構成の catch行やfinally行
	  ;; (comment-intro . -1000)         ;コメントの導入部分だけを含んだ行
	  (comment-intro . c-lineup-comment)   ;コメントの導入部分だけを含んだ行
	  (arglist-intro . c-lineup-arglist-intro-after-paren)          ;引数リストの最初の行
	  (arglist-cont . 0)              ;引数リストを開始する括弧の行に引数がない場合、引数リストの2行目以降
	  ;; (arglist-cont-nonempty . +)     ;引数リストを開始する括弧の行に少なくとも1つの引数がある場合、引数リストの2行目以降
	  (arglist-cont-nonempty . c-lineup-arglist)  ;引数リストを開始する括弧の行に少なくとも1つの引数がある場合、引数リストの2行目以降
	  (arglist-close . c-lineup-arglist)          ;引数リストを終了する括-弧
	  (stream-op . c-lineup-streamop) ;ストリーム演算子を用いた式が継続する行
	  (inclass . +)                   ;クラス定義の内側に入れ子になった言語構成要素。字下げは、クラス定義の開き中括弧に相対である
	  (inextern-lang . +)             ;外部言語ブロックの内側に入れ子になった言語構成要素
	  (cpp-macro . -1000)             ;cppマクロの開始
	  (cpp-macro-cont . nil)          ;cppマクロの開始の2行目以降
	  (friend . 0)                    ;C++のfriend宣言
	  (objc-method-intro . -1000)     ;Objective-Cのメソッド定義の最初の行
	  (objc-method-args-cont . c-lineup-ObjC-method-args)  ;Objective-Cのメソッド定義を継続する行
	  (objc-method-call-cont . c-lineup-ObjC-method-call)  ;Objective-Cのメソッド呼び出しを継続する行
	  (namespace-open . nil)          ;namespace開始する中括弧
	  (namespace-close . nil)         ;namespace終了する中括弧
	  (innamespace . nil)             ;namespace中インデント
	  (template-args-cont . +)        ;template定義を継続する行
	  (inlambda . nil)                ;inclassと同様だが、ラムダ（つまり、無名）関数の内側に用いる。 Pikeのみで用いる
	  (lambda-intro-cont . nil)       ;キーワードlambdaと関数本体のあいだの、ラムダ関数のヘッダーの継続行。 Pikeのみで用いる
	  (inexpr-statement . nil)        ;式の内側にある文ブロック。これは、C言語のGNU拡張や、文ブロックを引数としてとるPikeの特殊関数に用いる
	  (inexpr-class . nil)            ;式の内側にあるクラス定義。これは、Javaの無名クラスや無名配列の初期化式に用いる
	  )
	)

  )



;;------------------------------------------------------------------------------
;; hook function
;;------------------------------------------------------------------------------


(defun cc-mode-hook-functions ()
    (cc-mode-setup)
    (setq font-lock-maximum-decoration t)
    (turn-on-font-lock)
)



;;------------------------------------------------------------------------------
;; Suffixes <---> Mode  Connection                                              
;;------------------------------------------------------------------------------


(setq auto-mode-alist
      (append
       '(
	 ;; c-mode
	 ("\\.\\(c\\|h\\)$" . c++-mode)
	 ;; c++-mode
	 ("\\.\\(cpp\\|hpp\\|inl\\|cxx\\|hxx\\)$" . c++-mode)
	 ;; shader-mode
	 ("\\.\\(sch\\|vs\\|vsh\\|fs\\|fsh\\)$" . c++-mode)
	 ;; java-mode
	 ("\\.java$" . java-mode)
	 ) auto-mode-alist)
      )



;;------------------------------------------------------------------------------
;; add hook                                                                     
;;------------------------------------------------------------------------------


(add-hook 'c-mode-common-hook 'cc-mode-hook-functions)





(provide 'cc-mode.config)
;;------------------------------------------------------------------------------
;; EOF
