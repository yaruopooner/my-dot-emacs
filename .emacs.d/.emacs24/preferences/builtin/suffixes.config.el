;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2015/07/02.21:59:23


;;==============================================================================
;; Suffixes Connection                                                          
;;==============================================================================


;; 呼び出すモードおよび、関連ずける関数の定義を記述
;; (defun html-mode-hook-functions ()
;;    (turn-on-font-lock)
;; )



;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; Suffixes <---> Mode  Connection                                              
(setq auto-mode-alist (append '(
                                ("\\.grep$"            . compilation-mode)
                                ("\\.\\(org\\|txt\\)$" . org-mode)
                                ("\\.\\(json\\|js\\)$" . js2-mode)
                                ("\\.xml$"             . xml-mode)
                                ("\\.html?$"           . html-helper-mode)
                                ("\\.pl$"              . perl-mode)
                                ) auto-mode-alist))




;; xml-mode
(autoload 'xml-mode "psgml" "Major mode to edit XML files." t)


;; html-helper-mode
(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)


;; /plugins/html-helper-mode.el で使用されている変数
;; 新規html ファイルを開いたときにバッファに
;; html-helper-mode.el で定義されているテンプレートをインサートする
(setq html-helper-build-new-buffer nil)



;;------------------------------------------------------------------------------
;; add hook                                                                     
;;------------------------------------------------------------------------------


;; html-helper-mode
(add-hook 'html-mode-hook '(lambda () (turn-on-font-lock)))

;; perl-mode
(add-hook 'perl-mode-hook '(lambda () (turn-on-font-lock)))







(provide 'suffixes.config)
;;------------------------------------------------------------------------------
;; EOF
