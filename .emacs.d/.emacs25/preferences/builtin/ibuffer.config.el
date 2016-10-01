;;; -*- mode: emacs-lisp ; coding: utf-8-unix -*-
;;; last updated : 2013/07/27.15:13:46


;;==================================================================================================
;; ibuffer setup                                                                                    
;;==================================================================================================

;; 昔は plugin だったが Emacs 23 から内部に取り込まれた

(require 'ibuf-ext)





;;------------------------------------------------------------------------------
;; basic setting                                                       
;;------------------------------------------------------------------------------


;; ibuffer を別フレーム表示にする
(setq ibuffer-use-other-window t)


;; ?
(setq ibuffer-expert t)


;; ibuffer 表示フォーマット
(setq ibuffer-formats '(
                        (mark modified read-only
                              ;; " " (name   35 -1 :left)
                              " " (name   45 45 :left)
                              " " (coding 13 13 :left)
                              " " (size    8 -1 :right)
                              " " (mode   16 16 :left)
                              " " filename-and-process)
                        (mark
                         ;; " " (name   35 -1 :left)
                         " " (name   45 45 :left)
                         " " (coding 13 13 :left)
                         " " filename)
                        ))


;; 表示フォーマットでCodingを表示するモードを追加
(define-ibuffer-column
  ;; ibuffer-formats に追加した文字
  coding
  ;; ibuffer menuに表示される一行目の文字
  (:name " Coding ")
  ;; 以下に文字コードを返す関数を書く
  (if (coding-system-get buffer-file-coding-system 'mime-charset)
      (format " %s" (coding-system-get buffer-file-coding-system 'mime-charset))
    " undefined"))


;; バッファリストのフィルタリング設定
(setq ibuffer-saved-filter-groups
      '(
        ("default"
         ("Code : C/C++" (or
                          (mode . c++-mode)
                          (mode . c-mode)
                          ))

         ("Code : C#"  (mode . csharp-mode))

         ("Code : Objective-C"  (mode . objc-mode))

         ("Code : Lisp" (or
                         (mode . emacs-lisp-mode)
                         (mode . lisp-mode)
                         ))

         ("Code : Java" (or
                         (mode . java-mode)
                         (mode . js-mode)
                         ))

         ("Code : lua"  (mode . lua-mode))

         ("Code : Shell Script"  (or
                                  (mode . sh-mode)    
                                  (mode . powershell-mode)))

         ("snippet"  (mode . snippet-mode))

         ("Doc : Org" (mode . org-mode))

         ("Doc : XML" (or 
                       (mode . nxml-mode)
                       (mode . xml-mode)
                       ))

         ("Makefile" (or
                      (mode . makefile-automake-mode)
                      (mode . makefile-bsdmake-mode)
                      (mode . makefile-gmake-mode)
                      (mode . makefile-imake-mode)
                      (mode . makefile-makepp-mode)
                      (mode . makefile-mode)
                      ))

         ("Dired" (mode . dired-mode))
         
         ;; ("emacs-config" (or
         ;;           (filename . ".emacs.d")
         ;;           (filename . "emacs-config")
         ;;           ))

         ("Web Dev" (or
                     (mode . html-mode)
                     (mode . css-mode)
                     ))

         ("Subversion" (name . "\*svn"))
         ("Magit" (name . "\*magit"))

         ("Grep" (mode . grep-mode))
         ("Compilation" (mode . compilation-mode))

         ("MSVC" (name . "\*MSVC "))
         ("Anything Gtags" (name . "\*anything gtags\*"))

         ("Default : Emacs" (name . "\*.*\*$"))

         ;; ("Help" (or
         ;;       (name . "\*Help\*")
         ;;       (name . "\*Apropos\*")
         ;;       (name . "\*info\*")
         ;;       ))
         )
        )
      )



;; 空グループを表示設定
(setq ibuffer-show-empty-filter-groups nil)



;;------------------------------------------------------------------------------
;; add hook                                                                     
;;------------------------------------------------------------------------------


;; バッファモード時の behavior追加
(add-hook 'ibuffer-mode-hook
          '(lambda ()
             ;; buffer list auto up to date
             (ibuffer-auto-mode 1)
             ;; filter groups
             (ibuffer-switch-to-saved-filter-groups "default")
             ))


;; (custom-set-variables
;;  '(ibuffer-mode-hook '(ibuffer-auto-mode))
;;  )





(provide 'ibuffer.config)
;;--------------------------------------------------------------------------------------------------
;; EOF
