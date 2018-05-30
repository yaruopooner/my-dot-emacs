;;; -*- mode: emacs-lisp ; coding: utf-8-unix ; lexical-binding: nil -*-
;;; last updated : 2013/04/06.04:13:30



;; condition に改行コードが含まれていることがあるので対処する必要がある
;; これを評価すると
;; 
;; "props : '$(GenerateManifest)' == 'true' AND '$(EmbedManifest)'=='true' AND ('$(CLRSupport)'=='false' or '$(CLRSupport)'=='') AND
;;       ('$(ConfigurationType)'=='Application' OR '$(ConfigurationType)'=='DynamicLibrary' )  name : ConfigurationType, value : DynamicLibrary"
;; 
;; "reach value."
;; 
;; "props : '$(GenerateManifest)' == 'true' AND '$(EmbedManifest)'=='true' AND ('$(CLRSupport)'=='false' or '$(CLRSupport)'=='') AND
;;       ('DynamicLibrary'=='Application' OR 'DynamicLibrary'=='DynamicLibrary' )  name : CLRSupport, value : false"
;; 
;; "reach value."
;; 
;; "props : '$(GenerateManifest)' == 'true' AND '$(EmbedManifest)'=='true' AND ('false'=='false' or 'false'=='') AND
;;       ('DynamicLibrary'=='Application' OR 'DynamicLibrary'=='DynamicLibrary' )  name : EmbedManifest, value : true"
;; 
;; "reach value."
;; 
;; "props : '$(GenerateManifest)' == 'true' AND 'true'=='true' AND ('false'=='false' or 'false'=='') AND
;;       ('DynamicLibrary'=='Application' OR 'DynamicLibrary'=='DynamicLibrary' )  name : GenerateManifest, value : true"
;; 
;; "cond : 'true' == 'true' AND 'true'=='true' AND ('false'=='false' or 'false'=='') AND
;;       ('DynamicLibrary'=='Application' OR 'DynamicLibrary'=='DynamicLibrary' ) "
;; 
;; ↓のようになってしまう
;; "$t "
;; 
;; "$tAND
;; $t"

;; プロパティに以下のものが登録されていた
;; ("OutDir" . "$(OutDir)/")
;; ("IntDir" . "$(IntDir)/")
;; この場合このプロパティを評価すると、無限ループになり OutDir///////////////////
;; となってしまう。
;; 本来のOutDir はどこに定義されている？
;; OutDir IntDir をプロパティとしてもっているプロジェクトファイルを探す


(eval-when-compile (require 'cl))
(require 'xml)



(setq project:reserved-properties '(
									))

(setq project:default-properties '(
								   ("VCTargetsPath"				.		"C:/Program Files (x86)/MSBuild/Microsoft.Cpp/v4.0/")
								   ("UserRootDir"				.		"")
								   ("Configuration"				.		"Release")
								   ("Platform"					.		"Win32")
								   ("MSBuildToolsPath"			.		"C:/Windows/Microsoft.NET/Framework64/v4.0.30319")
								   ("MSBuildToolsVersion"		.		"4.0")
								   ("MSBuildExtensionsPath"		.		"C:/Program Files (x86)/MSBuild")
								   ("MSBuildThisFile"			.		"")
								   ))


(defvar project:global-properties nil)

(defvar project:path nil)
(defvar project:properties nil)
(defvar project:item-definitions nil)
(defvar project:items nil)
(defvar project:imports nil)





(defun project:match-variables (value pattern)
  (let* (
		 ;; (value "c:\\$(VCTargetsPath)\\Microsoft%(Platform).Cpp.Default.props/$(VCTargetsPath1)/data.cpp")
		 (value-len (length value))
		 (index 0)
		 (properties)
		 ;; string-match で大文字小文字のチェックをしないようにする？
		 ;; (case-fold-search nil)
		 )
	(while (string-match pattern value index)
	  ;; (print "while into project:match-variables")
	  (setq index (match-end 0))
	  ;; (print (match-string 0 value))
	  ;; (add-to-list 'properties (match-string 0 value) t)
	  ;; (add-to-list 'properties (match-string 0 value))
	  (add-to-list 'properties (match-string 1 value))
	  )
	properties
	)
  )


(defun project:match-properties (value)
  (project:match-variables value "[$](\\([^)]+\\))")
  ;; (project:match-variables value "\\($([^)]+)\\)")
  )

(defun project:match-metadatas (value)
  (project:match-variables value "[%](\\([^)]+\\))")
  )

(defun project:match-items (value)
  (project:match-variables value "[@](\\([^)]+\\))")
  )


(defun project:evaluate-property (value)
  (let* (
		 properties
		 variable-value
		 )

	;; 対応するpropertyが、 immediateではなくpropertyの場合があるので
	;; 全てがimmediateになるまで再帰的にプロパティを評価する必要がある
	(while (> (length (setq properties (project:match-properties value))) 0)
	  ;; (print "while into project:evaluate-property")

	  (dolist (variable-name properties)
		;; get variable-value
		;; (print (format "variable : name = %s" variable-name))
		(setq variable-value (project:get-variable-value variable-name project:properties))
		;; (print (format "variable : value = %s" variable-value))
		;; (print (format "variable : name = %s : value = %s" variable-name variable-value))
		(unless variable-value
		  (print (format "property:%s is not found. return empty string." variable-name))
		  (setq variable-value "")
		  )

		;; replace variable-name to variable-value
		(print (format "props : [name, value] = [%s, %s]" value variable-name variable-value))
		(setq value (replace-regexp-in-string (format "[$](%s)" variable-name) variable-value value t))
		
		)
	  )
	value
	)
  )

(defun project:evaluate-metadata (value)
  value
  )

(defun project:evaluate-items (value)
  value
  )

;; 文字列内のプロパティを評価する
(defun project:evaluate-value (value)
  (interactive "P")

  (setq value (replace-regexp-in-string "\\\\" "/" value))
  (setq value (project:evaluate-property value))
  (setq value (project:evaluate-metadata value))
  (setq value (project:evaluate-items value))
  value
  )


;; Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'"
;; Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')"
;; ' 'の区間にマッチするパターン
;; "'[^']*'"
;; 
;; $() の区間
;; "$(\\([^)]+\\))"
;; 
;; operator ==
;; "\\('[^']*'\\)==\\('[^']*'\\)"
;; "$\\([0-9]+\\)\\(\\s-\\)*==\\(\\s-\\)*$\\([0-9]+\\)"
;; "$\\([0-9]+\\)\\(?:\\s-\\)*\\(!=\\)\\(?:\\s-\\)*$\\([0-9]+\\)"
;; "$\\([0-9]+\\)\\(?:\\s-*\\)\\(!=\\)\\(?:\\s-*\\)$\\([0-9]+\\)"
;; 
;; operator !=
;; "\\('[^']*'\\)!=\\('[^']*'\\)"
;;
;; operator exists
;; "\\(Exists\\|HasTrailingSlash\\)('[^']*')"
;; "\\(Exists\\|HasTrailingSlash\\)(\\('[^()]+\\))"
;; "\\(Exists\\|HasTrailingSlash\\)(\\([^()]+\\))"
;;
;; operator <, >, <=, >=
;; "\\(\\(?:0x\\)?[0-9]+\\)<=\\(\\(?:0x\\)?[0-9]+\\)"
;;
;; operator AND OR
;; "\\(.+\\) \\(AND\\|OR\\) \\(.+\\)"
;;
;; operator !
;; "!\\([^=\)]+)\\)"
;; "!\\([^=(]+\\)?(\\([^)]+\\))"
;; "!Exists('hogehoge') AND !HasTrailingSlash('aaaaa') OR !('abc'=='bcd')"
;; match0 : operator name
;; match1 : operand
;;
;; operator ()
;; "(\\([^()]+\\))"
;; "(\\('[^()]+\\))"
;; "(\\([^()]+\\))"
;; extract most inside of operand
;;
;; conditionを評価するフェーズ
;; 1. Condition.String の評価
;;    evaluate-value で評価して一切変数を含まない状態へと変換する
;;    "'$(Configuration)|$(Platform)'=='FastDebug|x64'"
;;    ↓
;;    "'Release|x64'=='FastDebug|x64'"
;;
;;    "!Exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')"
;;    ↓
;;    "!Exists('\Microsoft.Cpp.x64.user.props')"
;; 
;; 2. リテラルの抽出と置き換え
;;    '.*' クォーテーション部分を抽出して変数リテラルに置換する
;;    "'Release|x64'=='FastDebug|x64'"
;;    ↓
;;    "$0==$1"
;;
;;    $0 = 'Release|x64'
;;    $1 = 'FastDebug|x64'
;;
;;    "!Exists('\Microsoft.Cpp.x64.user.props')"
;;    ↓
;;    "!Exists($2)"
;;
;;    $2 = '\Microsoft.Cpp.x64.user.props'
;;
;; 3. オペレーターの抽出
;;    (.*) による優先順位決定
;;   最も内側から評価する
;; "(\\([^()]+\\))"
;; これにより括弧がネストされている場合は、最内部が抽出される
;; 括弧が、優先順位括弧かそれ以外かを判定する
;; 優先順位でないかつ、括弧の直前に配置されるオペレーター（前置オペレーターとする）は !,Exist,HasTrailingSlash の３つのみ
;; Exist,HasTrailingSlash はオペランドが文字列固定
;; ! はオペランドが論理値のみ
;; () もまた論理値のみ
;; よって、() を抽出して前置オペレーターが!か空文字のときのみ、
;; ()に対して、次のオペレーターがないかどうか評価する
;; - primary operator
;;   Exist HasTrailingSlash
;;   == != < > <= >=
;; - secondary operator
;;   ! ()
;;   AND OR
;; セカンダリはオペランドに論理値をとるため、オペランドが先に評価されなければならない
;; プライマリは必ず左右にオペランドとなるリテラルが配置されている
;; ただし、 < > <= >= は文字列リテラルではなく数値リテラルなので、この時点で変数に置換されていない
;; オペレーター実行時にオペランドを文字列として扱うか数値として扱うかを選択する
;; このフェーズで最小単位のオペレーターとオペランドに分解されたはず
;;
;; 4. オペレーターの評価
;; オペレーターのリザルトは必ずboolean
;; booleanをみて、評価したオペレーターとオペランド一式を論理リテラルに置き換えていく
;;    "$0==$1"
;;    ↓
;;    "$false"
;; 
;;    "!Exists($2)"
;;    ↓
;;    "!($true)"
;;
;;    ( ('123'!='456') OR !Exists('ab(c)') )
;;    ↓
;;    ( ($0!=$1) OR !Exists($2) )
;;    ↓
;;    ( ($true) OR !($false) )
;;    ↓
;;    ( $true OR $true )
;;    ↓
;;    ( $true )
;;    ↓
;;    $true
;;    



(defun project:_extract-literals-0 (expression)
  (let* (
		 (pattern "'\\([^']*\\)'")
		 (literals)
		 (count 0)
		 ;; (eval-expression (replace-regexp-in-string pattern
		 ;; 											(lambda (match)
		 ;; 											  (prog1
		 ;; 												  (format "$%d" count)
		 ;; 												(setq literals (append literals `(,(match-string 1 expression))))
		 ;; 												(setq count (1+ count))))
		 ;; 											expression))
		 (eval-expression expression)
		 )
	(while (string-match pattern eval-expression)
	  ;; (print "while into project:_extract-literals-0")
	  (setq literals (append literals `(,(match-string 1 eval-expression))))
	  (setf (substring eval-expression (match-beginning 0) (match-end 0)) (format "$%d" count))
	  (setq count (1+ count))
	  )

	(print literals)
	(print (format "eval-expression : %s" eval-expression))
	literals
	)
  )


(defun project:_extract-literals (expression)
  (let* (
		 (pattern "'\\([^']*\\)'")
		 (literals)
		 (count 0)
		 )
	(while (string-match pattern expression)
	  ;; (print "while into project:_extract-literals")
	  (setq literals (append literals `(,(match-string 1 expression))))
	  (setf (substring expression (match-beginning 0) (match-end 0)) (format "$%d" count))
	  (setq count (1+ count))
	  )

	;; (print (format "eval-expression : %s" expression))
	;; (print literals)
	`(
	  (expression . ,expression)
	  (literals . ,literals)
	  )
	)
  )


(defun project:_extract-operand-strings (expression)
  (let* (
  		 (pattern "\\(?:\\s-*\\)\\([!=][=]\\)\\(?:\\s-*\\)")
		 (operands (split-string expression pattern t))
		 (lhs (string-to-number (substring (nth 0 operands) 1)))
		 (rhs (string-to-number (substring (nth 1 operands) 1)))
  		 )
	`(,lhs ,rhs)
	;; (dolist (operand operands)
	;;   (setq result (append result `(,(string-to-number (substring operand 1)))))
	;;   )
	)
  )

(defun project:_extract-operand-numbers (expression)
  (let* (
  		 (pattern "\\(?:\\s-*\\)\\([<>][=]?\\)\\(?:\\s-*\\)")
		 (operands (split-string expression pattern t))
		 (decimal)
		 (result)
  		 )

	(dolist (operand operands)
	  (setq decimal 10)
	  (when (and (< 2 (length operand)) (string-equal (substring operand 0 2) "0x"))
	  	(setq operand (substring operand 2))
	  	(setq decimal 16)
	  	)
	  (setq operand (string-to-number operand decimal))
	  (setq result (append result `(,operand)))
	  )
	result
	)
  )

(defun project:_extract-operand-function-argument (expression)
  (let* (
  		 (pattern "[$]\\([0-9]+\\)")
  		 )
  	(string-match pattern expression)
	`(,(string-to-number (match-string 1 expression)))
	)
  )

(defun project:_extract-operand-negate-argument (expression)
  (let* (
  		 (pattern "[$]\\(t\\|nil\\)")
  		 )
  	(string-match pattern expression)
	`(,(intern (match-string 1 expression)))
	)
  )


(defun project:_extract-operand-bools (expression)
  (let* (
  		 (pattern "\\(?:\\s-*\\)\\(AND\\|OR\\)\\(?:\\s-*\\)")
		 (operands (split-string expression pattern t))
		 (lhs (intern (substring (nth 0 operands) 1)))
		 (rhs (intern (substring (nth 1 operands) 1)))
  		 )
	`(,lhs ,rhs)
	)
  )




;; オペレーターの並び順通りに評価されます
;; プリミティブなオペレーターから先に評価し、booleanなどは評価を後ろにする必要があります
(setq project:_condition-operator-extractors-table '(
													 ;; compare strings
													 (
													  (pattern . "[$][0-9]+\\s-*\\([!=][=]\\)\\s-*[$][0-9]+")
													  (operand . project:_extract-operand-strings)
													  )
													 ;; compare numbers
													 (
													  (pattern . "\\(?:0x\\)?[0-9]+\\s-*\\([<>][=]?\\)\\s-*\\(?:0x\\)?[0-9]+")
													  (operand . project:_extract-operand-numbers)
													  )
													 ;; function
													 (
													  (pattern . "\\(Exists\\|HasTrailingSlash\\)([^()]+)")
													  (operand . project:_extract-operand-function-argument)
													  )
													 ;; negate bool
													 (
													  (pattern . "\\(!\\)\\(?:\\s-*\\)[$]\\(?:t\\|nil\\)")
													  (operand . project:_extract-operand-negate-argument)
													  )
													 ;; compare bools
													 (
													  (pattern . "[$]\\(?:t\\|nil\\)\\s-*\\(AND\\|OR\\)\\s-*[$]\\(?:t\\|nil\\)")
													  (operand . project:_extract-operand-bools)
													  )
													 ))



(defmacro project:_operator-compare-immediates (func literals operands)
  `(lambda (literals operands)
	 (funcall ,func (car operands) (cadr operands))
	 ))

(defmacro project:_operator-compare-literals (func literals operands)
  `(lambda (literals operands)
	 (funcall ,func (nth (car operands) literals) (nth (cadr operands) literals))
	 ))

(defmacro project:_operator-function (func literals operands)
  `(lambda (literals operands)
	 (funcall ,func (nth (car operands) literals))
	 ))


(setq project:_condition-operators-table `(
										   ;; compare strings
										   ("=="				.		,(project:_operator-compare-literals 'string= literals operands))
										   ("!="				.		,(project:_operator-compare-literals (lambda (lhs rhs)
																											   (not (string= lhs rhs)))
																											 literals operands))
										   ;; compare numbers
										   ("<"					.		,(project:_operator-compare-immediates '< literals operands))
										   (">"					.		,(project:_operator-compare-immediates '> literals operands))
										   ("<="				.		,(project:_operator-compare-immediates '<= literals operands))
										   (">="				.		,(project:_operator-compare-immediates '>= literals operands))
										   ;; function
										   ("Exists"			.		,(project:_operator-function 'file-exists-p literals operands))
										   ("HasTrailingSlash"	.		,(project:_operator-function (lambda (arg)
																									   (integerp (string-match "[/\\]$" arg)))
																									 literals operands))
;; 										   ))

;; (setq project:_condition-bool-operators-table `(
										   ;; compare booleans
										   ("!"					.		,(project:_operator-compare-immediates (lambda (lhs rhs) (not lhs)) literals operands))
										   ("AND"				.		,(project:_operator-compare-immediates (lambda (lhs rhs) (and lhs rhs)) literals operands))
										   ("OR"				.		,(project:_operator-compare-immediates (lambda (lhs rhs) (or lhs rhs)) literals operands))
										   ))


(defun project:_evaluate-condition-primitive-operators (expression literals)
	(dolist (map project:_condition-operator-extractors-table)
	  ;; (print (format "operator-extractor : %s" map))
	  (let* (
			 (operator-pattern (cdr (assq 'pattern map)))
			 (operand-extractor (cdr (assq 'operand map)))
			 match-expression
			 begin-index
			 end-index
			 operator-name
			 operands
			 result
			 )

		(while (string-match operator-pattern expression)
		  ;; (print "while into project:_evaluate-condition-primitive-operators")
		  (setq begin-index (match-beginning 0))
		  (setq end-index (match-end 0))
		  (setq match-expression (match-string 0 expression))
		  (setq operator-name (match-string 1 expression))
		  
		  (setq operands (funcall operand-extractor match-expression))

		  (setq result (funcall (cdr (assoc-string operator-name project:_condition-operators-table t)) literals operands))
		  ;; (print (format "operator-name : %s" operator-name))

		  (setf (substring expression begin-index end-index) (format "$%s" result))
		  )
		)
	  )
	expression
  )

(defun project:_evaluate-condition-operators (expression literals)
  (let* (
		 (brackets-pattern "(\\([^()]+\\))")
		 begin-index
		 end-index
		 match-expression
		 )

	;; まずプリミティブオペレーターを評価
	;; (setq expression (project:_evaluate-condition-primitive-operators expression literals))
	;; (print (format "b-expression : %s" expression))

	;; 論理オペレーターをブラケットがなくなるまで評価
	;; プリミティブオペレーターはブラケットペア毎に処理する、また論理オペレーター評価後も処理する
	;; (while (string-match brackets-pattern expression)
	(while (string-match brackets-pattern (setq expression (project:_evaluate-condition-primitive-operators expression literals)))
	  ;; (print "while into project:_evaluate-condition-operators")
	  (setq begin-index (match-beginning 0))
	  (setq end-index (match-end 0))
	  (setq match-expression (match-string 1 expression))
	  ;; (print (format "eval-expression0 : %s" expression))
	  ;; (print (format "[begin, end] : [%d, %d]" begin-index end-index))

	  (print match-expression)
	  ;; (print (format "match-expression0 : %s" match-expression))
	  ;; ブラケット内だけ評価する
	  (setq match-expression (project:_evaluate-condition-primitive-operators match-expression literals))
	  ;; (print (format "match-expression1 : %s" match-expression))

	  (setf (substring expression begin-index end-index) match-expression)
	  ;; (print (format "eval-expression1 : %s" expression))
	  )
	)

  ;; 空白削除
  (setq expression (replace-regexp-in-string "\\s-*" "" expression))
  )


;; 論理式の評価シーケンスサンプル
;; ;; target
;; "( (!$t) AND !( $t OR  $nil ) AND ( ($t) OR $nil ) )"
;; 
;; ;; or and
;; "( (!$t) AND !( $t ) AND ( ($t) OR $nil ) )"
;; ;; !
;; "( ($nil) AND !( $t ) AND ( ($t) OR $nil ) )"
;; ;; ()
;; "( $nil AND !$t AND ( $t OR $nil ) )"
;; ;; loop 2nd
;; ;; or and
;; "( $nil AND !$t AND ( $t ) )"
;; ;; !
;; "( $nil AND $nil AND ( $t ) )"
;; ;; ()
;; "( $nil AND $nil AND $t )"
;; ;; loop 3rd
;; ;; or and
;; "( $t AND $t )"
;; "( $t )"
;; ;; !
;; "( $t )"
;; ;; ()
;; "$t"



(defun project:parse-condition (expression)
  (let* (
		 (extracted-value (project:_extract-literals expression))
		 (eval-expression (cdr (assq 'expression extracted-value)))
		 (literals (cdr (assq 'literals extracted-value)))
		 (result (project:_evaluate-condition-operators eval-expression literals))
		 )
	(print result)
	(string= result "$t")
	)
  )




;; ノードのコンディションを評価する
(defun project:evaluate-condition (expression)
  (if (null expression)
	  ;; expression == nil の場合は expression がないので無条件パス
	  t
	;; ある場合は判定する必要がある
	(progn
	  (setq expression (project:evaluate-value expression))
	  (print (format "cond : %s" expression))
	  (project:parse-condition expression)
	  )
	)
  )


;; metadata table sample
;; テーブルは全てシンボルではなく文字列にする
;; 理由：key値がシンボルでは許可されない文字列になることがあるのため
(defvar project:items-sample '(
							   (ProjectConfiguration . (
													   ("Debug|Win32" . (
														(Configuration . "Debug")
														(Platform . "Win32")
														))
													   ("Release|Win32" . (
														(Configuration . "Release")
														(Platform . "Win32")
														))
													   ("Debug|x64" . (
														(Configuration . "Debug")
														(Platform . "x64")
														))
													   ("Release|x64" . (
														(Configuration . "Release")
														(Platform . "x64")
														))
													   ))
							   ))


(defvar project:item-defs-sample '(
								   (ClCompile . (
												 (PrecompiledHeader. "")
												 (MultiProcessorCompilation . "true")
												 (MinimalRebuild . "false")
												 ))
								   (Link . (
											(SubSystem . "Windows")
											))
							   ))
;; metadata へのアクセス
;; ClCompile.MultiProcessorCompilation
;; ClCompile.MinimalRebuild
;; 末端かどうかを判別するには末端の値がリストかどうかを識別すればよい
;; (create-meta-path "" 'ClCompile project:item-defs-sample)
;; (get-value project:item-defs-sample "ClCompile.MultiProcessorCompilation")
;; '.' をトークンとして分解する必要がある
;; (split-string "ClCompile.MultiProcessorCompilation" "\\.")

(defun project:get-variable-value (path candidates)
  (project:get-variable-value-recursive (split-string path "\\." t) candidates)
  )

(defun project:get-variable-value-recursive (path candidates)
  (let* (
		 ;; (key (intern (first path)))
		 (key (first path))
		 ;; (children (assq key candidates))
		 ;; (value (rest (assq key candidates)))
		 (value (assoc-default key candidates))
		 (next-path (rest path))
		 )

	;; (print (format "key = %s" key))
	;; (print (format "value = %s" value))
	;; (print (format "next-path = %s" next-path))

	(cond
	 ;; continue
	 ;; p==t & v==list
	 ((and next-path value (listp value))
	  (project:get-variable-value-recursive next-path value)
	  )
	 ;; 与えられたパスで candidates 末端まで到達
	 ;; p==f & v==atom
	 ((and (null next-path) value (nlistp value))
	  (print "reach value.")
	  value
	  )
	 ;; 与えられたパスで candidates が見つからない
	 ((or (null value) (and next-path value (nlistp value)))
	  (print "property path not found.")
	  nil
	  )
	 ;; 与えられたパスで到達した candidates が値ではなくリスト（つまりまだ候補がある）
	 ((and value (listp value))
	  (print "reach property path. but candidates is not value.")
	  nil
	  )
	 (t
	  (print "unknown condition.")
	  nil
	  )
	 )
	))


;; (defun create-meta-path (name key candidates)
;;   (let (
;; 		(children (assq key candidates))
;; 		))
;;   (setq name (format "%s.%s" name key))
  
;;   (if (listp children)
;; 	  (create-meta-path name key children)
;; 	`(,name . ,children)
;; 	  )

;;   )


;; parser table
(defconst project:parser-maps '(
								(PropertyGroup			.		project:parse-property)
								(Property				.		project:parse-property)
								(ItemDefinitionGroup	.		project:parse-item-definition)
								(ItemGroup				.		project:parse-item)
								(ImportGroup			.		project:parse-import-group)
								(Import					.		project:parse-import)
								))




(defun project:parse-property (node)
  (print (format "property:parse %s" (xml-node-name node)))

  (let* (
		 (attrs (xml-node-attributes node))
		 (condition (rest (assq 'Condition attrs)))
		 (children (xml-node-children node))
		 )
	;; (print children)
	;; (print (format "Name:%s" (xml-node-name root)))

	(when (project:evaluate-condition condition)
	  (dolist (child children)
		(when (listp child)
		  ;; (print child)
		  (let* (
				 (key (xml-node-name child))
				 (value (xml-node-name (xml-node-children child)))
				 exist-property
				 )
			;; (print key)
			;; (print value)
			(print (format "property:eval = [%s, %s]" key value))

			(when (symbolp key)
			  (setq key (symbol-name key))
			  )

			;; (if (not value)
			;; 	;; 値がない場合は空文字をセット
			;; 	(setq value "")
			;;   ;; パス系のバックスラッシュはここで全て置き換えておく
			;;   (setq value (replace-regexp-in-string "\\\\" "/" value))
			;;   )
			(when value
			  ;; パス系のバックスラッシュはここで全て置き換えておく
			  (setq value (replace-regexp-in-string "\\\\" "/" value))
			  ;; valueにプロパティがある場合はここで評価しておく必要がある
			  (setq value (project:evaluate-property value))
			  )

			;; 重複がある場合は削除
			;; (when (setq exist-property (assoc-string key project:properties))
			;;   (print (format "remove property[key, value] : [%s, %s]" key (cdr exist-property)))
			;;   (setq project:properties (delete exist-property project:properties))
			;;   )
			;; (add-to-list 'project:properties `(,key . ,value))

			;; ユーザー側から与えられる上書き不可のプロパティ project:global-properties を定義する
			;; project:global-properties はプロジェクトパース開始時に project:properties にコピーされる
			;; コピーされたプロパティを上書きしてよいかは、プロパティがグローバルプロパティであるかどうかをチェックする必要がある
			;; project:properties のフォーマットにグローバルであるかのフラグをいれるのはちょっと無駄臭いので
			;; project:global-properties をチェックさせるようにする、 project:global-properties のオブジェクト数はそんなに多くないと思うのでたぶん大丈夫・・
			;; 予約済みプロパティも同様？いちおう予約済みもグローバルへコピーしているので一括処理でＯＫのはず
			(unless (assoc-string key project:global-properties)
			;; どっちがいい？
			  (if (setq exist-property (assoc-string key project:properties))
				  (progn
					(print (format "property:del  < [%s, %s]" key (cdr exist-property)))
					(setcdr exist-property value)
					)
				(add-to-list 'project:properties `(,key . ,value))
				)

			  (print (format "property:add  > [%s, %s]" key value) )
			  )
			)
		  )
		)
	  )
	)
  )

(defun project:parse-item-definition (node)
  (print (format "item-definition %s" (xml-node-name node)))
  )

(defun project:parse-item (node)
  (print (format "item %s" (xml-node-name node)))
  
  )

(defun project:parse-import-group (node)
  (print (format "import group %s" (xml-node-name node)))

  (let* (
		 (attrs (xml-node-attributes node))
		 (condition (rest (assq 'Condition attrs)))
		 (children (xml-node-children node))
		 )
	;; (print (format "Name:%s" (xml-node-name root)))

	(when (project:evaluate-condition condition)
	  (dolist (child children)
		(when (listp child)
		  (project:parse-import child)
		  )
		)
	  )
	)
  )


(defun project:parse-import (node)
  (print (format "import %s" (xml-node-name node)))
  (let* (
		 (attrs (xml-node-attributes node))
		 (condition (rest (assq 'Condition attrs)))
		 (file-name (rest (assq 'Project attrs)))
		 path
		 )


	(print file-name)

	(when (project:evaluate-condition condition)
	  (project:parse-project file-name)
	  )
	)
  )


(defun project:parse-project (path)
  ;; need file exist check
  ;; (print (format "load project: %s" (expand-file-name file project:path)))
  (print (format "load project: %s" path))

  ;; 文字列内のプロパティを評価する
  (setq path (project:evaluate-value path))
  ;; 相対パスなら絶対パスに変換
  (unless (file-name-absolute-p path)
	(setq path (expand-file-name path project:path))
	)

  (if (file-exists-p path)
	(let* (
		   (project (xml-parse-file path))
		   (root (first project))
		   (children (xml-node-children root))
		   (prev-path project:path)
		   )
	  ;; 現在パース中のプロジェクトファイルパスを記録
	  ;; ネストされている過去のパスはバックアップしておき、関数を抜けるときに復旧
	  (setq project:path (file-name-directory path))

	  (print (format "load project path: %s" path))
	  ;; (print (format "Name:%s" (xml-node-name root)))

	  (dolist (node children)
		(when (listp node)
		  ;; (xml-node-name node)
		  ;; (xml-node-children node)
		  ;; (xml-node-attributes node)
		  ;; (cadr (xml-node-children (xml-node-name root)))

		  (let* (
				 (name (xml-node-name node))
				 (parser (assq name project:parser-maps))
				 )
			;; (print (format "Child-Name:%s" name))
			
			(if parser
				(funcall (rest parser) node)
			  (print (format "unknown node %s" name))
			  )
			)
		  )
		)
	  (setq project:path prev-path)
	  (print (format "load project exit: %s" path))
	  t
	  )
	nil
	)
  )


(defun project:parse (full-path)
  (interactive "P")

  (setq project:path (file-name-directory full-path))

  ;; MSBuild default property copy
  ;; (setq project:properties project:global-properties)
  (setq project:global-properties (append project:reserved-properties project:default-properties))

  ;; (setq project:properties (copy-tree project:global-properties))
  (setq project:properties project:global-properties)

  ;; (project:parse-project (file-name-nondirectory full-path))
  (project:parse-project full-path)
)




(provide 'msbuild-parser)
;;--------------------------------------------------------------------------------------------------
;; EOF
