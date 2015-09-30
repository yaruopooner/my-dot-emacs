(eval-when-compile
  (require 'color-theme))

(defun color-theme-bg-white-based ()
  "user default theme : background color is white based."
  (interactive)

  ;; allowed filter
  (let ((color-theme-legal-frame-parameters "\\(alpha\\|color\\|mode\\|left\\|top\\|width\\|height\\|font\\)"))
    
    (color-theme-install
     '(color-theme-bg-white-based
       ;; begin-------------------- frame parameters(default-frame-alist) --------------------
       (
	;; 左上点のＸ座標
	;;(left                 . 70)
	;; 左上点のＹ座標
	;;(top                  . 15)
	;; 横幅
	;;(width                . 250)
	;; 縦幅
	;;(height               . 70)
	;; アクティブ/非アクティブ ウィンドウ透明度
	(alpha                . (1.0 0.8) )
	;; フレームカラー (Background はBlue = 0x50~0x80 あたりが適色)
	(foreground-color     . "#000000" )
	(background-color     . "#fffff0" )
	;; ノーマルカーソルカラー
	(cursor-color         . "black" )
	;; マウスカーソル表示色
	(mouse-color          . "MediumPurple" )
	;; 選択しているフレームの境界色
	(border-color         . "red1" )
	)
       ;; end---------------------- frame parameters(default-frame-alist) --------------------


       (default                               ((t   (nil))))


       ;; begin-------------------- misc --------------------
       ;; default-frame-alist の値が優先される
       ;; (cursor                                ((t   ( :foreground nil :background "black" :weight normal :slant normal ))))
       ;; (mouse                                 ((t   ( :foreground nil :background "MediumPurple" :weight normal :slant normal ))))
       ;; (border                                ((t   ( :foreground nil :background "red1" :weight normal :slant normal ))))

       ;; フレーム左右の縁取りバー（hideshowvisや折り返し記号が表示される部分）
       (fringe                                ((t   ( :foreground unspecified :background "DeepSkyBlue1" ))))

       ;; 選択範囲
       (region                                ((t   ( :foreground nil :background "gray" :weight normal :slant normal ))))

       ;; ハイライトのデフォルト値です。ハイライト関連の初期値になります
       (highlight                             ((t   ( :foreground nil :background "DarkOliveGreen" :weight normal :slant normal ))))
       ;; 汎用ハイライト
       (lazy-highlight                        ((t   ( :foreground nil :background "PaleTurquoise4" :weight normal :slant normal ))))

       ;; バッファ上部でスクロールしても動かない部分。タブ等が表示される(Inherit > mode-line)
       (header-line                           ((t   ( :foreground "black" :background "DarkSlateGray1" :weight normal :slant normal :box unspecified :inherit mode-line ))))

       ;; 対応した括弧の色
       (show-paren-match                      ((t   ( :foreground nil :background "SteelBlue3" :weight normal :slant normal ))))
       ;; 対応に失敗している括弧の色
       (show-paren-mismatch                   ((t   ( :foreground "white" :background "purple" :weight normal :slant normal ))))
       ;; end---------------------- misc --------------------


       ;; begin-------------------- mode-line --------------------
       ;; モードライン
       (mode-line                             ((t   ( :foreground "white" :background "black" :weight normal :slant normal ))))
       ;; モードライン（アクティブでないバッファ）(Inherit > mode-line)
       (mode-line-inactive                    ((t   ( :foreground "white" :background "black" :weight normal :slant normal :box unspecified :inherit mode-line ))))
       ;; モードラインに表示されているバッファ名の色
       (mode-line-buffer-id                   ((t   ( :foreground nil :background nil :weight bold :slant normal ))))
       ;; モードラインでの強調部の色
       (mode-line-emphasis                    ((t   ( :foreground nil :background nil :weight bold :slant normal ))))
       ;; モードラインのハイライト
       (mode-line-highlight                   ((t   ( :foreground nil :background nil :weight normal :slant normal ))))
       ;; end---------------------- mode-line --------------------

       
       ;; begin-------------------- whitespace-mode --------------------
       ;; 空白の色
       (whitespace-space                      ((t   ( :foreground "DarkOliveGreen3" :background unspecified :weight bold :slant unspecified :underline nil ))))
       (whitespace-hspace                     ((t   ( :inherit whitespace-space ))))
       (whitespace-tab                        ((t   ( :inherit whitespace-space ))))
       (whitespace-newline                    ((t   ( :inherit whitespace-space ))))
       (whitespace-trailing                   ((t   ( :inherit whitespace-space ))))
       (whitespace-line                       ((t   ( :inherit whitespace-space ))))
       (whitespace-space-before-tab           ((t   ( :inherit whitespace-space ))))
       (whitespace-indentation                ((t   ( :inherit whitespace-space ))))
       (whitespace-empty                      ((t   ( :inherit whitespace-space ))))
       (whitespace-space-after-tab            ((t   ( :inherit whitespace-space ))))
       ;; 行末の半角スペースの色
       ;; (trailing-whitespace                   ((t   ( :inherit whitespace-space ))))
       ;; end---------------------- whitespace-mode --------------------


       ;; begin-------------------- isearch --------------------
       (isearch                               ((t   ( :foreground "black" :background "green1" :weight normal :slant normal ))))
       (isearch-fail                          ((t   ( :foreground nil :background "red4" :weight normal :slant normal ))))
       ;; end---------------------- isearch --------------------


       ;; begin-------------------- dired-mode --------------------
       ;; ディレクトリカラー
       (dired-directory                       ((t   ( :foreground "DeepSkyBlue1" :background nil :weight bold :slant normal ))))
       ;; (dired-flagged                         ((t   ( :foreground nil :background nil :weight normal :slant normal ))))
       ;; (dired-header                          ((t   ( :foreground nil :background nil :weight normal :slant normal ))))
       ;; (dired-ignored                         ((t   ( :foreground nil :background nil :weight normal :slant normal ))))
       ;; (dired-mark                            ((t   ( :foreground nil :background nil :weight normal :slant normal ))))
       ;; (dired-marked                          ((t   ( :foreground nil :background nil :weight normal :slant normal ))))
       ;; (dired-perm-write                      ((t   ( :foreground nil :background nil :weight normal :slant normal ))))
       ;; (dired-symlink                         ((t   ( :foreground nil :background nil :weight normal :slant normal ))))
       ;; (dired-warning                         ((t   ( :foreground nil :background nil :weight normal :slant normal ))))
       ;; end---------------------- dired-mode --------------------


       ;; begin-------------------- font-lock-mode --------------------
       ;; cc-mode 等、 programming用face
       ;; 組み込み系
       (font-lock-builtin-face                ((t   ( :foreground nil :background nil :weight bold :slant normal :underline nil ))))
       ;; コメント
       (font-lock-comment-face                ((t   ( :foreground "black" :background "#c0c0c0" :weight bold :slant normal :underline nil ))))
       ;; コメント区切り(Inherit > font-lock-comment-face)
       (font-lock-comment-delimiter-face      ((t   ( :foreground nil :background nil :weight unspecified :slant unspecified :underline unspecified :inherit font-lock-comment-face ))))
       ;; 定数＆ラベル
       (font-lock-constant-face               ((t   ( :foreground "#008000" :background nil :weight bold :slant normal :underline nil ))))
       ;; ドキュメント(Inherit > font-lock-string-face)
       (font-lock-doc-face                    ((t   ( :foreground nil :background nil :weight unspecified :slant unspecified :underline unspecified :inherit font-lock-string-face ))))
       ;; 関数定義部分
       (font-lock-function-name-face          ((t   ( :foreground "black" :background nil :weight bold :slant normal :underline nil ))))
       ;; 制御文＆識別子＆指定子＆型修飾子＆記憶クラス指定子
       (font-lock-keyword-face                ((t   ( :foreground "#8080ff" :background nil :weight bold :slant normal :underline nil ))))
       ;; 文字
       (font-lock-negation-char-face          ((t   ( :foreground "#800000" :background nil :weight bold :slant normal :underline nil ))))
       ;; プリプロセッサ(Inherit > font-lock-builtin-face)
       (font-lock-preprocessor-face           ((t   ( :foreground nil :background nil :weight unspecified :slant unspecified :underline unspecified :inherit font-lock-builtin-face ))))
       ;; 正規表現(Inherit > bold)
       (font-lock-regexp-grouping-construct   ((t   ( :foreground "#800000" :background nil :weight bold :slant normal :underline nil ))))
       ;; 正規表現バックスラッシュ(Inherit > bold)
       (font-lock-regexp-grouping-backslash   ((t   ( :foreground nil :background nil :weight bold :slant normal :underline nil ))))
       ;; 文字列
       (font-lock-string-face                 ((t   ( :foreground "#800000" :background nil :weight bold :slant normal :underline nil ))))
       ;; 型指定子＆構造体宣言部＆クラス宣言部
       (font-lock-type-face                   ((t   ( :foreground "blue1" :background nil :weight bold :slant normal :underline nil ))))
       ;; 変数名宣言部
       (font-lock-variable-name-face          ((t   ( :foreground nil :background nil :weight normal :slant normal :underline nil ))))
       ;; 警告
       (font-lock-warning-face                ((t   ( :foreground "pink" :background nil :weight bold :slant normal :underline nil ))))
       ;; end---------------------- font-lock-mode --------------------


       ;; begin-------------------- semantic-mode --------------------
       (semantic-decoration-on-includes                   ((t   ( :foreground nil :background nil :weight normal :slant normal :underline nil ))))
       (semantic-decoration-on-private-members-face       ((t   ( :foreground nil :background "#200000" :weight normal :slant normal :underline nil ))))
       (semantic-decoration-on-protected-members-face     ((t   ( :foreground nil :background "#000020" :weight normal :slant normal :underline nil ))))
       (semantic-decoration-on-unknown-includes           ((t   ( :foreground nil :background "#900000" :weight normal :slant normal :underline nil ))))
       (semantic-decoration-on-unparsed-includes          ((t   ( :foreground nil :background "#555500" :weight normal :slant normal :underline nil ))))
       (semantic-highlight-edits-face                     ((t   ( :foreground nil :background "gray20" :weight normal :slant normal :underline nil ))))
       (semantic-highlight-func-current-tag-face          ((t   ( :foreground nil :background "DarkSlateGray1" :weight normal :slant normal :underline nil ))))
       (semantic-tag-boundary-face                        ((t   ( :foreground nil :background nil :weight normal :slant normal :underline nil :overline "cyan1" ))))
       (semantic-unmatched-syntax-face                    ((t   ( :foreground nil :background nil :weight normal :slant normal :underline "red1" ))))
       ;; end---------------------- semantic-mode --------------------


       ;; begin-------------------- flymake-mode --------------------
       (flymake-errline                       ((t   ( :foreground nil :background "red3" :weight normal :slant normal :underline nil ))))
       (flymake-warnline                      ((t   ( :foreground nil :background "orange3" :weight normal :slant normal :underline nil ))))
       ;; end---------------------- flymake-mode --------------------

       
       ;; begin-------------------- plugin:auto-complete-mode --------------------
       (ac-completion-face                    ((t   ( :foreground "DarkGray" :background nil :weight normal :slant normal :underline "white" ))))
       ;; popup's overwrite faces
       (ac-candidate-face                     ((t   ( :foreground "black" :background "LightGray" :weight normal :slant normal :underline nil ))))
       (ac-selection-face                     ((t   ( :foreground "white" :background "LightGray" :weight normal :slant normal :underline nil ))))
       (ac-gtags-candidate-face               ((t   ( :foreground "navy" :background "LightGray" :weight normal :slant normal :underline nil ))))
       (ac-gtags-selection-face               ((t   ( :foreground "white" :background "navy" :weight normal :slant normal :underline nil ))))
       (ac-yasnippet-candidate-face           ((t   ( :foreground "black" :background "SandyBrown" :weight normal :slant normal :underline nil ))))
       (ac-yasnippet-selection-face           ((t   ( :foreground "white" :background "coral3" :weight normal :slant normal :underline nil ))))

       ;; popup's default faces
       (popup-face                            ((t   ( :foreground "black" :background "LightGray" :weight normal :slant normal :underline nil ))))
       (popup-isearch-match                   ((t   ( :foreground nil :background "SkyBlue" :weight normal :slant normal :underline nil ))))
       (popup-menu-face                       ((t   ( :foreground "black" :background "LightGray" :weight normal :slant normal :underline nil ))))
       (popup-menu-selection-face             ((t   ( :foreground "white" :background "SteelBlue" :weight normal :slant normal :underline nil ))))
       (popup-scroll-bar-foreground-face      ((t   ( :foreground nil :background "black" :weight normal :slant normal :underline nil ))))
       (popup-scroll-bar-background-face      ((t   ( :foreground nil :background "gray" :weight normal :slant normal :underline nil ))))
       (popup-tip-face                        ((t   ( :foreground "black" :background "khaki1" :weight normal :slant normal :underline nil ))))
       ;; end---------------------- plugin:auto-complete-mode --------------------


       ;; begin-------------------- plugin:hideshowvis --------------------
       (hideshowvis-hidable-face              ((t   ( :foreground "white" :background unspecified :box t :inherit fringe))))
       ;; end---------------------- plugin:hideshowvis --------------------


       ;; begin-------------------- plugin:navi --------------------
       (navi-file                             ((t   ( :foreground "black" :background unspecified :weight bold))))
       (navi-func                             ((t   ( :foreground "SteelBlue" :background unspecified :weight bold))))
       (navi-mode                             ((t   ( :foreground "navy" :background unspecified :weight bold))))
       ;; end---------------------- plugin:navi --------------------
       )
     )
    )
  )
